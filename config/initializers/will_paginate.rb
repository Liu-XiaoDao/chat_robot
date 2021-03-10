require 'will_paginate/view_helpers/action_view'
module WillPaginate
  module ActionView

    class BlogLinkRenderer < LinkRenderer
      protected
      def html_container(html)
        tag :div, tag(:ul, html), class: "pagination pagination-centered"
      end

      def page_number(page)
        if page == current_page
          # tag :li, link(page, page, rel: rel_value(page)),  class: 'disabled'
          # tag :li, link(page, page,{rel: rel_value(page), disabled: "disabled"}),  class: 'disabled'
          tag :li, link(page, "javascript:void(0)", rel: rel_value(page)),  class: 'disabled'
        else
          tag :li, link(page, page, rel: rel_value(page))
        end
      end

      def gap
        # tag :span, '&hellip;'.html_safe, class: 'space'
        tag :li, link('&hellip;', "#")
      end

      def previous_or_next_page(page, text, classname)
        if page
          text = text.match(/Pre/) ? "<<" : ">>"
          tag :li, link(text, page, class: ('page-number' if @options[:page_links]))
        end
      end
    end
  end
end
