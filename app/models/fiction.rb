class Fiction < ActiveRecord::Base
  has_and_belongs_to_many :genres
  has_many :chapters

  def to_param
    path
  end

  def getImg
    "https://s3.amazonaws.com/ngontinh/Truyen/" + path + "/cover.jpg"
  end
end
