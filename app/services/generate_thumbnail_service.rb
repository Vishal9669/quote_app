class GenerateThumbnailService
  require 'RMagick2'
  include Magick

  attr_reader :quote, :logo_path, :template

  def initialize(quote, logo_path, template)
    @quote = quote
    @logo_path = logo_path
    @template = template
  end

  def call
    # Load the template image
    template_image = Magick::ImageList.new(template)
    template_image.resize!(1300, 600)

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
      txt.pointsize = 25
      txt.font_weight = Magick::BoldWeight
      txt.font = 'Arial'
      txt.fill = 'blue'
      txt.gravity = Magick::CenterGravity
    end

    text.annotate(template_image, 0, 0, 200, 60, quote.author) do |txt|
      txt.pointsize = 15
      txt.font_weight = Magick::BoldWeight
      txt.font = 'Arial'
      txt.fill = 'red'
      txt.gravity = Magick::CenterGravity
    end

    # Write the final image to a file
    filename = [quote.model_name.human, quote.id].join.downcase
    image_path = Rails.root.join("app/assets/images/generator/#{filename}.png")
    template_image.write(image_path)

    # Attach the image to the quote's thumbnail
    image_io = File.open(image_path)
    quote.thumbnail.attach(io: image_io, filename: "#{filename}.png", content_type: 'image/png')

    # Return the modified quote object
    return quote
  end
end
