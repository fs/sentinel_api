# Sentinel API

[![Build Status](https://semaphoreci.com/api/v1/fs/sentinel_api/branches/master/badge.svg)](https://semaphoreci.com/fs/sentinel_api)
[![Test Coverage](https://codeclimate.com/github/fs/sentinel_api/badges/coverage.svg)](https://codeclimate.com/github/fs/sentinel_api)
[![Code Climate](https://codeclimate.com/github/fs/sentinel_api.png)](https://codeclimate.com/github/fs/sentinel_api)

Sentinel Api is the Phoenix API for Sentinel app.
It's based on Elixir 1.5 and Phoenix 1.2.

## Application libs

* [ErlExec](https://github.com/saleyn/erlexec) execute and control OS processes from Erlang/OTP
* [Elixir release manager](https://github.com/bitwalker/exrm) for Elixir's apps release management
* [ExtensibleEffects](https://github.com/metalabdesign/effects) Monadic, softly-typed, extensible effect handling
* [Guardian](https://github.com/ueberauth/guardian) an authentication framework
* [Guardsafe](https://github.com/DevL/guardsafe) macros expanding into code that can be safely used in guard clauses
* [LoggerFileBackend](https://github.com/onkel-dirtus/logger_file_backend) for writing logs into file
* [Monadex](https://github.com/rob-brown/MonadEx) improve pipelines with monads
* [OK](https://github.com/CrowdHailer/OK) macros for [elegant error handling in elixir pipelines](http://insights.workshop14.io/2015/10/18/handling-errors-in-elixir-no-one-say-monad.html)

## Development libs

* [Credo](https://github.com/rrrene/credo) for reporting violations of the Elixir style guide
* [Dialyzer](https://github.com/jeremyjh/dialyxir) for static analyse
* [Eper](https://github.com/massemanet/eper) Erlang performance related tools
* [EDeliver](https://github.com/boldpoker/edeliver) provides a bash script to build and deploy Elixir and Erlang applications and perform hot-code upgrades
* [ExDoc](https://github.com/elixir-lang/ex_doc) tool to generate documentation for your Elixir projects
* [Observer-CLI](https://github.com/zhongwencool/observer_cli) visualize Erlang nodes on the command line

## Testing libs

* [ExMachina](https://github.com/thoughtbot/ex_machina) makes it easy to create test data and associations
* [ESpec](https://github.com/antonmi/espec) for unit testing
* [Faker](https://github.com/igas/faker) pure Elixir library for generating fake data

## Scripts

* `bin/setup` - setup required libraries and stuff
* `bin/quality` - runs code style check tools
* `bin/ci` - should be used in the CI or locally
* `bin/build` - to build application release
* `bin/server` - to run server locally
* `bin/docs` - to generate local docs
* `bin/deploy [production]` - to deploy using EDeliver

## Getting Started

### Prepare dependencies

Elixir v1.5 and Postgres should be installed.

### Bootstrap application

1. Clone application as new project with original repository named "sentinel_api".

   ```bash
   git clone git://github.com/fs/sentinel_api.git
   ```

2. Run setup script

  ```bash
  bin/setup
  ```

3. Run test and quality suits to make sure all dependencies are satisfied and applications works correctly before making changes.

  ```bash
  bin/ci
  ```

4. Run app

  ```bash
  bin/server
  ```

## Deployment

### Elixir Release Manager

Use `./bin/build` script to build Elixir application release.

### Heroku

You can use [Elixir buildpack](https://github.com/HashNuke/heroku-buildpack-elixir) for Heroku to be deployed:

* [Heroku Postgres](https://www.heroku.com/postgres) add-on will be used for database.
* [SendGrid](https://devcenter.heroku.com/articles/sendgrid) add-on required to be able to send emails.
* [Rollbar](https://elements.heroku.com/addons/rollbar) add-on could be used to application errors.

```bash
heroku create --addons=heroku-postgresql,sendgrid,newrelic,rollbar --remote staging sentinel_api --buildpack "https://github.com/HashNuke/heroku-buildpack-elixir.git"
heroku config:add HOST="sentinel_api.herokuapp.com"
git push staging master
heroku open
```

### EDeliver

You can use [EDeliver](https://github.com/boldpoker/edeliver) to deploy Erlang releases on remote hosts. Provide .deliver/config configuration first:

```bash
  cp ~./.deliver/config.example ~/.deliver/config
  ./bin/deploy
```

## Code style

All Elixir code should be written following [Elixir Style Guide](https://github.com/levionessa/elixir_style_guide).

## Architecture

Please follow the next project structure:

* `lib` - application sources
* `web` - web related sources
* `config` - app configuration
* `spec` - application tests

## Debugging

* Use *IEx.pry* with *Erlang-history* for interactive console
* *Observer* to observe started Erlang processes
* Use Erlang's [dbg](http://erlang.org/doc/man/dbg.html) for debugging function calls
* Use Erlang's *Debugger* with graphical interface

## Testing

Hound tests require phantomjs started in WebDriver mode:

`phantomjs --wd`

## Credits

Sentinel Api was written and maintained by by [Flatstack](http://www.flatstack.com) with the help of our
[contributors](http://github.com/fs/sentinel_api/contributors).

[<img src="http://www.flatstack.com/logo.svg" width="100"/>](http://www.flatstack.com)
