module DeviseHelper
  def devise_error_messages!
    return "" unless devise_error_messages?

    messages = resource.errors.full_messages.map { |msg| content_tag(:li, msg) }.join

    html = <<-HTML
    <div class="alert alert-danger alert-password" role="alert" id="error_explanation">
      <button type="button" class="close" data-dismiss="alert">x</button>
      <ul class="list-unstyled">
        #{messages}
      </ul>
    </div>
    HTML

    html.html_safe
  end

  def devise_error_messages?
    !resource.errors.empty?
  end

end