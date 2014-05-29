class Resolution

  include Pupa::Model

  attributes = [:beschlussnr, :url, :betreff, :einreicher, :datum, :dsnr, :termin, :stand, :text]
  attr_accessor *attributes
  dump *attributes

  def to_s
    beschlussnr
  end

end

