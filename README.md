# call4paperz.com

call4paperz.com is a website for talk proposals, either to your own conference
or lightning talks. Users can post talk proposals and they can be voted and
commented by the users.

[![Build Status](https://travis-ci.org/ricardovaleriano/call4paperz.png)](https://travis-ci.org/ricardovaleriano/call4paperz)

## Environment Configuration

You must set the following environment variables for the system to fully work:

    S3_ACCESS_KEY
    S3_SECRET_KEY
    TWITTER_ACCESS
    TWITTER_SECRET
    FACEBOOK_ACCESS
    FACEBOOK_KEY
    SECRET_KEY
    DEVISE_PEPPER

## Bootstrapping with Foreman


Install gems with bundle

    $ bundle install

Then create file `$RAILS_ROOT/.env` file with the following content:

    SECRET_KEY=2d48c32f2ecdc0507efb3ce66fea2196a585a0a652d93e537135944baa8
    TWITTER_ACCESS=<your twitter access key>
    TWITTER_SECRET=<your twitter secret key>
    FACEBOOK_ACCESS=<your facebook access key>
    FACEBOOK_KEY=<your facebook api key>


Then config database

    $ cp config/database.yml.sample config/database.yml
    $ bundle exec rake db:create db:migrate db:test:prepare

Then start the server with the following command:

    $ foreman start -f Procfile.development

That's it! Just go to <http://localhost:3000>.

## Links
[Mailing list](https://groups.google.com/forum/#!forum/call4paperz-dev)

## Contributions

To contribute to call4paperz, submit a pull request (preferably in a feature
branch), with tests if possible. If you have any doubts, just bug
[valeriano](https://github.com/ricardovaleriano).

Also, please make feature branches. For instance, if you add a new
feature, create a feature branch called "my-awesome-feature". That
helps reviewing pull requests, specially if you have unrelated
commits.

## Maintainer
Maintenance is done by [valeriano](https://github.com/ricardovaleriano).
Before was bravely maintained by by [vinibaggio](https://github.com/vinibaggio).

## Original authors
- Anderson Leite (no longer active)
- Douglas Campos (no longer active)
- Vinicius Baggio Fuentes, [vinibaggio](https://github.com/vinibaggio)

## Contributors
- [akitaonrails](https://github.com/akitaonrails)
- [dukex](https://github.com/dukex)
- [fnando](https://github.com/fnando)

## License
call4paperz uses the MIT license. Please check the LICENSE file for more details.
