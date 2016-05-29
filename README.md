# discord-reedland

## Description

Disord-Reedland is a Discord Bot Proof of Concept. This is highly experimental code not suited for production.

## Setup

### Ubuntu

1 Install the following debs: "ruby", "ruby-devel"

2 sudo apt-get install libxslt-dev libxml2-dev zlib1g-dev

3 Run: gem install bundler

4 Run: bundle install

5 Do the following

sudo add-apt-repository ppa:chris-lea/libsodium;
sudo echo "deb http://ppa.launchpad.net/chris-lea/libsodium/ubuntu xenial main" >> /etc/apt/sources.list;
sudo echo "deb-src http://ppa.launchpad.net/chris-lea/libsodium/ubuntu xenial main" >> /etc/apt/sources.list;
sudo apt-get update && sudo apt-get install libsodium-dev;

Note: This bot does not use "libsodium18" at the moment. You can discard any warnings about it.

### Registering bot

Remember to register bot with Discord!

https://discordapp.com/oauth2/authorize?&client_id=<id>&scope=bot

Handy URL

https://twentysix26.github.io/Red-Docs/red_guide_bot_accounts/