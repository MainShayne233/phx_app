# PhxApp

Generator for [Phoenix](https://github.com/phoenixframework/phoenix) apps that use React, Elm, Postgres, no Postgres, etc.

[![Build Status](https://travis-ci.org/MainShayne233/phx_app.svg?branch=master)](https://travis-ci.org/MainShayne233/phx_app)

## Note
Though this generator does have some Phoenix 1.2 support, it has been optimized/developed mostly for [Phoenix 1.3](https://gist.github.com/chrismccord/71ab10d433c98b714b75c886eff17357), which has a very different directory structure, and use `phx` instead of `phoenix` for mix tasks.

## Usage
```bash
mix archive.install github MainShayne233/phx_app # install on your machine

mix phx_app.new app_name # create your app_name, using option flags if desired

cd app_name
mix phx.server
```

## Options
Standard Phoenix Options:
  - `--no-ecto`  Don't use Ecto/Postgres
  - `--umbrella` Use as umbrella app
  - `--module` Define main module (default is the app name argument)
#### Note
  - `--no-html` is not a valid option, since you should just use the normal `phx.new` generator for that

Frontend Options:
  - `--react` For [React.js](https://facebook.github.io/react/) (Default)
  - `--elm` For [Elm](http://elm-lang.org/)
  
Other options:
  - `--1.2` Use the Phoenix 1.2 generator, `mix phoenix.new` (as stated above, 1.2 support is underdeveloped)
