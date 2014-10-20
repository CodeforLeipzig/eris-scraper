module Tagger

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
end
