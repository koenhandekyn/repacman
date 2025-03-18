module TurboStreamBase
  extend ActiveSupport::Concern

  # Renders multiple stream actions
  def turbo_stream_actions(*stream_actions)
    render turbo_stream: stream_actions.reduce(:+)
  end

  # Creates a stream action for form rendering (append or replace)
  def append_or_update_form(container_id, partial:, locals:, append: true)
    # Determine stream action (append or replace)
    action = append ? :append : :replace
    turbo_stream.send(action, container_id, partial:, locals:)
  end
end
