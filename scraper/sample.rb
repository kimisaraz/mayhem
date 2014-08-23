require 'open-uri'
require 'nokogiri'

uri = 'http://www.google.com'
doc = Nokogiri::HTML(open(uri))

puts doc.title
