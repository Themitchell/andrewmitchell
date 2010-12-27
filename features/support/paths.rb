module NavigationHelpers
  # Maps a name to a path. Used by the
  #
  #   When /^I go to (.+)$/ do |page_name|
  #
  # step definition in web_steps.rb
  #
  def path_to(page_name)
    case page_name
    
    # Home paths
    when /the home\s?page/
      '/'
    when /the admin home\s?page/
      '/admin/'
    
    
    # Login paths
    when /the login page/
      new_user_session_path
    when /the logout page/
      destroy_user_session_path
    when /the sign up page/
      new_user_registration_path
    
    # CMS - Users
    when /the admin user index page/
      admin_users_path
    when /the admin edit user page for user "([^\"]*)"$/
      user = User.find_by_username($1)
      edit_admin_user_path(user)
    when /the admin page for user "([^\"]*)"$/
      user = User.find_by_username($1)
      admin_user_path(user)
      
    # Users
    when /the show page for user "([^\"]*)"$/
      user = User.find_by_username($1)
      user_path(user)
    when /the edit page for user "([^\"]*)"$/
      user = User.find_by_username($1)
      edit_user_path(user)
      
      
    # CMS - Posts
    when /the admin post index/
      admin_posts_path
    when /the admin new post page/
      new_admin_post_path
    when /the admin show page for post "([^\"]*)"$/
      post = Post.find_by_title($1)
      admin_post_path(post)
    when /the admin edit page for post "([^\"]*)"$/
      post = Post.find_by_title($1)
      edit_admin_post_path(post)
    
    # Posts
    when /the post index page/
      posts_path 
    when /the page for post "([^\"]*)"$/
      post = Post.find_by_title!($1)
      post_path(post)
      
      when /the new comment page for post "([^\"]*)"$/
        post = Post.find_by_title!($1)
        new_post_comment_path(post)
      
    # CMS - Pictures
    when /the admin picture index/
      admin_pictures_path
    when /the admin new picture page/
      new_admin_picture_path
    when /the admin show page for picture "([^\"]*)"$/
      picture = Picture.find_by_title($1)
      admin_picture_path(picture)
    when /the admin edit page for picture "([^\"]*)"$/
      picture = Picture.find_by_title($1)
      edit_admin_picture_path(picture)
    
    # Pictures
    when /the picture\s? index page/
      pictures_path
    when /the page for picture "([^\"]*)"$/
      picture = Picture.find_by_title!($1)
      picture_path(picture)
      
      when /the new comment page for picture "([^\"]*)"$/
        picture = Picture.find_by_title!($1)
        new_picture_comment_path(picture)

    # Add more mappings here.
    # Here is an example that pulls values out of the Regexp:
    #
    #   when /^(.*)'s profile page$/i
    #     user_profile_path(User.find_by_login($1))

    else
      begin
        page_name =~ /the (.*) page/
        path_components = $1.split(/\s+/)
        self.send(path_components.push('path').join('_').to_sym)
      rescue Object => e
        raise "Can't find mapping from \"#{page_name}\" to a path.\n" +
          "Now, go and add a mapping in #{__FILE__}"
      end
    end
  end
end

World(NavigationHelpers)
