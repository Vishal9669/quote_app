require "test_helper"

class QuoteTemplatesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @quote_template = quote_templates(:one)
  end

  test "should get index" do
    get quote_templates_url
    assert_response :success
  end

  test "should get new" do
    get new_quote_template_url
    assert_response :success
  end

  test "should create quote_template" do
    assert_difference("QuoteTemplate.count") do
      post quote_templates_url, params: { quote_template: { image: @quote_template.image, quote_id: @quote_template.quote_id } }
    end

    assert_redirected_to quote_template_url(QuoteTemplate.last)
  end

  test "should show quote_template" do
    get quote_template_url(@quote_template)
    assert_response :success
  end

  test "should get edit" do
    get edit_quote_template_url(@quote_template)
    assert_response :success
  end

  test "should update quote_template" do
    patch quote_template_url(@quote_template), params: { quote_template: { image: @quote_template.image, quote_id: @quote_template.quote_id } }
    assert_redirected_to quote_template_url(@quote_template)
  end

  test "should destroy quote_template" do
    assert_difference("QuoteTemplate.count", -1) do
      delete quote_template_url(@quote_template)
    end

    assert_redirected_to quote_templates_url
  end
end
