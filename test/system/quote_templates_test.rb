require "application_system_test_case"

class QuoteTemplatesTest < ApplicationSystemTestCase
  setup do
    @quote_template = quote_templates(:one)
  end

  test "visiting the index" do
    visit quote_templates_url
    assert_selector "h1", text: "Quote templates"
  end

  test "should create quote template" do
    visit quote_templates_url
    click_on "New quote template"

    fill_in "Image", with: @quote_template.image
    fill_in "Quote", with: @quote_template.quote_id
    click_on "Create Quote template"

    assert_text "Quote template was successfully created"
    click_on "Back"
  end

  test "should update Quote template" do
    visit quote_template_url(@quote_template)
    click_on "Edit this quote template", match: :first

    fill_in "Image", with: @quote_template.image
    fill_in "Quote", with: @quote_template.quote_id
    click_on "Update Quote template"

    assert_text "Quote template was successfully updated"
    click_on "Back"
  end

  test "should destroy Quote template" do
    visit quote_template_url(@quote_template)
    click_on "Destroy this quote template", match: :first

    assert_text "Quote template was successfully destroyed"
  end
end
