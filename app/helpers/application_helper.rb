# frozen_string_literal: true

module ApplicationHelper
  def bootstrap_class_for(flash_type)
    {
      alert: 'alert-danger',
      notice: 'alert-success'
    }.stringify_keys[flash_type.to_s] || flash_type.to_s
  end

  def notification_link(user)
    if user.notifications_count.positive?
      render_haml <<~HAML, user: user
        = link_to notificaton_path do
          %span.glyphicon.glyphicon-bell
          = user.notifications_count
      HAML
    else
      render_haml <<~HAML
        %p.navbar-text
          %span.glyphicon.glyphicon-bell 0
      HAML
    end
  end

  def render_haml(haml, locals = {})
    Haml::Engine.new(haml.strip_heredoc, format: :html5).render(self, locals)
  end
end
