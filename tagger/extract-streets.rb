# # start with 'pry -r ./extract-streets.rb'
#
# repo = Elasticsearch::Persistence::Repository.new
# resolution = repo.find("d80ee82b-39fe-4f0a-b4e9-4d3bc4e4213b")
#
# dict = StreetDictionary.new("./streets-200.csv")
# dict.build
#
# extr = StreetExtractor.new(dict)
# extr.extract(resolution.text)
#

$LOAD_PATH.unshift(File.dirname(__FILE__))

require 'rubygems'
require 'bundler/setup'

#require 'pupa'
#require 'typhoeus'
#require 'typhoeus/adapters/faraday'
#require 'nokogiri'

#require 'elasticsearch/persistence'
require 'elasticsearch/persistence/model'

# Use Addressable::URI to handle URIs with umlauts
require 'addressable/uri'
Faraday::Utils.default_uri_parser = Addressable::URI.method(:parse)

#require 'models/resolution'



#require './application.rb'
require 'ahocorasick'
require 'csv'

class Resolution
  #attributes = [:beschlussnr, :url, :betreff, :einreicher, :datum, :dsnr, :termin, :stand, :text, :anlagen_text, :anlagen_urls, :streetnames]
  #attr_accessor *attributes

  include Elasticsearch::Persistence::Model


  attr_accessor :attributes

  attribute :districts, Array[String]

  def initialize(attributes={})
    @attributes = attributes
  end

end


class StreetExtractor

  def initialize(dictionary)
    @dictionary = dictionary
  end

  def extract(text)
    @dictionary.lookup(text)
  end

end


class StreetDictionary

  def initialize(path_to_streetlist)
    @trie = AhoC::Trie.new
    @path = path_to_streetlist
  end

  def build
    CSV.foreach(@path) do |row|
      #street_with_number = row[0].gsub!(/^Leipzig, /,'')
      #street_without_number = row[0][/Leipzig, (.*) \d+/, 1]
      district = row[1]
      next if district.nil?
      @trie.add(district)
    end
    @trie.build
  end

  def lookup(text)
    @trie.lookup(text)
  end

end


@repo       = Elasticsearch::Persistence::Repository.new
@resolution = @repo.find("d80ee82b-39fe-4f0a-b4e9-4d3bc4e4213b")
@path       = "./streets-with-latlong.csv"
@dict       = StreetDictionary.new(@path)
