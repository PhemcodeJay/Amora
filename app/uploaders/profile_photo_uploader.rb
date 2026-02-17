# app/uploaders/profile_photo_uploader.rb
class ProfilePhotoUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  storage :file # Use :fog for production

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  version :thumb do
    process resize_to_fill: [100, 100]
  end

  version :medium do
    process resize_to_fill: [300, 300]
  end

  def extension_allowlist
    %w(jpg jpeg gif png)
  end
end