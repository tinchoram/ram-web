package main

import (
	"github.com/gofiber/fiber/v2"
	"log"
)

func main() {
	app := fiber.New()

	app.Static("/", "./public")
	// => http://localhost:3000/js/script.js
	// => http://localhost:3000/css/style.css

	app.Static("/static", "./public/static/")
	// => http://localhost:3000/prefix/js/script.js
	// => http://localhost:3000/prefix/css/style.css

	app.Static("*", "./public/index.html")
	// => http://localhost:3000/any/path/shows/index/html

	log.Fatal(app.Listen(":3000"))
}
