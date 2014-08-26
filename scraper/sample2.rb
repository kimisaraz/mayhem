require 'open-uri'
require 'nokogiri'

uri = 'http://www.1101.com/darling_column/'

charset = nil
html = open(uri) do |f|
  charset = f.charset
  f.read
end

doc = Nokogiri::HTML(html, nil, charset)
doc.css('a').each do |node|
  href = node.attribute('href')
  puts href.value if href
end
