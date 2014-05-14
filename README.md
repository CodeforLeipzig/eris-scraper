# eris-scraper

A scraper for Leizig's [ERIS](http://www.leipzig.de/buergerservice-und-verwaltung/stadtrat/ratsinformationssystem-eris/). Currently retrieves 'Beschlüsse' (i.e.
resolutions, or decisions). It uses the [pupa-ruby](https://github.com/opennorth/pupa-ruby) scraping framework.

## Requirements

* ruby (>= 2.1 tested)
* bundler
* mongodb
* [genghisapp](http://genghisapp.com/) (a mongodb gui; optional)

## Getting started

Install gems:

    bundle install

Install mongodb and start it; f.e. for OS X:

    brew install mongodb
    mongod

Run the scraper like this:

    ruby resolution.rb -d eris-dev

You can then inspect the data in the database, f.e. in the browser using genghisapp:

    gem install genghisapp
    genghisapp -F

The raw data is also stored as JSON files in './scraped_data' for
inspection.

## TODOS / Ideas

* Add an elasticsearch storage backend to pupa-ruby as an alternative to mongodb
* Scrape other content, i.e. minutes, agendas etc
* Align naming and data structures with the emerging [OParl](http://oparl.org/) standard
