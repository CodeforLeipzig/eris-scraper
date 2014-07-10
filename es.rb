require './application.rb'
require 'elasticsearch/persistence'


@store = Pupa::Processor::DocumentStore::FileStore.new('scraped_data')
@data  = @store.read(@store.entries.first)
@resolution = Resolution.new(@data)

@repository = Elasticsearch::Persistence::Repository.new

puts "Connection to ES established" if @repository.client.ping


# [3] pry(main)> @repository.save(@resolution)
# => {"_index"=>"repository",
#  "_type"=>"resolution",
#  "_id"=>"0017e231-5479-4bf7-bb34-b69abd23ddfd",
#  "_version"=>1,
#  "created"=>true}
# [4] pry(main)> id = @resolution._id
# => "0017e231-5479-4bf7-bb34-b69abd23ddfd"
# [5] pry(main)> @repository.find(id)
# => #<Resolution:0x000001030b27b0
#  @_id="0017e231-5479-4bf7-bb34-b69abd23ddfd",
#  @_type="resolution",
#  @beschlussnr="VAV-184/13",
#  @betreff=
#   "Ausführungsbeschluss für die Organisation und Durchführung der Anliegerpflichten des Verkehrs- und Tiefbauamtes durch den Eigenbetrieb Stadtreinigung Leipzig",
#  @datum="2013-10-02",
#  @dsnr="V/3250",
#  @extras={},
#  @stand="n.n.b.",
#  @termin="2014-04-02",
#  @url=
#   "http://notes.leipzig.de/appl/laura/wp5/kais02.nsf/(WEBBeschlussAusw2)/E2179D63F32D4A99C1257C05002973A5?opendocument">
# [6] pry(main)> res2 = _
# => #<Resolution:0x000001030b27b0
#  @_id="0017e231-5479-4bf7-bb34-b69abd23ddfd",
#  @_type="resolution",
#  @beschlussnr="VAV-184/13",
#  @betreff=
#   "Ausführungsbeschluss für die Organisation und Durchführung der Anliegerpflichten des Verkehrs- und Tiefbauamtes durch den Eigenbetrieb Stadtreinigung Leipzig",
#  @datum="2013-10-02",
#  @dsnr="V/3250",
#  @extras={},
#  @stand="n.n.b.",
#  @termin="2014-04-02",
#  @url=
#   "http://notes.leipzig.de/appl/laura/wp5/kais02.nsf/(WEBBeschlussAusw2)/E2179D63F32D4A99C1257C05002973A5?opendocument">
# [7] pry(main)> res2 == @resolution
# => true
#

