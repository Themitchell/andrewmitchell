module BootstrapHelper

  def bootstrap_page_header(*args, &block)
    header_type = args[0]
    if block_given?
      html_options  = args[1] || {}
      html_options  = html_options.merge_with_string_concat(:class => "page-header")
      content_tag(:div, content_tag(header_type, capture(&block)), html_options)
    else
      text          = args[1]
      html_options  = args[2] || {}
      html_options  = html_options.merge_with_string_concat(:class => "page-header")
      tag_options   = tag_options(html_options)
      "<div #{tag_options}><#{header_type.to_s}>#{ERB::Util.html_escape(text)}</#{header_type.to_s}></div>".html_safe
    end
  end

  def bootstrap_sub_header(*args, &block)
    if block_given?
      html_options  = args[0] || {}
      content_tag(:small, capture(&block), html_options)
    else
      text          = args[0]
      html_options  = args[1] || {}
      tag_options   = tag_options(html_options)
      "<small #{tag_options}>#{ERB::Util.html_escape(text)}</small>".html_safe
    end
  end
end
