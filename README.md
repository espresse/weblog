Weblog
============
Blogging application written in Ruby 1.9 and Ruby on Rails 3.2

You can download the source code from GitHub:

      git clone git@github.com:espresse/weblog.git

Don't forget to run 

      bundle install

to download all required by Weblog gem packages.

Database 
--------

Currently Weblog is using SQLite Database. Setup is quite simple and requires invoking commands:

    rake db:migrate
    rake db:test:prepare

You can fill in your database with fake data using:

    rake db:seed

This will add 12 users, 200 posts and several comments for each post.

Tests
-----

Tests are prepared with RSpec and Cucumber for database and web interface integration and could be run by:

    bundler exec rspec spec

TODO
----
* change to ruby 2.0 (syntax)
* move from erb to haml
* fix and update tests
* upgrade to rails 4
* refactor