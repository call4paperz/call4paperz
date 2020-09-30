

# call4paperz.com - an amazing project

call4paperz.com is a website for talk proposals, either to your own conference
or lightning talks. Users can post talk proposals and they can be voted and
commented by the users.

[![CircleCI](https://circleci.com/gh/call4paperz/call4paperz.svg?style=svg)](https://circleci.com/gh/call4paperz/call4paperz)
[![Code Climate](https://codeclimate.com/github/call4paperz/call4paperz/badges/gpa.svg)](https://codeclimate.com/github/call4paperz/call4paperz)
[![Test Coverage](https://codeclimate.com/github/call4paperz/call4paperz/badges/coverage.svg)](https://codeclimate.com/github/call4paperz/call4paperz/coverage)
[![security](https://hakiri.io/github/call4paperz/call4paperz/master.svg)](https://hakiri.io/github/call4paperz/call4paperz/master)
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
    RECAPTCHA_SITE_KEY
    RECAPTCHA_SECRET_KEY
    GOOGLE_CLIENT_ID
    GOOGLE_SECRET

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

### let's go!

Then start the server with the following command:

```
$ foreman start -f Procfile.development
```

## Running with Docker

We strongly encourage Docker usage. With Docker, we can standardize the development environment, quickly rebuilding it whenever necessary without installing anything on the host machine.

A straight forward  `Dockerfile` based on an official Ruby base image is provided. Also, the Docker Compose configurations provided, help considerably running the Docker commands.

You can have full control of the Docker Compose configs in your development environment, we provide a sample file, and just the environment variables are required.

`$ cp docker-compose.override.yml.sample docker-compose.override.yml`

### Setup

After setting up the Docker Compose configuration, to set up the application, you need to run:

```
$ docker-compose run --rm web bin/setup
```

### Running the application

Now that all setup steps are done, you only need to run the command below to get the application running:

```
$ docker-compose up
```

That's it! Just go to <http://localhost:3000>.

## Accessing Recaptcha Variables

Access the https://www.google.com/recaptcha/intro/v3.html.

Click on the `Admin Console` button.

On the new page, click the `+` button and fill in the fields to generate a new site, choose v2 for the captcha type and in domains add `127.0.0.1 and localhost`.

When you click save it will generate your keys.

## Accessing Facebook Variables

Access the https://developers.facebook.com/apps/

Click on the `Add new app` button.

Fill in the name of the app and your contact email. Then click Create Application ID.

On your app page, click on my left side under `Settings -> Basic`.

In this page you need to configure two fields:

- Application domain with `localhost`
- In the site session the site URL field with `http: // localhost: 3000`, where 3000 is the port used to start the Rails application on your computer.
- Feel free to fill in the other fields, but these two are the main ones.

Configuring the fields on the same page will find the application ID as the `FACEBOOK_ACCESS` variable and the application secret key as the` FACEBOOK_KEY` variable.

## Accessing Github Variables

Access the https://github.com/settings/apps

Click on the `New Github App` button.

Fill out the form with app name, description, website URL. In `User authorization callback URL and Webhook URL` fill in with` http://localhost:3000/auth/github/callback`.

Save and after saving you will have the keys at the beginning of the page.

## Accessing Twitter Variables

Access the https://developer.twitter.com/en/apps

Click on the `Create an app` button.

Follow the step-by-step twitter requesting the information you request if you have no apps created. If you have already been verified by Twitter the page will generate a new app.

Fill in all fields like app name, description, website URL. In `Callback URLs` fill in with` http://localhost:3000/auth/twitter/callback`. In `Allow this application to be used to sign in with Twitter` enable` Enable Sign in with Twitter`.

Save and after saving go to the `Keys and tokens` tab to access the keys.

## Accessing Google Variables

Access the https://code.google.com/apis/console/

Click on the `Create project` button.

Fill in a name and save.

When you save, click on my hanburger and choose `API and Services -> Credentials`.

In the credentials screen, click the `Create Credentials -> OAuth Client ID` button.

Click the `Set up consent screen` button to create the app.

Fill out the form and after saving you will be redirected to choose the type of app. Choose the first one that is a web application.

Enter the name and the `authorized redirect URIs` fill in with `http://localhost:3000/auth/google_oauth2/callback`.

Once completed, click create and you will be redirected to the page with the keys.

## Contributions

To contribute to call4paperz, submit a pull request (preferably in a feature
branch), with tests if possible. If you have any doubts, just bug
[gustavokloh](https://github.com/gustavokloh).

Also, please make feature branches. For instance, if you add a new
feature, create a feature branch called "my-awesome-feature". That
helps reviewing pull requests, specially if you have unrelated
commits.

## Maintainer
Maintenance is done by [gustavokloh](https://github.com/gustavokloh).

## Original authors
- Anderson Leite (no longer active)
- Douglas Campos (no longer active)
- Vinicius Baggio Fuentes (no longer active)

## Contributors
We have a few awesome contributors that you can take a look here: https://github.com/call4paperz/call4paperz/graphs/contributors

## License
call4paperz uses the MIT license. Please check the LICENSE file for more details.
