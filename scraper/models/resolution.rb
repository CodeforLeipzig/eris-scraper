class Resolution

  include Pupa::Model

  attributes = [:beschlussnr, :url, :betreff, :einreicher, :datum, :dsnr, :termin, :stand, :text, :anlagen_text, :anlagen_urls, :streetnames]
  attr_accessor *attributes
  dump *attributes

  def to_s
    beschlussnr
  end

  # use for serialization to Elasticsearch::Persistence
  def to_hash
    to_h
  end

end

