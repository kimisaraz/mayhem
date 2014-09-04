require 'open-uri'
require 'nokogiri'

class DarlingColumnParser
  def extract_destinations
    uri = 'http://www.1101.com/darling_column/'

    html = open(uri, 'r:Shift_JIS:UTF-8').read.encode('UTF-8', 'Shift_JIS')

    doc = Nokogiri::HTML(html, nil, 'UTF-8')
    doc.css('table:last-child td:nth-child(2) > a').each do |node|
      # p node.inner_text
      destinations << node.attribute('href').value
    end
  end

  def destinations
    @destinations ||= []
  end
end

if __FILE__ == $PROGRAM_NAME
  parser = DarlingColumnParser.new
  parser.extract_destinations
  p parser.destinations
end
