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

Additional question
------------------

The Weblog application is not ready for high traffic. If such situation occures one should add "action caching" which reduces to minimum queries to database. Limited traffic will reach the application server. Http server will serve cached content instead.
In rails applying action catching is as simple as adding a line to the posts controller: 
    
    caches_action :index, :show
    
To be sure that http server would be ready for the high traffic as well we could use use CDN (Content Delivery Network) for better user performance (cached page is taken from the nearest server).
