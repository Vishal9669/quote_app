class GenerateThumbnailService
  require 'RMagick2'
  include Magick

  attr_reader :quote, :logo_path

  def initialize(quote, logo_path)
    @quote = quote
    @logo_path = logo_path
  end

  def call
    image = Magick::Image.new(800, 400) do |img|
      img.background_color = "yellow"
    end
    logo_paths = Rails.root.join(logo_path)
    logo = Magick::Image.read(logo_paths).first
    logo = logo.scale(0.50)
    image = image.composite(logo, Magick::SouthEastGravity, 5, 5, Magick::OverCompositeOp)

    text = Magick::Draw.new
    text.annotate(image, 0, 0, 0, -50, quote.content) do |txt|
      txt.pointsize = 20
      txt.font_weight = Magick::BoldWeight
      txt.font = 'Arial'
      txt.fill = 'blue'
      txt.gravity = Magick::CenterGravity
    end

    text.annotate(image, 0, 0, 0, 20, quote.author) do |txt|
      txt.pointsize = 15
      txt.font_weight = Magick::BoldWeight
      txt.font = 'Arial'
      txt.fill = 'blue'
      txt.gravity = Magick::CenterGravity
    end

    filename = [quote.model_name.human, quote.id].join.downcase

    image.write("app/assets/images/generator/#{filename}.png")

    image_io = File.open("app/assets/images/generator/#{filename}.png")
    quote.thumbnail.attach(io: image_io, filename:, content_type: 'image/png')
  end
end
