# Billing Walrus

A simple app to keep track of bills and payments

## Setting up a Development instance

To set up a development copy of the app, ensure you have Ruby 1.9 installed
(this example will assume you are using 1.9.3), preferably with something like
[RVM](http://rvm.io/) and have set up a gemset if required. Ensure bundler is
installed

    $ rvm use 1.9.3@global --create
    $ gem install bundler

Clone the repository into a folder (called billing-walrus in this case)

    $ git clone https://github.com/glsignal/billing-walrus.git

Install the gems for the app

    $ cd billing-walrus
    $ rvm use 1.9.3@billing-walrus --create --rvmrc
    $ bundle

That may take a while, once it is done you can prepare the DB and start
the app

    $ rake db:setup
    $ rails s

You should now have a server running at localhost:3000 serving billing walrus

## Running Tests

Besides the included RSpec tests, the app also includes JS testing using
[Buster JS](http://busterjs.org). To run these tests, you must have at least
version 0.6.3 of Node installed.

The tests themselves require several Node modules which can be installed with
the following commands:

    $ npm install -g buster
    $ npm install buster-coffee
    $ npm install buster-sinon

These node modules contain the testing framework, as well as CoffeeScript
compilation and Sinon.

Tests can be executed by first starting the Buster server

    $ buster server

then visiting http://localhost:1111 in any browser in which you want the tests
to be executed. Once the browsers are captured, execute the tests with the
following command:

    $ buster test

