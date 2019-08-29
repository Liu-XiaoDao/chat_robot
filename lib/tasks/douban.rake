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
        # STDOUT.puts "选择正确的图书? (1,2,3.../9)"
        # input = Integer(STDIN.gets.strip)
        # if input != 9
          book.update(douban_url: "https://m.douban.com#{lis.at(0).>('a').attr('href').text}")
          puts "#{book.name}获取豆瓣链接完成"
        # end
      end
    end
  end

  desc "从豆瓣上抓取详细信息"
  task(:fetch_book_detail => :environment) do
    Book.where(isbn: nil).each do |book|
      # uri = URI.parse()
      begin
        html =  RestClient.get(URI.escape(book.douban_url)).body
        doc  =  Nokogiri::HTML.parse(html)

        img_url = doc.css('.nbg').attr('href').text
        info = doc.css('.subject > #info').text.gsub("\n", "").gsub("\s", "")
        if info.present?
          c_index = info.index("出版社")
          c_index = c_index.present? ? c_index - 1 : 0
          author = info[0..c_index]

          i_index = info.index("ISBN")
          i_index = i_index.present? ? i_index : -1
          isbn = info[i_index..-1]
        end
        summary = doc.css('.related_info .intro').text
        book.update(author: author, intro: summary, isbn: isbn, img_url: img_url, info: info)
        puts "#{book.name}获取豆瓣详情完成"
      rescue => e
        puts "ERROR:#{book.name}------获取豆瓣详情出错"
      end
    end
  end

  desc "使用isbn获取图书信息"
  task(:fetch_book_detail_use_isbn => :environment) do
    @progress_bar ||= ProgressBar.create(
      :format         => "%t - %c / %C %b>%i %p%% %t",
      :total          => ['1', '2'].size
    )
    Tempfile.create("s29383634.jpg", encoding: 'ascii-8bit') do |tmpfile|
      tmpfile << HTTParty.get("https://img3.doubanio.com/view/subject/l/public/s29383634.jpg")
      tmpfile.flush
      FileUtils.cp tmpfile, File.join(".", "s29383634.jpg")
    end
    binding.pry

    TempBookIsbn.all.each do |isbn|
      # uri = URI.parse()
      begin
        html =  RestClient.get(URI.escape("https://book.douban.com/isbn/9787515404769/")).body
        doc  =  Nokogiri::HTML.parse(html)
binding.pry
        img_url = doc.css('.nbg').attr('href').text
        info = doc.css('.subject > #info').text.gsub("\n", "").gsub("\s", "")
        if info.present?
          c_index = info.index("出版社")
          c_index = c_index.present? ? c_index - 1 : 0
          author = info[0..c_index]

          i_index = info.index("ISBN")
          i_index = i_index.present? ? i_index : -1
          isbn = info[i_index..-1]
        end
        summary = doc.css('.related_info .intro').text
        book.update(author: author, intro: summary, isbn: isbn, img_url: img_url, info: info)
        puts "#{book.name}获取豆瓣详情完成"
      rescue => e
        puts "ERROR:#{book.name}------获取豆瓣详情出错"
      end
    end


  end

  desc "从豆瓣上下载封面图片"
  task(:wget_img => :environment) do
    Book.where(isbn: nil).each do |book|
      # uri = URI.parse()
      begin
        html =  RestClient.get(URI.escape(book.douban_url)).body
        doc  =  Nokogiri::HTML.parse(html)

        img_url = doc.css('.nbg').attr('href').text
        info = doc.css('.subject > #info').text.gsub("\n", "").gsub("\s", "")
        if info.present?
          c_index = info.index("出版社")
          c_index = c_index.present? ? c_index - 1 : 0
          author = info[0..c_index]

          i_index = info.index("ISBN")
          i_index = i_index.present? ? i_index : -1
          isbn = info[i_index..-1]
        end
        summary = doc.css('.related_info .intro').text
        book.update(author: author, intro: summary, isbn: isbn, img_url: img_url, info: info)
        puts "#{book.name}获取豆瓣详情完成"
      rescue => e
        puts "ERROR:#{book.name}------获取豆瓣详情出错"
      end
    end
  end

end
