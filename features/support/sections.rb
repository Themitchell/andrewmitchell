module SectionHelpers
  def xpath_of_section(section_name, prefix = "//")
    case section_name
      
      
    when 'nav bar section'
      "#{prefix}*[contains(@id, 'nav')]"

    when 'pagination section'
      "#{prefix}*[contains(@class, 'pagination')]"

    when "page"
      "#{prefix}body"
      
    when 'admin users section'
      "#{prefix}*[contains(@id, 'user_index admin')]"
      
    when 'admin show user section'
      "#{prefix}*[contains(@id, 'user admin')]"
      
    when /section for user "([^\"]*)"$/
      user = User.find_by_username($1)
      "#{prefix}*[contains(@class, '#{user.id}')]"
      
    when 'comments section'
      "#{prefix}*[contains(@class, 'comments')]"
      
    else
      raise "Can't find mapping from \"#{section_name}\" to a section."
    end
  end
  
  def within_section(section_name)
    within :xpath, xpath_of_section(section_name) do
      yield
    end
  end
end

World(SectionHelpers)
