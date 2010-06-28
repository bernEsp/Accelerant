module CommentsHelper

  def show_comment(comment)
    show_comment = "<h1>TEST</h1>"
    show_comment = show_comment + "<h2>test</h2>"
    show_comment = show_comment + render_avatar(comment.user)
    return show_comment
  end

end
