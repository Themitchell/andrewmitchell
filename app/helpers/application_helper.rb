module ApplicationHelper
  def published_on_text(resource)
    resource.published_on.strftime("%d %B, %Y")
  end
  
  def comment_published_on_text(resource)
    resource.created_at.strftime("%d %B, %Y")
  end
end
