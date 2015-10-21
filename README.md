# call4paperz.com

call4paperz.com is a website for talk proposals, either to your own conference
or lightning talks. Users can post talk proposals and they can be voted and
commented by the users.

[![Build Status](https://travis-ci.org/call4paperz/call4paperz.svg)](https://travis-ci.org/call4paperz/call4paperz)

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

That's it! Just go to <http://localhost:3000>.

## Links
[Mailing list](https://groups.google.com/forum/#!forum/call4paperz-dev)

## Contributions

To contribute to call4paperz, submit a pull request (preferably in a feature
branch), with tests if possible. If you have any doubts, just bug
[ricardovaleriano](https://github.com/ricardovaleriano).

Also, please make feature branches. For instance, if you add a new
feature, create a feature branch called "my-awesome-feature". That
helps reviewing pull requests, specially if you have unrelated
commits.

## Maintainer
Maintenance is done by [ricardovaleriano](https://github.com/ricardovaleriano).
Before was bravely maintained by [vinibaggio](https://github.com/vinibaggio).

## Original authors
- Anderson Leite (no longer active)
- Douglas Campos (no longer active)
- Vinicius Baggio Fuentes (no longer active)

## Contributors
- [lucianosousa](https://github.com/lucianosousa)
- [akitaonrails](https://github.com/akitaonrails)
- [dukex](https://github.com/dukex)
- [fnando](https://github.com/fnando)

## License
call4paperz uses the MIT license. Please check the LICENSE file for more details.
