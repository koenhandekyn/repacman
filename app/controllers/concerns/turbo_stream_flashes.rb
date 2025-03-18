module TurboStreamFlashes
  extend ActiveSupport::Concern
  include TurboStreamBase

  # Appends a flash message to the flashes container
  def send_flash(message, type)
    turbo_stream.append("flashes", partial: "shared/flash", locals: { message:, type: })
  end
end
