class ImageUploader < CarrierWave::Uploader::Base
  # Include RMagick or MiniMagick support:
  # include CarrierWave::RMagick
  # include CarrierWave::MiniMagick
  # process resize_to_fit: [200,200]
  # storage :file
  # Choose what kind of storage to use for this uploader:

  storage :fog

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  # 指定 S3 bucket
  def fog_directory
    Rails.application.credentials.aws[:bucket]
  end

  # 指定 AWS 访问凭证
  def fog_credentials
    {
      provider:              'AWS',
      aws_access_key_id:     Rails.application.credentials.aws[:access_key_id],
      aws_secret_access_key: Rails.application.credentials.aws[:secret_access_key],
      region:                Rails.application.credentials.aws[:region]
    }
  end
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  # def default_url(*args)
  #   # For Rails 3.1+ asset pipeline compatibility:
  #   # ActionController::Base.helpers.asset_path("fallback/" + [version_name, "default.png"].compact.join('_'))
  #
  #   "/images/fallback/" + [version_name, "default.png"].compact.join('_')
  # end

  # Process files as they are uploaded:
  # process scale: [200, 300]
  #
  # def scale(width, height)
  #   # do something
  # end

  # Create different versions of your uploaded files:
  # version :thumb do
  # process resize_to_fit: [400, 400]
  # end

  # 上傳的圖片會被裁切成小於 800 * 800 像素的大小，原始圖片會另外保留
  # process resize_to_fit: [800, 800]

  # 另存一個叫做 thumb ，大小為 400 * 400 像素的圖片版本
  # version :thumb do
  #   process resize_to_fill: [400, 400]
  # end

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  # def extension_allowlist
  #   %w[jpg jpeg gif png]
  # end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  # def filename
  #   "something.jpg" if original_filename
  # end
end
