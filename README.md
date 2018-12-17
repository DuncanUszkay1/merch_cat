# MerchCat
Goal: An application that connects merchandise to fan participation through organic channels.

First step: An application that connects the Shopify Api to the Discord client.

Technologies in use:
- Written in Elixir
- Using the Pheonix Framework for the web server
- Using Nostrum for the Discord integration


## Getting Started:
- Install Pheonix (https://hexdocs.pm/phoenix/installation.html)
- Create a discord bot (https://discordapp.com/developers/applications)
- Install that bot onto a test server (make a new one for testing)
- Clone the repo
- Create a file called .env to hold secrets (Do not commit this file) with the following:
```
export DISCORD_BOT_TOKEN="your-discord-bot-token"
export DISCORD_DEFAULT_CHANNEL="a channel id from a test server"
```
For now, all secrets/keys/etc will be placed in here. Add to the readme if you add another required one.
- run the following in the command line in the project directory:
```
mix ecto.create
mix deps.get
source .env
mix phx.server
```
- To test that its working, type "ping!" into the channel you specified in the .env file. Bot should respond.
- Also try hitting the discord ping route, should be http://localhost:4000/api/admin/discord/ping
