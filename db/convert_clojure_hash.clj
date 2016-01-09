(import 'java.io.File)
(use '[clojure.java.shell :only [sh]])

;convert to ruby hash
(doseq [folder (.listFiles (File. "/home/thao/ngontinh/resources/static/Stories"))]
	(let [f 	(str folder "/Info.txt")
			content 	(slurp f)
			hash 	(load-string content)
			dummy 	(spit f hash)]
		(prn (hash "title"))))


;convert to utf-8
(doseq [folder (.listFiles (File. "/home/thao/ngontinh/resources/static/Stories"))]
	(doseq [file (.listFiles folder)]
		(let [path (.getAbsolutePath file)
			out ((sh "file" "-bi" path) :out)]
			(if (.contains out "16")
				(let [content (slurp path :encoding "UTF-16")]
                	(spit path content :encoding "UTF-8"))))))

;convert /r/n to <br>
(doseq [folder (.listFiles (File. "/home/thao/ngontinh/resources/static/Truyen"))]
	(doseq [file (.listFiles folder)]
		(let [path (.getAbsolutePath file)]
			(if (.contains path ".txt")
				(let [content (slurp path)
						new-content (clojure.string/replace content #"\r\n" "<br>")]
                	(spit path new-content))))))



(doseq [folder (.listFiles (File. "/home/thao/Documents/ngontinh-clojure/resources/static/Stories"))]
	(let [f 	(str folder "/Overview.txt")
			encoding (:out (sh "file" "-bi" f))]
		(if (.contains encoding "16")
			(let [content (slurp f "utf-16le")]
			     (spit f s)))))


