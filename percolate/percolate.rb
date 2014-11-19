# start console with: pry -r./percolate.rb

# example search:

# response = @client.search index: 'eris', body: @query
# result = Hashie::Mash.new response
# result.hits.hits
# # => ...


# example percolate:

# # create saved query:
# @client.index index: 'eris', type: '.percolator', id: 'alert-1', body: @query
#
# # match against a document
# response = @client.percolate index: 'eris', type: '.percolator', body: {doc: { title: 'Vermögensbilanz'}}
# result = Hashie::Mash.new response
# result.matches

# fetch the matched query (for metadata):
# @client.get index: 'eris', type: '.percolator', id: 'alert-with-user'
# response = @client.get index: 'eris', type: '.percolator', id: 'alert-with-user'
# result = Hashi::Mash.new response
# result._source.query.user_id

require 'json'
require 'typhoeus/adapters/faraday'
require 'elasticsearch'
require 'hashie'

@query = JSON.parse(<<EOS)
{
  "query" : {
    "query_string" : {
      "query" : "Vermögensbilanz"
    }
  }
}
EOS

@client = Elasticsearch::Client.new log: true


class SavedQuery
  def initialize(query_string, user_id)
end
