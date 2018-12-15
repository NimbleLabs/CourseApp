module ApplicationHelper
  def resource_name
    :user
  end

  def customer?
    user_signed_in? && current_user.customer?
  end

  def resource
    @resource ||= User.new
  end

  def resource_class
    User
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end

  def devise_error_messages
    return "" if resource.errors.empty?

    messages = resource.errors.full_messages.map { |msg| content_tag(:li, msg) }.join

    html = <<-HTML
    <div id="error_explanation" class="alert alert-warning">
      <h4 class="alert-heading">Registration error(s):</h4>
      <ul>#{messages}</ul>
    </div>
    HTML

    html.html_safe
  end

  def current_conversation
    if user_signed_in?
      Conversation.from_user(current_user)
    else
      return nil if current_visit.blank?
      Conversation.from_visit(current_visit)
    end
  end
end
