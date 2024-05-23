require "application_system_test_case"

class PrintedsTest < ApplicationSystemTestCase
  setup do
    @printed = printeds(:one)
  end

  test "visiting the index" do
    visit printeds_url
    assert_selector "h1", text: "Printeds"
  end

  test "should create printed" do
    visit printeds_url
    click_on "New printed"

    fill_in "Batch", with: @printed.Batch
    fill_in "Xmlexported", with: @printed.XMLExported
    fill_in "Itemcode", with: @printed.itemCode
    click_on "Create Printed"

    assert_text "Printed was successfully created"
    click_on "Back"
  end

  test "should update Printed" do
    visit printed_url(@printed)
    click_on "Edit this printed", match: :first

    fill_in "Batch", with: @printed.Batch
    fill_in "Xmlexported", with: @printed.XMLExported
    fill_in "Itemcode", with: @printed.itemCode
    click_on "Update Printed"

    assert_text "Printed was successfully updated"
    click_on "Back"
  end

  test "should destroy Printed" do
    visit printed_url(@printed)
    click_on "Destroy this printed", match: :first

    assert_text "Printed was successfully destroyed"
  end
end
