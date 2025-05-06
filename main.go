package main

import (
    "github.com/valyala/fasthttp"
)

func main() {
    // Listen on :8080 inside the container
    if err := fasthttp.ListenAndServe(":8080", requestHandler); err != nil {
        panic(err)
    }
}

func requestHandler(ctx *fasthttp.RequestCtx) {
    switch string(ctx.Path()) {
    case "/":
        // Respond to GET /
        ctx.SetStatusCode(fasthttp.StatusOK)
        ctx.SetContentType("text/plain; charset=utf-8")
        ctx.WriteString("Hello, World!")
    default:
        ctx.Error("Not Found", fasthttp.StatusNotFound)
    }
}
