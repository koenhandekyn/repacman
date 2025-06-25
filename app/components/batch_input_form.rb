# frozen_string_literal: true

class Components::BatchInputForm < Components::Base

  def initialize(batch_input:)
    @batch_input = batch_input
  end

  register_element :batch_input

  def view_template
    turbo_frame_tag("input_product_#{@batch_input.product.id}") do
      form_with(model: @batch_input) do |form|
        form.hidden_field(:batch_id)
        batch_input do
          form.hidden_field(:product_id, value: @batch_input.product.id)
          form.text_field(:product_name, value: @batch_input.product.weight, disabled: true)
          form.number_field(:quantity, min: 0.01, step: 0.01, placeholder: "Quantity", class: "text-right", required: true)
          form.text_field(:batch_uid, placeholder: "Batch")
          div(class: "actions") do
            form.submit(@batch_input.persisted? ? "Bewaar" : "Voeg toe")
            if @batch_input.persisted?
              link_to("Wis", @batch_input, data: { turbo_method: :delete }, class: "btn btn-danger")
            else
              div
            end
          end
        end
      end
    end
  end
end
