class GenerateThumbnailService
  require 'RMagick2'
  include Magick

  attr_reader :quote

  def initialize(quote)
    @quote = quote
  end

  def call
    # Load the template image
    template = Template.find(quote.template)
    template_url = Rails.application.routes.url_helpers.url_for(template.picture)
    template_image = Magick::Image.read(template_url).first
    template_image.resize!(1200, 500)

    # Load the logo image
    logo_url = Rails.application.routes.url_helpers.url_for(quote.person.image)
    logo = Magick::Image.read(logo_url).first
    logo.resize!(logo.columns * 0.5, logo.rows * 0.5) # Scale down the logo image if needed

    # Calculate the position for the logo
    logo_x = template_image.columns - logo.columns - 10 # 10 pixels padding from the right edge
    logo_y = template_image.rows - logo.rows - 10  # 10 pixels padding from the top edge

    # Composite the logo onto the template image
    template_image.composite!(logo, logo_x, logo_y, Magick::OverCompositeOp)

    # Add text to the template image
    text = Magick::Draw.new
    text.annotate(template_image, 0, 0, 0, 0, quote.content) do |txt|
      txt.pointsize = quote.text_pointsize
      txt.font_weight = Magick::BoldWeight
      txt.font = quote.text_font
      txt.fill = quote.text_fill
      txt.gravity = Magick::CenterGravity
    end

    text.annotate(template_image, 0, 0, 200, 60, quote.author) do |txt|
      txt.pointsize = quote.text_pointsize
      txt.font_weight = Magick::BoldWeight
      txt.font = quote.text_font
      txt.fill = quote.text_fill
      txt.gravity = Magick::CenterGravity
    end

    # Convert the image to binary data
    image_blob = template_image.to_blob { |img| img.format = 'PNG' }

    # Attach the image data to the quote's thumbnail
    quote.thumbnail.attach(io: StringIO.new(image_blob), filename: "thumbnail.png", content_type: 'image/png')

    # Return the modified quote object
    quote
  end
end
