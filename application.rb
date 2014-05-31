#$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'models'))
$LOAD_PATH.unshift(File.dirname(__FILE__))

require 'rubygems'
require 'bundler/setup'

require 'pupa'
require 'typhoeus'
require 'typhoeus/adapters/faraday'
require 'nokogiri'

# Use Addressable::URI to handle URIs with umlauts
require 'addressable/uri'
Faraday::Utils.default_uri_parser = Addressable::URI.method(:parse)

require 'models/resolution'

