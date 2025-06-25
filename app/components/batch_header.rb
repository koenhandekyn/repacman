# frozen_string_literal: true

class Components::BatchHeader < Components::Base
  include Phlex::Rails::Helpers::Routes
  include Phlex::Rails::Helpers::L

  register_element :batch_card
  register_element :batch_header
  register_element :batch_produced_at
  register_element :batch_best_before
  register_element :batch_family
  register_element :batch_weight
  register_element :batch_uid

  def initialize(batch)
    @batch = batch
  end

  def view_template
    batch_card do
      batch_header do
        batch_produced_at { "Productie: #{l(@batch.produced_at, format: :short)}" }
        batch_best_before { "THT: #{l(@batch.best_before_date.to_date, format: :long)}" }
        batch_family(class: "title", data: { family_id: @batch.family_id }) { @batch.family.name }
        batch_weight { @batch.weight_base.to_s }
      end
      batch_uid(class: "center mt") do
        span { Barby::Code128B.new(@batch.batch_uid).to_html.html_safe }
        pre(class: "barby-barcode") { @batch.batch_uid }
      end
    end
  end
end
