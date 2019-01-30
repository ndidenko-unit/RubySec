class ParserController < ApplicationController
  require 'open-uri'
  require 'nokogiri'
  require 'openssl'

  def rubysec
    source = 'https://rubysec.com/advisories'
    html = open(source, {ssl_verify_mode: OpenSSL::SSL::VERIFY_NONE})

    doc = Nokogiri::HTML(html)
    # links = doc.css('table.table a').map { |link| link['href'] }

    data = []
    doc.css('table.table tr td').each do |td|
      if td.children[0].present?
        data << td.children[0].to_s.strip
      else
        data << td.children[1].attributes['href'].to_s
        data << td.children[1].children.to_s
      end
    end
    @data = data.in_groups_of(5).map { |arr| [:date, :rubygem, :link, :title, :cve].zip(arr).to_h }
  end
end
