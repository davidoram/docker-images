package main

import (
	"html"
	"io"
	"log"
	"net/http"
)

func main() {

	http.HandleFunc("/", func(w http.ResponseWriter, r *http.Request) {
		body, err := io.ReadAll(r.Body)
		if err != nil {
			log.Fatal(err)
		}
		log.Printf("URL:  %s/nBody: %s", html.EscapeString(r.URL.Path), string(body))

		// Acknowledge the request, by returning ok
		w.Write([]byte("ok"))
	})
	log.Println("Listening on localhost:8080")
	http.ListenAndServe(":8080", nil)
}
