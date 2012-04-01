module PaperclipHelper
  def has_avatar?
    !avatar_file_name.blank?
  end
  
  def has_picture?
    !picture_file_name.blank?
  end
end