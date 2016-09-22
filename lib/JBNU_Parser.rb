require 'Post'
class JBNU_Parser

  # String[] boardId = {"K_PUBLIC","K_NOTICE","K_RECRUIT","K_SEMINAR","K_STUDY","K_ALBA","K_MARKET","K_LIVE","K_FOUND"};


  def boardId(id)
    boardId_t = ["K_PUBLIC","K_NOTICE","K_RECRUIT","K_SEMINAR","K_STUDY","K_ALBA","K_MARKET","K_LIVE","K_FOUND"]
    return boardId_t[id]
  end

  def requestHTML(id,word)

    if word == ""
      uri = URI(URI.encode("http://www.chonbuk.ac.kr/bb/board.php?boardID="+boardId(id)))
    else
      uri = URI(URI.encode("http://www.chonbuk.ac.kr/bb/board.php?boardID="+boardId(id)+"&cTitle=Y&query="+word))
    end
    req = Net::HTTP::Get.new(uri)

    res = Net::HTTP.start(uri.hostname, uri.port, :use_ssl => uri.scheme == 'https') { |http| http.request(req) }
    doc = Nokogiri::HTML(res.body)

    return doc
  end

  def getPosts(id,word)
    if id < 4
      return requestNotice(id,word)
    else
      return requestPosts(id,word)
    end
  end


  def requestPosts(id,word)

    doc = requestHTML(id,word)

    posts = []

    doc.css(".programInfo//strong").each do |size_string|
      unless size_string.inner_text == "0"
        doc.css(".listBoard//tbody//tr").each do |post_data|

          number = post_data.css("td")[0].inner_text
          title = post_data.css("th")[0].inner_text
          writer = post_data.css("td")[3].inner_text
          period = post_data.css("td")[4].inner_text

          content_link = post_data.css("th//a")[0].attr('href')

          post = Post.new(number,title,content_link,period,writer)

          posts << post

        end
      else
        posts << Post.new("","검색자료가 없습니다","","","")
      end
    end

    return posts
  end

  def requestNotice(id,word)
    doc = requestHTML(id,word)

    posts = []

    doc.css(".programInfo//strong").each do |size_string|
      unless size_string.inner_text == "0"


        doc.css(".listBoard//tbody//tr").each do |post_data|

          number = post_data.css("td")[0].inner_text
          title = post_data.css("th")[0].inner_text
          writer = post_data.css("td")[2].inner_text
          period = post_data.css("td")[3].inner_text.to_s.split(" ~")[0]

          content_link = post_data.css("th//a")[0].attr('href')

          post = Post.new(number,title,content_link,period,writer)

          posts << post
        end

      else
        posts << Post.new("검색자료가없습니다","","","","")


      end
    end


    return posts

  end

end
