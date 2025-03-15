require "test_helper"

class BatchOutputsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @batch_output = batch_outputs(:one)
  end

  test "should get index" do
    get batch_outputs_url
    assert_response :success
  end

  test "should get new" do
    get new_batch_output_url
    assert_response :success
  end

  test "should create batch_output" do
    assert_difference("BatchOutput.count") do
      post batch_outputs_url, params: { batch_output: {} }
    end

    assert_redirected_to batch_output_url(BatchOutput.last)
  end

  test "should show batch_output" do
    get batch_output_url(@batch_output)
    assert_response :success
  end

  test "should get edit" do
    get edit_batch_output_url(@batch_output)
    assert_response :success
  end

  test "should update batch_output" do
    patch batch_output_url(@batch_output), params: { batch_output: {} }
    assert_redirected_to batch_output_url(@batch_output)
  end

  test "should destroy batch_output" do
    assert_difference("BatchOutput.count", -1) do
      delete batch_output_url(@batch_output)
    end

    assert_redirected_to batch_outputs_url
  end
end
