Weblog
============
Blogging application written in Ruby 2.0 and Ruby on Rails 4.0
As this is just a test application, many things are made from scratch, particulary authentication and tagging. However, it might change in future. Take a look at TODO to get a brief look of what I'm currently working on.

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
* test coverage should be 100% (currently ~91%)
* refactor
