

# call4paperz.com

call4paperz.com is a website for talk proposals, either to your own conference
or lightning talks. Users can post talk proposals and they can be voted and
commented by the users.

[![Build Status](https://travis-ci.org/call4paperz/call4paperz.svg)](https://travis-ci.org/call4paperz/call4paperz)
[![Code Climate](https://codeclimate.com/github/call4paperz/call4paperz/badges/gpa.svg)](https://codeclimate.com/github/call4paperz/call4paperz)
[![Test Coverage](https://codeclimate.com/github/call4paperz/call4paperz/badges/coverage.svg)](https://codeclimate.com/github/call4paperz/call4paperz/coverage)
[![security](https://hakiri.io/github/call4paperz/call4paperz/master.svg)](https://hakiri.io/github/call4paperz/call4paperz/master)
[![Dependency Status](https://gemnasium.com/badges/github.com/call4paperz/call4paperz.svg)](https://gemnasium.com/github.com/call4paperz/call4paperz)
[![Help Contribute to Open Source](https://www.codetriage.com/call4paperz/call4paperz/badges/users.svg)](https://www.codetriage.com/call4paperz/call4paperz)

## Environment Configuration

You must set the following environment variables for the system to fully work:

    S3_ACCESS_KEY
    S3_SECRET_KEY
    TWITTER_ACCESS
    TWITTER_SECRET
    FACEBOOK_ACCESS
    FACEBOOK_KEY
    GITHUB_CLIENT_ID
    GITHUB_SECRET
    SECRET_KEY
    DEVISE_PEPPER
    RECAPTCHA_PRIVATE_KEY
    RECAPTCHA_PUBLIC_KEY

## Bootstrapping (and using Foreman to run all the things)

Your first time here? Just run:

```
$ bin/setup
```

It will guide you through the basic dependencies needed to run the application.
You can run it, see if it yells at you, fix it... and run it again!

Repeat until all the stuff is in place.

### Environment variables

Edit the file `.env` generated in the project's root dir and add your keys for
twitter and facebook applications.

### PostgreSQL

The setup will create a `config/database.yml`, the user configuration will point
to your current s.o. user.

Edit this file if you need, or if the setup process fail trying to use the
credentials auto generated.

### let's go!

Then start the server with the following command:

```
$ foreman start -f Procfile.development
```

## When using docker

At the time of writing it, it was tested with versions:

For Docker Engine: 1.12.5

For Docker Compose: 1.6.2

### For development environment

When in development environment, it can be useful to have some extra configs,
like volumes to keep the application directory synced and avoid losing database files.

In docker-compose.override.yml.sample exists some of those extra configs, so you
can run the command below to make use of it:

`$ cp docker-compose.override.yml.sample docker-compose.override.yml`

### Setup

After you're done with specific environment's steps,
to setup the application, you need to run:

```
$ docker-compose run --rm web bin/setup
```

### Running the application

Now that all setup steps are done, you only need to run the command below
to get the application running:

```
$ docker-compose up
```

That's it! Just go to <http://localhost:3000>.

## Contributions

To contribute to call4paperz, submit a pull request (preferably in a feature
branch), with tests if possible. If you have any doubts, just bug
[lucianosousa](https://github.com/lucianosousa) or [tauil](https://github.com/tauil).

Also, please make feature branches. For instance, if you add a new
feature, create a feature branch called "my-awesome-feature". That
helps reviewing pull requests, specially if you have unrelated
commits.

## Maintainer
Maintenance is done by [lucianosousa](https://github.com/lucianosousa) and [tauil](https://github.com/tauil).
Before was bravely maintained by [ricardovaleriano](https://github.com/ricardovaleriano) and [vinibaggio](https://github.com/vinibaggio).

## Original authors
- Anderson Leite (no longer active)
- Douglas Campos (no longer active)
- Vinicius Baggio Fuentes (no longer active)

## Contributors
We have a few awesome contributors that you can take a look here: https://github.com/call4paperz/call4paperz/graphs/contributors

## License
call4paperz uses the MIT license. Please check the LICENSE file for more details.
