require "application_system_test_case"

class FamiliesTest < ApplicationSystemTestCase
  setup do
    @family = families(:one)
  end

  test "visiting the index" do
    visit families_url
    assert_selector "h1", text: "Families"
  end

  test "should create family" do
    visit families_url
    click_on "New family"

    fill_in "Additives", with: @family.additives
    fill_in "Claims", with: @family.claims
    fill_in "Components", with: @family.components
    fill_in "Composition", with: @family.composition
    fill_in "Dosage", with: @family.dosage
    fill_in "Instructions", with: @family.instructions
    fill_in "Manufacturer code", with: @family.manufacturer_code
    fill_in "Name", with: @family.name
    fill_in "Tht months", with: @family.tht_months
    click_on "Create Family"

    assert_text "Family was successfully created"
    click_on "Back"
  end

  test "should update Family" do
    visit family_url(@family)
    click_on "Edit this family", match: :first

    fill_in "Additives", with: @family.additives
    fill_in "Claims", with: @family.claims
    fill_in "Components", with: @family.components
    fill_in "Composition", with: @family.composition
    fill_in "Dosage", with: @family.dosage
    fill_in "Instructions", with: @family.instructions
    fill_in "Manufacturer code", with: @family.manufacturer_code
    fill_in "Name", with: @family.name
    fill_in "Tht months", with: @family.tht_months
    click_on "Update Family"

    assert_text "Family was successfully updated"
    click_on "Back"
  end

  test "should destroy Family" do
    visit family_url(@family)
    click_on "Destroy this family", match: :first

    assert_text "Family was successfully destroyed"
  end
end
