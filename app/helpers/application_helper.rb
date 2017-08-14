# frozen_string_literal: true

module ApplicationHelper
  def bootstrap_class_for(flash_type)
    {
      alert: 'alert-danger',
      notice: 'alert-success'
    }.stringify_keys[flash_type.to_s] || flash_type.to_s
  end

  def render_haml(haml, locals = {})
    Haml::Engine.new(haml.strip_heredoc, format: :html5).render(self, locals)
  end
end
