module ApplicationHelper
  def published_on_text(resource)
    resource.published_on.strftime("%d %B, %Y")
  end

  def comment_published_on_text(resource)
    resource.created_at.strftime("%d %B, %Y")
  end

  def commentable_path(commentable)
    if commentable.class.name == "Post"
      post_path(commentable)
    elsif commentable.class.name == "Picture"
      photoalbum_picture_path(commentable.photoalbum, commentable)
    end
  end

  def header(header_text)
    header = content_tag :div, :class => 'page-header' do
      content_tag :h1, header_text
    end
    header
  end
end
