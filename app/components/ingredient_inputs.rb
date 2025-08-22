# frozen_string_literal: true
class Components::IngredientInputs < Components::Base
  def initialize(assembly:, batch:)
    @batch = batch
    @products = Product.preffered_input.by_family(assembly.child).sorted_by_weight
    @assembly = assembly
  end

  register_element :ingredient_inputs

  def view_template
    # ingredient_inputs do
    @products.each do |product|
      batch_input = @batch.batch_inputs.find_or_initialize_by(batch: @batch, product:)
      Components::BatchInputForm(batch_input:, assembly: @assembly)
    end
    # end
  end
end
