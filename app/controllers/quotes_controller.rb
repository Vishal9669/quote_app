class QuotesController < ApplicationController
  before_action :set_quote, only: %i[ show edit update destroy ]
  before_action :load_templates, only: [:new, :edit]

  def index
    @quotes = Quote.all
  end

  def show
  end

  def new
    @quote = Quote.new
  end

  def edit
  end

  def create
    @quote = build_quote_with_author_name

    respond_to do |format|
      if @quote.save!
        generate_thumbnail
        format.html { redirect_to quote_url(@quote), notice: "Quote was successfully created." }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @quote.update(quote_params)
        generate_thumbnail
        format.html { redirect_to quote_url(@quote), notice: "Quote was successfully updated." }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @quote.destroy!

    respond_to do |format|
      format.html { redirect_to quotes_url, notice: "Quote was successfully destroyed." }
    end
  end

  private

  def set_quote
    @quote = Quote.find(params[:id])
  end

  def generate_thumbnail
    GenerateThumbnailService.new(@quote).call
  end

  def build_quote_with_author_name
    quote = Quote.new(quote_params)
    quote.template = params[:quote][:template_id]
    person = Person.find_by(id: quote.person_id)
    quote.author = "-#{person.name}" if person
    quote
  end

  def load_templates
    @templates = Template.all
  end

  def quote_params
    params.require(:quote).permit(:content, :author, :person_id, :thumbnail, :logo_path, :template)
  end
end
