require 'thor'
$LOAD_PATH.unshift(File.dirname(__FILE__))

module Loris

  class CLI < Thor

    desc "scrape", "Runs the scraper to download resolutions from ERIS"
    def scrape
      puts "TODO"
    end

    desc "import", "Import the scraped data into Elasticsearch"
    def import
      puts "TODO"
    end

    desc "tag", "Run the tagger to enrich the data with keywords"
    option :dictionary
    def tag
      puts "Command: tag"
      puts "Options: #{options}"
      require 'tagger'
      ::Tagger::Simple.foo
    end

  end
end
