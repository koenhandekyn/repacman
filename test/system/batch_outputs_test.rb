require "application_system_test_case"

class BatchOutputsTest < ApplicationSystemTestCase
  setup do
    @batch_output = batch_outputs(:one)
  end

  test "visiting the index" do
    visit batch_outputs_url
    assert_selector "h1", text: "Batch outputs"
  end

  test "should create batch output" do
    visit batch_outputs_url
    click_on "New batch output"

    click_on "Create Batch output"

    assert_text "Batch output was successfully created"
    click_on "Back"
  end

  test "should update Batch output" do
    visit batch_output_url(@batch_output)
    click_on "Edit this batch output", match: :first

    click_on "Update Batch output"

    assert_text "Batch output was successfully updated"
    click_on "Back"
  end

  test "should destroy Batch output" do
    visit batch_output_url(@batch_output)
    click_on "Destroy this batch output", match: :first

    assert_text "Batch output was successfully destroyed"
  end
end
