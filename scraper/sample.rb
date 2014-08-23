require 'open-uri'
require 'nokogiri'

uri = 'https://www.google.com'

charset = nil
html = open(uri, ssl_verify_mode: OpenSSL::SSL::VERIFY_NONE) do |f|
  charset = f.charset
  f.read
end

doc = Nokogiri::HTML(html, nil, charset)

puts doc.title
