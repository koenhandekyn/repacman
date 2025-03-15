require "test_helper"

class BatchInputsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @batch_input = batch_inputs(:one)
  end

  test "should get index" do
    get batch_inputs_url
    assert_response :success
  end

  test "should get new" do
    get new_batch_input_url
    assert_response :success
  end

  test "should create batch_input" do
    assert_difference("BatchInput.count") do
      post batch_inputs_url, params: { batch_input: {} }
    end

    assert_redirected_to batch_input_url(BatchInput.last)
  end

  test "should show batch_input" do
    get batch_input_url(@batch_input)
    assert_response :success
  end

  test "should get edit" do
    get edit_batch_input_url(@batch_input)
    assert_response :success
  end

  test "should update batch_input" do
    patch batch_input_url(@batch_input), params: { batch_input: {} }
    assert_redirected_to batch_input_url(@batch_input)
  end

  test "should destroy batch_input" do
    assert_difference("BatchInput.count", -1) do
      delete batch_input_url(@batch_input)
    end

    assert_redirected_to batch_inputs_url
  end
end
