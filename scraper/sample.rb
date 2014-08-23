require 'open-uri'
require 'nokogiri'

uri = 'http://www.google.com'

charset = nil
html = open(uri) do |f|
  charset = f.charset
  f.read
end

doc = Nokogiri::HTML(html, nil, charset)

puts doc.title
