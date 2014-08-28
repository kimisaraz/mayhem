require 'open-uri'
require 'nokogiri'

uri = 'http://www.1101.com/darling_column/'

html = open(uri, 'r:Shift_JIS').read.encode('UTF-8', 'Shift_JIS')

doc = Nokogiri::HTML(html, nil, 'UTF-8')
doc.css('table:last-child td:nth-child(2) > a').each do |node|
  puts node.attribute('href').value
  puts node.inner_text
end
