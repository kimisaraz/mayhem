require 'open-uri'
require 'nokogiri'

class DarlingColumnParser
  attr_accessor :uri, :destinations, :archive_uris

  def initialize
    self.uri = 'http://www.1101.com/darling_column/'
    self.destinations = []
    self.archive_uris = []
  end

  def extract_destinations
    html = open(uri, 'r:Shift_JIS:UTF-8').read.encode('UTF-8', 'Shift_JIS')

    doc = Nokogiri::HTML(html, nil, 'UTF-8')
    doc.css('table:last-child td:nth-child(2) > a').each do |node|
      # p node.inner_text
      destinations << node.attribute('href').value
    end
  end

  def extract_archive_uris
    html = open(uri, 'r:Shift_JIS:UTF-8').read.encode('UTF-8', 'Shift_JIS')

    doc = Nokogiri::HTML(html, nil, 'UTF-8')
     doc.css('table:last-child td:nth-child(1) a').each do |node|
      href = node.attribute('href').value
      archive_uris << href if href[/^archive/]
    end
  end
end

if __FILE__ == $PROGRAM_NAME
  parser = DarlingColumnParser.new
  parser.extract_destinations
  p parser.destinations
  parser.extract_archive_uris
  p parser.archive_uris
end
