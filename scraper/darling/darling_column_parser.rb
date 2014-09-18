require 'open-uri'
require 'nokogiri'

class DarlingColumnParser
  BASE_URI = 'http://www.1101.com/darling_column/'

  attr_accessor :column_uris

  def initialize
    self.column_uris = []
  end

  # def extract_article
  #   dummy_column_uris = ["2008-06-23.html", "2008-06-30.html"]

  #   dummy_column_uris.each do |column_uri|
  #     uri = File.join(BASE_URI, column_uri)
  #     html = open(uri, 'r:Shift_JIS:UTF-8').read.encode('UTF-8', 'Shift_JIS')

  #     doc = Nokogiri::HTML(html, nil, 'UTF-8')
  #     doc.css('table[width = "500"] td').each do |node|
  #       puts node.inner_text
  #     end

  #     sleep(5)
  #   end
  # end

  def extract_column_uris
    open_uris.each do |uri|
      puts "Parsing #{uri}"

      html = open(uri, 'r:Shift_JIS:UTF-8').read.encode('UTF-8', 'Shift_JIS')

      doc = Nokogiri::HTML(html, nil, 'UTF-8')
      doc.css('table[cellspacing = "3"] td:nth-child(2) a').each do |node|
        column_uris << URI.join(uri, node.attribute('href').value).to_s
      end

      sleep(5)
    end

    column_uris << BASE_URI
  end

  def save_column_uris
    File.open("#{__dir__}/darling_column_uris.txt", 'w') { |f|
      column_uris.each do |column_uri|
        f.puts column_uri
      end
    }
  end

  private

  def open_uris
    archive_uris = (1..11).map { |num| format("#{BASE_URI}archive/archive%02d.html", num) }
    archive_uris << BASE_URI
  end
end

if __FILE__ == $PROGRAM_NAME
  parser = DarlingColumnParser.new
  parser.extract_column_uris
  parser.save_column_uris
  p parser.column_uris
end
