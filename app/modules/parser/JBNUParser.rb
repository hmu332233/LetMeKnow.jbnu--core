require 'Post'
class JBNUParser

  # String[] boardId = {"K_PUBLIC","K_NOTICE","K_RECRUIT","K_SEMINAR","K_STUDY","K_ALBA","K_MARKET","K_LIVE","K_FOUND"};

  def boardId(id)
    # boardId_t = ["K_PUBLIC","K_NOTICE","K_RECRUIT","K_SEMINAR","K_STUDY","K_ALBA","K_MARKET","K_LIVE","K_FOUND"]
    boardId_t = ["139","139","140","141","150","425","152","153","154"]
    return boardId_t[id]
  end

  def requestHTML(id,word)

    if word == ""
      uri = URI(URI.encode("https://www.jbnu.ac.kr/kor/?menuID="+boardId(id)))
    else
      uri = URI(URI.encode("http://www.chonbuk.ac.kr/bb/board.php?boardID="+boardId(id)+"&cTitle=Y&query="+word))
    end
    req = Net::HTTP::Get.new(uri)

    res = Net::HTTP.start(uri.hostname, uri.port, :use_ssl => uri.scheme == 'https') { |http| http.request(req) }
    doc = Nokogiri::HTML(res.body)

    return doc
  end

  def getPosts(id,word)
    case id
    when 5
      return requestPosts(id,word)
    else
      return requestNotice(id,word)
    end
  end


  def requestPosts(id,word)

    doc = requestHTML(id,word)

    posts = []

    doc.css(".page_list//tbody//tr").each_with_index do |post_data, index|

      number = post_data.css(".mnom")[0].inner_text
      title = post_data.css(".left span")[0].inner_text.to_s.strip + "\n" + post_data.css(".mnom")[1].inner_text
      writer = post_data.css(".mview")[0].inner_text
      period = post_data.css(".mview")[2].inner_text

      content_link = post_data.css(".left span a")[0].attr('href')

      post = Post.new(number,title,content_link,period,writer,boardId(id))
    
      posts << post
    end

    return posts
  end

  def requestNotice(id,word)
    doc = requestHTML(id,word)

    posts = []

    doc.css(".page_list//tbody//tr").each_with_index do |post_data, index|

      number = post_data.css(".mnom")[0].inner_text
      title = post_data.css(".left span")[0].inner_text
      writer = post_data.css(".mview")[0].inner_text
      period = post_data.css(".mview")[1].inner_text

      content_link = post_data.css(".left span a")[0].attr('href')

      post = Post.new(number,title,content_link,period,writer,boardId(id))
    
      posts << post
    end

    return posts

  end

end
