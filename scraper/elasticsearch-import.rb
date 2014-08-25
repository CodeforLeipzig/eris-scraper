require './application.rb'
require 'elasticsearch/persistence'

# Create an instance of FileStore to access the scraped JSON files
@store = Pupa::Processor::DocumentStore::FileStore.new('scraped_data')

# Get a Elasticsearch Repository to store the JSON data
@repository = Elasticsearch::Persistence::Repository.new

## import into ES
@store.entries.each do |name|
  reso = Resolution.new(@store.read(name))
  @repository.save(reso)
end
