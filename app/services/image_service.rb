require "mini_magick"

module ImageService
  def self.generate_profile_picture file
    image = MiniMagick::Image.open file.path
    image.resize "900x900"
    image.format "png"
    image.path
  end
end