require 'rubygems'
require 'bundler/setup'

require 'pupa'
require 'nokogiri'

class Resolution

  include Pupa::Model

  attr_accessor :beschlussnr, :url, :betreff, :datum, :dsnr, :termin, :stand
  dump          :beschlussnr, :url, :betreff, :datum, :dsnr, :termin, :stand

  def to_s
    beschlussnr
  end

end


class ResolutionProcessor < Pupa::Processor

  def scrape_objects
    page = get('http://notes.leipzig.de/APPL/LAURA/WP5/kais02.nsf/WEBBeschlussAusw2?OpenView&RestrictToCategory=2014-----alleEinreicher')

    page.search('//form/table/tr[@valign="top"]').each do |row|

      beschlussnr = row.at('./td[1]').content rescue ''
      url         = row.at('./td[1]//a[1]')['href']
      betreff     = row.at('./td[3]').content rescue ''
      datum       = row.at('./td[4]').content rescue ''
      dsnr        = row.at('./td[5]').content rescue ''
      termin      = row.at('./td[6]').content rescue ''
      stand       = row.at('./td[9]').content rescue ''

      resolution = Resolution.new({
        beschlussnr: beschlussnr,
        url:         build_url(url),
        betreff:     betreff,
        datum:       parse_date(datum),
        dsnr:        dsnr,
        termin:      parse_date(termin),
        stand:       stand
      })

      dispatch(resolution)
    end

  end

  private

  def build_url(url)
    ["http://notes.leipzig.de", url].join("")
  end

  def parse_date(string)
    begin
      Date.strptime string, "%m/%d/%Y"
    rescue
      nil
    end
  end

end


ResolutionProcessor.add_scraping_task(:objects)

runner = Pupa::Runner.new(ResolutionProcessor)
runner.run(ARGV)




