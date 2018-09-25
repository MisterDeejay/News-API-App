# News API App

## Table of contents:

* [Description](./README.md#description)
  * [Task](./README.md#task)
* [Setup](./README.md#setup)
* [Running the app](./README.md#running-the-app)
* [Running the tests](./README.md#running-the-tests)

## Description

This app is a simple API application that responds to an endpoint called news which allows clients to pull news items in JSON format and create them via authorized token authentication.

## Task

* The formal specifications would be:
* Create an API endpoint /news served by the application which returns latest news items from that model.
* Create an authorized API endpoint /new which will take a title and body for news and save it to the database. Prevent all XSS and SQL injection vulnerabilities.
* Give back meaningful error messages and provide enough information on how to run your code.

### Bonus
* Take an option language in /new and limit posts on /news based on the requested language.

## Setup

1. Make sure you have Ruby 2.3 installed in your machine. If you need help installing Ruby, take a look at the [official installation guide](https://www.ruby-lang.org/en/documentation/installation/).

2. Install the [bundler gem](http://bundler.io/) by running:

    ```gem install bundler```

3. Clone this repo:

    ```git clone git@github.com:MisterDeejay/News-API-App.git```

4. Change to the app directory:

    ```cd News-API-App```

5. Install dependencies:

    ```bundle install```

6. Create a database and add a user

    ```rails db:create db:migrate```

      ```User.create(email: <email>, password: <password>, password_confirmation: <password>)```

7. Ensure there is a development and test `secret_base_key` in `secrets.yml` by copying and pasting the output from `rails secret`

## Running the app

1. Start the server

    ```rails s```

2. Request an auth token with the user credentials

    ```curl -H "Content-Type: application/json" -X POST -d '{"email":"example@mail.com","password":"123123123"}' http://localhost:3000/authenticate```

Your token will now be returned.

    {"auth_token":"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxLCJleHAiOjE0NjA2NTgxODZ9.xsSwcPC22IR71OBv6bU_OGCSyfE89DvEzWfDU0iybMA"}

3. To create a new news article

    ```curl -X POST -H "Content-Type: application/json" -H "Authorization:eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxLCJleHAiOjE1Mzc5Nzc2ODd9.PTSNkwnYE5rcTYbOkpNLDhdMO83DFw7OvnzChAipGdY" -d '{"title":"news Ttile 180924", "body":"body", "language":"English"}' http://localhost:3000/new```

4. To get back all news articles

    ```curl http://localhost:3000/news```

5. To get back all articles filtered by a language

    ```curl http://localhost:3000/news?language=<language>```

## Running the tests

    rspec spec/
