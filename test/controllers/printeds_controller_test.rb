require "test_helper"

class PrintedsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @printed = printeds(:one)
  end

  test "should get index" do
    get printeds_url
    assert_response :success
  end

  test "should get new" do
    get new_printed_url
    assert_response :success
  end

  test "should create printed" do
    assert_difference("Printed.count") do
      post printeds_url, params: { printed: { Batch: @printed.Batch, XMLExported: @printed.XMLExported, itemCode: @printed.itemCode } }
    end

    assert_redirected_to printed_url(Printed.last)
  end

  test "should show printed" do
    get printed_url(@printed)
    assert_response :success
  end

  test "should get edit" do
    get edit_printed_url(@printed)
    assert_response :success
  end

  test "should update printed" do
    patch printed_url(@printed), params: { printed: { Batch: @printed.Batch, XMLExported: @printed.XMLExported, itemCode: @printed.itemCode } }
    assert_redirected_to printed_url(@printed)
  end

  test "should destroy printed" do
    assert_difference("Printed.count", -1) do
      delete printed_url(@printed)
    end

    assert_redirected_to printeds_url
  end
end
