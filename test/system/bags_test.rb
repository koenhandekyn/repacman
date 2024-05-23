require "application_system_test_case"

class BagsTest < ApplicationSystemTestCase
  setup do
    @bag = bags(:one)
  end

  test "visiting the index" do
    visit bags_url
    assert_selector "h1", text: "Bags"
  end

  test "should create bag" do
    visit bags_url
    click_on "New bag"

    fill_in "Name", with: @bag.name
    click_on "Create Bag"

    assert_text "Bag was successfully created"
    click_on "Back"
  end

  test "should update Bag" do
    visit bag_url(@bag)
    click_on "Edit this bag", match: :first

    fill_in "Name", with: @bag.name
    click_on "Update Bag"

    assert_text "Bag was successfully updated"
    click_on "Back"
  end

  test "should destroy Bag" do
    visit bag_url(@bag)
    click_on "Destroy this bag", match: :first

    assert_text "Bag was successfully destroyed"
  end
end
