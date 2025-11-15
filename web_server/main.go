package main

import (
	_ "embed"
	"html/template"
	"log"
	"net/http"
)

//go:embed web/index.html
var indexHTML string

//go:embed web/style.css
var styleCSS string

func main() {
	tmpl := template.Must(template.New("index").Parse(indexHTML))

	http.HandleFunc("/", func(w http.ResponseWriter, r *http.Request) {
		data := map[string]string{
			"Title": "My first web server on Go",
		}
		tmpl.Execute(w, data)
	})

	http.HandleFunc("/style.css", func(w http.ResponseWriter, r *http.Request) {
		w.Write([]byte(styleCSS))
	})

	log.Println("Сервер запущен на http://localhost:8080")
	log.Fatal(http.ListenAndServe(":8080", nil))
}
