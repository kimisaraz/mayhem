require 'open-uri'
require 'nokogiri'

uri = 'http://www.1101.com/darling_column/'

charset = nil
html = open(uri) do |f|
  charset = f.charset
  f.read
end

doc = Nokogiri::HTML(html, nil, charset)
doc.css('table:last-child td:nth-child(2) > a').each do |node|
  puts node.attribute('href').value
  puts node.inner_text
end
