package main

import (
	"fmt"
	"net/http"
)

func pingHandler(w http.ResponseWriter, r *http.Request) {
	fmt.Fprintf(w, "pong")
}

func main() {
	http.HandleFunc("/ping", pingHandler)

	fmt.Println("Server starting on port 3000...")
	if err := http.ListenAndServe(":3000", nil); err != nil {
		fmt.Printf("Error starting server: %s\n", err)
	}
}
