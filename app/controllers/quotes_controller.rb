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
        # Update author name if person_id has changed
        if quote_params[:person_id] != @quote.person_id
          update_author_name
        end

        # Regenerate thumbnail if template_id has changed
        if quote_params[:template] != @quote.template
          generate_thumbnail
        end

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
    set_default_values_for_quote_text(quote)
    quote.template = params[:quote][:template]
    quote.logo_position = params[:quote][:logo_position]
    quote.template_size = params[:quote][:template_size]
    person = Person.find_by(id: quote.person_id)
    quote.author = "-#{person.name}" if person
    quote
  end

  def load_templates
    @templates = Template.all
  end

  def set_default_values_for_quote_text(quote)
    quote.text_pointsize = quote.text_pointsize.present? ? quote.text_pointsize : 25
    quote.text_font = quote.text_font.present? ? quote.text_font : 'Arial'
    quote.text_fill = quote.text_fill.present? ? quote.text_fill : 'blue'
  end

  def update_author_name
    person = Person.find_by(id: @quote.person_id)
    @quote.update(author: "-#{person.name}") if person
  end

  def quote_params
    params.require(:quote).permit(:content, :author, :person_id, :thumbnail, :logo_path, :template, :text_pointsize, :text_font, :text_fill, :logo_position, :template_size)
  end
end
