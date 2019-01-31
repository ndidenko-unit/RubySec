require 'sidekiq-scheduler'
require 'open-uri'
require 'nokogiri'

class ParsingJob < ApplicationJob
  queue_as :default

  def perform(*args)
    # Post.create(date: 'test3', rubygem: 'test3', link: 'test3', title: 'test3')
    before_count = Post.count
    all_data = parse_all_data
    if all_data.count > before_count
      new_posts = all_data.last(all_data.count - before_count)
      Post.create(new_posts)
    else
      Post.last.update(updated_at: Time.now)
    end
  end

  private
  def parse_all_data
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
      break if data.empty?
      all_data += data
      page += 1
    end
    all_data.in_groups_of(5).reverse.
        map { |arr| [:date, :rubygem, :link, :title, :cve].zip(arr).to_h }
  end
end