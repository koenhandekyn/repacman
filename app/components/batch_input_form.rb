# frozen_string_literal: true

class Components::BatchInputForm < Components::Base
  include Phlex::Rails::Helpers::TextField
  include Phlex::Rails::Helpers::NumberToPercentage
  include Phlex::Rails::Helpers::NumberWithPrecision
  include BatchFormattingHelper

  def initialize(batch_input:, assembly:)
    @batch_input = batch_input
    @assembly = assembly
  end

  register_element :batch_input

  def status_indicator
    case @batch_input.batch.assembly_status(@assembly)[:status]
    when :above
      span(class: "material-symbols-outlined", style: "color: red") { "arrow_upward" }
    when :below
      span(class: "material-symbols-outlined", style: "color: red") { "arrow_downward" }
    when :matching
      span(class: "material-symbols-outlined", style: "color: green") { "arrow_forward" }
    end
  end

  def save_button_icon = span(class: "material-symbols-outlined") { "save" }

  def fraction = format_fraction(@assembly)

  def target_weight
    "= #{format_weight_with_units(@assembly.fraction_of_weight(@batch_input.batch.weight_base))}"
  end

  def product_weight
    "x #{format_weight_with_units(@batch_input.product.weight_base)}"
  end

  def weight
    "= #{format_weight_with_units(@batch_input.weight_base)}"
  end

  def available_batch_uids
    @batch_input.product.production_inputs_batch
                .distinct
                .pluck(:batch_number)
                .compact
                .reject(&:blank?)
                .sort
  end

  def view_template
    turbo_frame_tag("input_product_#{@batch_input.product.id}") do
      form_with(model: @batch_input) do |form|
        form.hidden_field(:batch_id)
        batch_input do
          form.hidden_field(:product_id, value: @batch_input.product.id)
          form.text_field(:step, value: @batch_input.assembly.step, disabled: true)
          form.text_field(:product_name, value: @batch_input.product.name, disabled: true)
          form.text_field(:fraction, value: fraction, disabled: true, class: "text-right")
          # show the ingredient weight
          form.text_field(:target_weight, value: target_weight, disabled: true, class: "xtext-right")
          form.number_field(:quantity, min: 0.00, step: 0.01, placeholder: "Quantity", class: "text-right", required: true)
          form.text_field(:product_weight, value: product_weight, disabled: true, class: "text-right")
          form.text_field(:weight, value: weight, disabled: true, class: "xtext-right")
          form.text_field(:batch_uid, placeholder: "Batch", list: "batch_uid_list", autocomplete: "off")
          datalist(id: "batch_uid_list") do
            available_batch_uids.each do |batch_uid|
              option(value: batch_uid.to_s.strip)
            end
          end
          div(style: "display: flex; align-items: center;") { status_indicator }
          div(class: "actions justify-content-right") do
            button(type: "submit") do
              save_button_icon
            end
          end
        end
      end
    end
  end
end
