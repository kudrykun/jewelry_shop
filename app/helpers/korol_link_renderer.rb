class KorolLinkRenderer < WillPaginate::ActionView::LinkRenderer
  def container_attributes
    {class: "pagination left-align center-on-sm-and-down"}
  end

  def html_container(html)
    tag(:ul, html, container_attributes)
  end

  def page_number(page)
    if page == current_page
      tag :li,link(page, page, class: '', rel: rel_value(page)), class: 'active'
    else
      tag :li,link(page, page, class: '', rel: rel_value(page)), class: 'waves_effect'
    end
  end

  def gap
    text = @template.will_paginate_translate(:page_gap) { '&hellip;' }
    %(<span class="mr2">#{text}</span>)
  end

  def previous_page
    num = @collection.current_page > 1 && @collection.current_page - 1
    if num
      tag :li,previous_or_next_page(num, @options[:previous_label], ''), class: 'waves_effect'
    else
      tag :li,previous_or_next_page(num, @options[:previous_label], ''), class: 'disabled'
    end
  end

  def next_page
    num = @collection.current_page < total_pages && @collection.current_page + 1
    if num
      tag :li,previous_or_next_page(num, @options[:next_label], ''), class: 'waves_effect'
    else
      tag :li,previous_or_next_page(num, @options[:next_label], ''), class: 'disabled'
    end

  end
=begin
<i class="material-icons">chevron_right</i>
=end

  def previous_or_next_page(page, text, classname)
    if page
      link(text, page, :class => classname)

    else
      tag(:a, text, :class => classname + ' bg-dark-blue near-white')
    end
  end

end