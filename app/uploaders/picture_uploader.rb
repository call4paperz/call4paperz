# encoding: utf-8
class PictureUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  # Include the Sprockets helpers for Rails 3.1+ asset pipeline compatibility:
  # include Sprockets::Helpers::RailsHelper
  # include Sprockets::Helpers::IsolatedHelper

  # Choose what kind of storage to use for this uploader:
  # storage :file
  # storage :fog

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  def default_url
    "/images/no-image-#{version_name}.png"
  end

  version :big do
    process :resize_to_fill => [180, 175]
  end

  version :thumb do
    process :resize_to_fill => [100, 100]
  end

  version :cropped do
    process :crop_image => [180, 175]
  end

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  # def extension_white_list
  #   %w(jpg jpeg gif png)
  # end

  # Override the filename of the uploaded files:
  # def filename
  #   "something.jpg" if original_filename
  # end
  def cache_dir
    "#{Rails.root}/tmp/uploads"
  end

  protected

  def crop_image(height, width)
    if model.respond_to?(:cropping?) and model.cropping?
      manipulate! do |img|
        img = MiniMagick::Image.open(model.picture.current_path)
        geometry = "#{model.crop_w}x#{model.crop_h}+#{model.crop_x}+#{model.crop_y}"
        img.crop(geometry)
        img
      end
    else
      resize_to_fill(height, width)
    end
  end
end
