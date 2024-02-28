class QuoteTemplatesController < ApplicationController
  before_action :set_quote_template, only: %i[ show edit update destroy ]

  def index
    @quote_templates = QuoteTemplate.all
  end

  def show
  end

  def new
    @quote_template = QuoteTemplate.new
  end

  def edit
  end

  def create
    @quote_template = QuoteTemplate.new(quote_template_params)

    respond_to do |format|
      if @quote_template.save
        format.html { redirect_to quote_template_url(@quote_template), notice: "Quote template was successfully created." }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @quote_template.update(quote_template_params)
        format.html { redirect_to quote_template_url(@quote_template), notice: "Quote template was successfully updated." }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @quote_template.destroy!

    respond_to do |format|
      format.html { redirect_to quote_templates_url, notice: "Quote template was successfully destroyed." }
    end
  end

  private
  def set_quote_template
    @quote_template = QuoteTemplate.find(params[:id])
  end

  def quote_template_params
    params.require(:quote_template).permit(:image, :quote_id)
  end
end
