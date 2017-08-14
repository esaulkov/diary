# frozen_string_literal: true

module EventsHelper
  def delete_event_link(event)
    if event.user == current_user
      render_haml <<~HAML, event: event
        = link_to event, method: :delete, data: {confirm: t('actions.confirmation')} do
          %span.glyphicon.glyphicon-trash
          = t 'actions.destroy'
      HAML
    else
      render_haml <<~HAML, event: event
        = link_to delete_event_path(id: event.id), method: :delete do
          %span.glyphicon.glyphicon-remove
          = t 'actions.remove'
      HAML
    end
  end

  def edit_event_link(event)
    return unless event.user == current_user
    render_haml <<~HAML, event: event
      = link_to edit_event_path(event) do
        %span.glyphicon.glyphicon-pencil
        = t 'actions.edit'
    HAML
  end
end
