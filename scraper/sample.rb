require 'open-uri'
require 'nokogiri'

uri = 'https://www.google.co.jp/search?q=nokogiri'

charset = nil
html = open(uri, ssl_verify_mode: OpenSSL::SSL::VERIFY_NONE) do |f|
  charset = f.charset
  f.read
end

doc = Nokogiri::HTML(html, nil, charset)
doc.css('cite').each do |node|
  puts node.text
end
