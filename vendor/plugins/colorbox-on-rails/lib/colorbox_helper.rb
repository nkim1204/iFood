module ColorboxHelper
  def include_colorbox_assets
    return "#{stylesheet_link_tag 'colorbox'} \n 
            #{javascript_include_tag 'colorbox'} \n
            #{javascript_include_tag 'colorbox_init'} \n"
  end
  
  # The code below was stripped right out of Rails' core and modified to fit my uses.
  def link_to_colorbox_iframe(*args, &block)
    if block_given?
      options      = args.first || {}
      html_options = args.second
      concat(link_to(capture(&block), options, html_options))
    else
      name         = args[0]
      options      = args[1] || {}
      html_options = args[2]

      url = url_for(options)

      if html_options
        html_options = html_options.stringify_keys
        href = html_options['href']
        convert_options_to_javascript!(html_options, url)
        tag_options = tag_options(html_options)
      else
        tag_options = nil
      end

      href_attr = "href=\"#{url}\"" unless href
      "<a #{href_attr}#{tag_options} class=\"iframe\">#{ERB::Util.h(name || url)}</a>"
    end
  end
  
  def link_to_colorbox(*args, &block)
    if block_given?
      options      = args.first || {}
      html_options = args.second
      concat(link_to(capture(&block), options, html_options))
    else
      name         = args[0]
      options      = args[1] || {}
      html_options = args[2]

      url = url_for(options)

      if html_options
        html_options = html_options.stringify_keys
        href = html_options['href']
        convert_options_to_javascript!(html_options, url)
        tag_options = tag_options(html_options)
      else
        tag_options = nil
      end

      href_attr = "href=\"#{url}\"" unless href
      "<a #{href_attr}#{tag_options} class=\"colorbox\">#{ERB::Util.h(name || url)}</a>"
    end
  end
end