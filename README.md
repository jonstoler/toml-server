# toml-server

> [toml](https://github.com/toml-lang/toml) ripoff of [json-server](https://github.com/typicode/json-server), using LuaSocket

## Requirements

* [LuaSocket](https://github.com/diegonehab/luasocket)
* [lua-toml](https://github.com/jonstoler/lua-toml)

## Usage

	lua server.lua [TOML FILE]

## Example

Create a `server.toml` file

	[[posts]]
	id = 1
	title = "toml-server"
	author = "jonstoler"

	[[comments]]
	id = 1
	body = "some comment"
	postId = 1

Start TOML Server (it will automatically update if you change your toml file)

	toml-server server.toml

Now if you go to http://localhost:3000/posts/1, you'll get

	id = 1
	author = "jonstoler"
	title = "toml-server"

TOML Server only processes GET requests.

## Routes

Based on the previous `server.toml` file, here are all the available routes.

	GET /
	GET /posts
	GET /posts/1
	GET /posts/1/id
	GET /posts/1/title
	GET /posts/1/author
	GET /comments
	GET /comments/1
	GET /comments/1/id
	GET /comments/1/body
	GET /comments/1/postId

There are also built-in special routes in the underscore directory:

	GET /_/kill -> kills the server
	GET /_/dump -> dumps the contents of your toml file, unprocessed
