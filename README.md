# eris-scraper

A scraper for Leizig's [ERIS](http://www.leipzig.de/buergerservice-und-verwaltung/stadtrat/ratsinformationssystem-eris/). Currently retrieves 'Beschlüsse' (i.e.
resolutions, or decisions). It uses the [pupa-ruby](https://github.com/opennorth/pupa-ruby) scraping framework.

## Requirements

* ruby (>= 2.1 tested)
* bundler

## How to stuff

### 0. Install dependencies

- Install ruby
- Install bundler ('gem install bundler')

- Install Elasticsearch: `brew  install elasticsearch`
- Start Elasticsearch: `elasticsearch`
- (Optional) Install Elasticsearch GUI: `plugin --install jettro/elasticsearch-gui`

### 1. Download data

Install gems:

    bundle install

Run the scraper like this:

    bin/scrape

This will download a lot of JSON files into the scraper/output
directory.

### 2. Import data into Elasticsearch

Import the JSON files from the step before into Elasticsearch:

  bin/elasticsearch-import

### 3. Enrich the data with metadata

Run the tagger with the default settings:

  bin/tagger

You can specify a specific dictionary to use for the tagger:

  bin/tagger --dictionary=streets

This will add the found named entities to the resolution in elasticsearch.

## UI
See `ui/README.md` for how to build/show the UI.

## TODOS / Ideas

* Scrape other content, i.e. minutes, agendas etc
* Align naming and data structures with the emerging [OParl](http://oparl.org/) standard
* build the scripts above (this is vaporware!!)
