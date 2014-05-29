require './application'

class ResolutionProcessor < Pupa::Processor

  def scrape_objects
    page = get('http://notes.leipzig.de/APPL/LAURA/WP5/kais02.nsf/WEBBeschlussAusw2?OpenView&RestrictToCategory=2013-----alleEinreicher')

    page.search('//form/table/tr[@valign="top"]').each do |row|

      beschlussnr = row.at('./td[1]').content rescue ''
      url         = build_url(row.at('./td[1]//a[1]')['href'])
      betreff     = row.at('./td[3]').content rescue ''
      datum       = row.at('./td[4]').content rescue ''
      dsnr        = row.at('./td[5]').content rescue ''
      termin      = row.at('./td[6]').content rescue ''

      resolution = Resolution.new({
        beschlussnr: beschlussnr,
        url:         url,
        betreff:     betreff,
        datum:       parse_date(datum),
        dsnr:        dsnr,
        termin:      parse_date(termin)
      })

      doc = get url
      resolution.stand = doc.css('tr:contains("Beschlussstatus") td:nth-child(2)').text
      resolution.stand = doc.css('tr:contains("Beschlussstatus") td:nth-child(2)').text
      resolution.text = doc.css('table:contains("Beschlusstext") ~ table:first').text
      resolution.einreicher = doc.css('td:contains("Einreicher:") ~ td:first').text

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




