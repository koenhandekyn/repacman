require "application_system_test_case"

class PlantsTest < ApplicationSystemTestCase
  setup do
    @plant = plants(:one)
  end

  test "visiting the index" do
    visit plants_url
    assert_selector "h1", text: "Plants"
  end

  test "should create plant" do
    visit plants_url
    click_on "New plant"

    fill_in "City", with: @plant.city
    fill_in "Country", with: @plant.country
    fill_in "Streetnr", with: @plant.streetnr
    fill_in "Zip", with: @plant.zip
    click_on "Create Plant"

    assert_text "Plant was successfully created"
    click_on "Back"
  end

  test "should update Plant" do
    visit plant_url(@plant)
    click_on "Edit this plant", match: :first

    fill_in "City", with: @plant.city
    fill_in "Country", with: @plant.country
    fill_in "Streetnr", with: @plant.streetnr
    fill_in "Zip", with: @plant.zip
    click_on "Update Plant"

    assert_text "Plant was successfully updated"
    click_on "Back"
  end

  test "should destroy Plant" do
    visit plant_url(@plant)
    click_on "Destroy this plant", match: :first

    assert_text "Plant was successfully destroyed"
  end
end
