require 'rubygems'
require 'bundler/setup'

require 'elasticsearch/persistence/model'
require 'addressable/uri'
require 'ahocorasick'
require 'csv'

$LOAD_PATH.unshift(File.expand_path(File.join(File.dirname(__FILE__), '..', 'tagger')))

require 'models/resolution'

module Tagger

  class Simple

    def self.foo
      Tagger::Resolution.foo
    end

  end

end
