
def process_Info_txt(path, fiction_folder, lang = 'vn')
  genres = ["Classical", "Fairy Tales", "Chiến Trường", "Cổ Đại", "Công Sở", "Cung Đấu",
          "Cung Đình", "Đam Mỹ", "Đoản Văn", "Đồng Nhân", "Điền Văn", "Giang Hồ", "Hài",
          "Hắc Bang", "Hiện Đại", "Hoán Thân", "Huyền Huyễn", "Kiếm Hiệp", "Ngược",
          "Nhân Thú", "Nữ Tôn", "Nữ Phẫn Nam Trang", "NP", "Phúc Hắc Nam", "Quân Nhân",
          "Sắc", "Sủng", "Sư đồ Luyến", "Học đường", "Tiên Hiệp", "Trọng Sinh",
          "Võng Du", "Xuyên Không", "HE", "SE", "OE"]
  trio = ["HE", "SE", "OE"]
  path = path + fiction_folder;

  clojure_hash_string = File.read(path + '/Info.txt')
  ruby_hash_string = clojure_hash_string.gsub(/" /, '"=> ')
  hash = eval(ruby_hash_string)
  hash['language'] = lang;
  hash.delete("chap")

  #process overview file
  overview = File.read(path + '/Overview.txt')
  overview = overview.sub(/Giới Thiệu/, '')
  overview.strip!
  hash['overview'] = overview

  genres_hash_str = hash['genre']
  hash.delete 'genre'
  #fix capitalized letters
  genres_arr = genres_hash_str.split
  genres_arr.map!{ |word|
    if not trio.include?(word)
      word = word + ' '
      word.capitalize
    else
      word
    end
  }
  genres_str = genres_arr.reduce(:+)

  hash['path'] = fiction_folder
  f = Fiction.new(hash)
  f.save

  #add genres
  genres.each do |g|
    if genres_str.include?(g)
      genre = Genre.where(title: g).take
      f.genres << genre
      p genre
    end
   end

  #process each chapter file
  Dir.entries(path).each{ |filename|
    if /[0-9]/.match(filename)
      chapnum = filename.scan(/[0-9]/).reduce(:+)
      chapnum = chapnum.to_i

      body = File.read(path + '/' + filename)

      title = File.foreach(path + '/' + filename).first
      if /[0-9]/.match(title)
        title = File.foreach(path + '/' + filename).first(2)[1]
      end

      chapter = Hash["chapnum" => chapnum, "body" => body, 'title' => title]
      f.chapters.create(chapter)
    end
  }
end

path = "/home/thao/ngontinh/resources/static/Truyen/"
path2 = "/home/thao/ngontinh/resources/static/Stories/"

Dir.entries(path).each{ |folder|
  if folder.include? "_"
    process_Info_txt(path, folder)
  end
}

Dir.entries(path2).each{ |folder|
  if folder.include? "_"
    puts "-------------------------------------------------------------------"
    p folder
    process_Info_txt(path2, folder, 'en')
  end
}

genres.each{ |x|
  Genre.create(title: x)
}

Chapter.all.each { |chap|
  chap.body = chap.body.gsub(/\r\n/, "<br>")
  chap.save
}

