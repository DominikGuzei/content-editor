Tangram
========

A modular content editor for CMS-Systems as replacement for traditional (horrible) rich text editors.

Installing as Rails Engine
==========================
put this in your Gemfile:

    gem 'tangram'
    
then install it:

    bundle install

to load the editor in your JavaScript files:

    #= require tangram
    

Running Unit Tests
==================
Tangram is tested with [Jasmine](https://github.com/pivotal/jasmine-gem) + 
[Honeymoon](https://github.com/DominikGuzei/honeymoon) via [Jasminerice](https://github.com/bradphelan/jasminerice) 
within a dummy rails application.

You have to move into the subdirectory of the dummy app

    cd test/dummy
    
then start the rails server:

    rails s
    
and visit the jasmine runner on [http://localhost:3000/jasmine](http://localhost:3000/jasmine)