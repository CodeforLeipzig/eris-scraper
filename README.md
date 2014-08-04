# eris-scraper

A scraper for Leizig's [ERIS](http://www.leipzig.de/buergerservice-und-verwaltung/stadtrat/ratsinformationssystem-eris/). Currently retrieves 'Beschlüsse' (i.e.
resolutions, or decisions). It uses the [pupa-ruby](https://github.com/opennorth/pupa-ruby) scraping framework.

## Requirements

* ruby (>= 2.1 tested)
* bundler
* mongodb
* [genghisapp](http://genghisapp.com/) (a mongodb gui; optional)

## How to stuff
### 1. Download data

Install gems:

    bundle install

Install mongodb and start it; f.e. for OS X:

    brew install mongodb
    mongod

Run the scraper like this:

    ruby resolution.rb -d eris-dev --database_url mongodb://localhost:27017/eris

You can then inspect the data in the database, f.e. in the browser using genghisapp:

    gem install genghisapp
    genghisapp -F

The raw data is also stored as JSON files in './scraped_data' for
inspection.

### 2. Import data into Elasticsearch
- Install Elasticsearch `brew  install elasticsearch`
- Start Elasticsearch `elasticsearch`
- Install Elasticsearch GUI: `plugin --install jettro/elasticsearch-gui`
- Open GUI `http://127.0.0.1:9200/_plugin/gui/index.html`
- Import data: `bundle exec ruby ./elasticsearch-import.rb`

## TODOS / Ideas

* Add an elasticsearch storage backend to pupa-ruby as an alternative to mongodb
* Scrape other content, i.e. minutes, agendas etc
* Align naming and data structures with the emerging [OParl](http://oparl.org/) standard
