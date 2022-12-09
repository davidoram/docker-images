package main

import (
	"fmt"
	"io"
	"log"
	"net/http"
)

func echo(w http.ResponseWriter, req *http.Request) {
	log.Print("==================================")
	log.Printf("Method: %v\n", req.Method)
	for name, headers := range req.Header {
		for _, h := range headers {
			fmt.Fprintf(w, "Header: %v: %v\n", name, h)
		}
	}
	// Read the entire body
	body, err := io.ReadAll(req.Body)
	if err != nil {
		log.Fatal(err)
	}

	log.Printf("Body: %v", string(body))
	log.Print("End")
	fmt.Fprintf(w, "ok")
}

func main() {

	http.HandleFunc("/kafka-webhook", echo)
	log.Printf("Listening on :8080")
	http.ListenAndServe(":8080", nil)
}
