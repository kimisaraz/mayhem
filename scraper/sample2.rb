require 'open-uri'
require 'nokogiri'

class DarlingColumnParser
  def extract_destinations
    uri = 'http://www.1101.com/darling_column/'

    html = open(uri, 'r:Shift_JIS:UTF-8').read.encode('UTF-8', 'Shift_JIS')

    doc = Nokogiri::HTML(html, nil, 'UTF-8')
    doc.css('table:last-child td:nth-child(2) > a').each do |node|
      p node.inner_text
      p node.attribute('href').value
    end
  end
end

if __FILE__ == $PROGRAM_NAME
  DarlingColumnParser.new.extract_destinations
end
