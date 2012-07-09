module Displayable
  def display_name
    return title if respond_to? :title
    return name if respond_to? :name
    return to_param.to_s
  end
end