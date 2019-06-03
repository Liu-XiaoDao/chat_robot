namespace :douban do
  desc "从豆瓣上抓取图书信息"
  task(:fetch_book_info => :environment) do
    Book.where(isbn: nil).each do |book|
      # uri = URI.parse()
      html =  RestClient.get(URI.escape("https://m.douban.com/search/?query=#{book.name}")).body
      doc  =  Nokogiri::HTML.parse(html)
      lis = doc.css('.search_results_subjects > li')
      if lis.count == 1
        book.update(douban_url: "https://m.douban.com#{lis.last.>('a').attr('href').text}")
        puts "#{book.name}获取豆瓣链接完成"
      else
        lis.each_with_index do |li, index|
          # str = li.>('a').attr('href').text
          puts "#{index}---#{li.css('.subject-title').text}"
        end
        STDOUT.puts "选择正确的图书? (1,2,3.../9)"
        input = Integer(STDIN.gets.strip)
        if input != 9
          book.update(douban_url: "https://m.douban.com#{lis.at(input).>('a').attr('href').text}")
          puts "#{book.name}获取豆瓣链接完成"
        end
      end
    end
  end
end
