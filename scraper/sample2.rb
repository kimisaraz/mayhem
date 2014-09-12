require 'open-uri'
require 'nokogiri'

class DarlingColumnParser
  attr_accessor :base_uri, :destinations

  def initialize
    self.base_uri = 'http://www.1101.com/darling_column/'
    self.destinations = []
  end

  # def extract_article
  #   dummy_destinations = ["2008-06-23.html", "2008-06-30.html"]
  #   dummy_destinations.each do |destination|
  #     uri = File.join(base_uri, destination)
  #     html = open(uri, 'r:Shift_JIS:UTF-8').read.encode('UTF-8', 'Shift_JIS')

  #     doc = Nokogiri::HTML(html, nil, 'UTF-8')
  #     doc.css('table[width = "500"] td').each do |node|
  #       puts node.inner_text
  #     end

  #     sleep(5)
  #   end
  # end

  def extract_destinations(*uris)
    uris.each do |uri|
      html = open(uri, 'r:Shift_JIS:UTF-8').read.encode('UTF-8', 'Shift_JIS')

      doc = Nokogiri::HTML(html, nil, 'UTF-8')
      doc.css('table:last-child td:nth-child(2) > a').each do |node|
        destinations << node.attribute('href').value
      end
    end
  end
end

if __FILE__ == $PROGRAM_NAME
  parser = DarlingColumnParser.new
  # parser.extract_destinations(parser.base_uri)
  # p parser.destinations
  parser.extract_article
end
