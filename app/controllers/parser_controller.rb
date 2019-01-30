class ParserController < ApplicationController
  require 'open-uri'
  require 'nokogiri'

  def index
    @posts = Post.all.reverse_order.paginate(page: params[:page], per_page: 30)
  end

  def rubysec
    page = 1
    all_data = []                                        #data from all pages
    loop do
      data = []                                          #data from one page
      source = "https://rubysec.com/advisories?page=#{page}"
      html = open(source, {ssl_verify_mode: OpenSSL::SSL::VERIFY_NONE})

      doc = Nokogiri::HTML(html)
      doc.css('table.table tr td').each do |td|
        if td.children[0].present?
          data << td.children[0].to_s.strip              # parse date, rubygem and CVE
        elsif td.children[1].present?
          data << td.children[1].attributes['href'].to_s #parse link
          data << td.children[1].children.to_s           #parse title
        else
          data << " "                                    #empty CVE
        end
      end
      break if data.empty? || Post.count > 0             #parse all page only first time
      all_data += data
      page += 1
    end
    all_data = all_data.in_groups_of(5).reverse.
        map { |arr| [:date, :rubygem, :link, :title, :cve].zip(arr).to_h }
    binding.pry
  end
end
