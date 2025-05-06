package main

import (
	"fmt"
	"log"

	"github.com/valyala/fasthttp"
)

func handler(ctx *fasthttp.RequestCtx) {
	fmt.Fprintf(ctx, "Hello, World!")
}

func main() {
	log.Println("Server starting on port 8080...")
	if err := fasthttp.ListenAndServe(":8080", handler); err != nil {
		log.Fatalf("Error starting server: %s", err)
	}
}