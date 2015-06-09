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

# License

toml-server is licensed under [The Happy License](https://github.com/jonstoler/The-Happy-License).

```
SUMMARY (IN PLAIN-ENGLISH)

Congratulations, you’ve got something with the best licence ever.

Basically, you’re free to do what you want with it; as long as you do something 
good (help someone out, smile; just be nice), you can use this on anything you 
fancy.

Of course, if it all breaks, it’s totally not the author’s fault.
Enjoy!


THE FULL LICENSE AGREEMENT

By attaching this document to the given files (the “work”), you, the licensee, 
are hereby granted free usage in both personal and commerical environments, 
without any obligation of attribution or payment (monetary or otherwise). The 
licensee is free to use, copy, modify, publish, distribute, sublicence, and/or 
merchandise the work, subject to the licensee inflecting a positive message 
unto someone. This includes (but is not limited to): smiling, being nice, 
saying “thank you”, assisting other persons, or any similar actions percolating 
the given concept.

The above copyright notice serves as a permissions notice also, and may 
optionally be included in copies or portions of the work.

The work is provided “as is”, without warranty or support, express or implied. 
The author(s) are not liable for any damages, misuse, or other claim, whether 
from or as a consequence of usage of the given work.
`
