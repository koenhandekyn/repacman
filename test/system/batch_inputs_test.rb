require "application_system_test_case"

class BatchInputsTest < ApplicationSystemTestCase
  setup do
    @batch_input = batch_inputs(:one)
  end

  test "visiting the index" do
    visit batch_inputs_url
    assert_selector "h1", text: "Batch inputs"
  end

  test "should create batch input" do
    visit batch_inputs_url
    click_on "New batch input"

    click_on "Create Batch input"

    assert_text "Batch input was successfully created"
    click_on "Back"
  end

  test "should update Batch input" do
    visit batch_input_url(@batch_input)
    click_on "Edit this batch input", match: :first

    click_on "Update Batch input"

    assert_text "Batch input was successfully updated"
    click_on "Back"
  end

  test "should destroy Batch input" do
    visit batch_input_url(@batch_input)
    click_on "Destroy this batch input", match: :first

    assert_text "Batch input was successfully destroyed"
  end
end
