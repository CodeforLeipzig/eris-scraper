class Resolution

  include Pupa::Model

  attr_accessor :beschlussnr, :url, :betreff, :datum, :dsnr, :termin, :stand
  dump          :beschlussnr, :url, :betreff, :datum, :dsnr, :termin, :stand

  def to_s
    beschlussnr
  end

end

