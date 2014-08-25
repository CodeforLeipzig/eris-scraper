

class ResolutionProcessor < Pupa::Processor

  def scrape_objects
    page = get('http://notes.leipzig.de/APPL/LAURA/WP5/kais02.nsf/WEBBeschlussAusw2?OpenView&RestrictToCategory=alleJahre-----alleEinreicher')

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

      resolution.anlagen_text = doc.css('table:contains("Download") ~ table:first td:first').text
      script = doc.css('table:contains("Download") ~ table:first script').text

      pdf_urls = extract_js_array(:URL, script).map! { |path| build_url(path.strip!) if path }
      resolution.anlagen_urls = pdf_urls if pdf_urls.present?

      dispatch(resolution)

      #download_attachments! resolution.anlagen_urls
    end
  end

  # Download the attachment to the filesystem and cache it forever.
  def download_attachments!(urls)
    return if urls.blank?
    begin
      # Send HTTP requests in parallel. – See Pupa's README to learn more.
      attachment_downloader.in_parallel(attachment_download_manager) do
        urls.each do |url|
          attachment_downloader.get(url)
        end
      end
    rescue Faraday::Error::ClientError => e
      error(e.response.inspect)
    end
  end

  private

  def attachment_download_manager
    @attachment_download_manager ||= Typhoeus::Hydra.new(max_concurrency: 20)
  end

  def attachment_downloader
    @attachment_downloader ||= Pupa::Processor::Client.new(cache_dir: File.expand_path('attachments', Dir.pwd), expires_in: nil)
  end

  require 'v8'
  def extract_js_array(name, js_source)
    context_shim = "document = { write: function() {} };"
    js = V8::Context.new
    js.eval(context_shim)
    js.eval(js_source)
    js[name].to_a
  end

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

runner = Pupa::Runner.new(ResolutionProcessor, expires_in: 7.days.to_i)
runner.run(ARGV)




