# call4paperz.com

call4paperz.com is a website for talk proposals, either to your own conference
or lightning talks. Users can post talk proposals and they can be voted and
commented by the users.

## Bootstrapping with Foreman

Install foreman:

    $ gem install foreman

Then create file `$RAILS_ROOT/.env` file with the following content:

    SECRET_TOKEN=2d48c32f2ecdc0507efb3ce66fea2196a585a0a652d93e537135944baa8
    TWITTER_ACCESS=<your twitter access key>
    TWITTER_SECRET=<your twitter secret key>
    FACEBOOK_ACCESS=<your facebook access key>
    FACEBOOK_KEY=<your facebook api key>

Then start the server with the following command:

    $ foreman start -f Procfile.development

That's it! Just go to <http://localhost:3000>.

## Links
[Mailing list](https://groups.google.com/forum/#!forum/call4paperz-dev)

## Contributions

To contribute to call4paperz, submit a pull request (preferably in a feature
branch), with tests if possible. When your pull request is approved, you can
request commit access to the repository, just bug
[vinibaggio](https://github.com/vinibaggio).

## Maintainer
Maintenance is done by [vinibaggio](https://github.com/vinibaggio).

## Original authors
- Anderson Leite (no longer active)
- Douglas Campos (no longer active)
- Vinicius Baggio Fuentes, [vinibaggio](https://github.com/vinibaggio)

## License
call4paperz uses the MIT license. Please check the LICENSE file for more details.
