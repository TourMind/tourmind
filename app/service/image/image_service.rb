module Image
  class ImageService
    def self.remove_image(params)
      result = params
      return result if result[:remove_images].nil?

      if result[:images_cache].present?
        image_cache = JSON.parse(result[:images_cache])
        result[:remove_images].each do |remove_image|
          image_cache.delete_if { |image| image.include? remove_image }
        end
        result[:images_cache] = JSON.generate(image_cache)
      end

      if result[:images].present?
        result[:remove_images].each do |remove_image|
          result[:images].delete_if { |image| image.instance_of?(String) && image.include?(remove_image) }
        end
      end

      result.extract!(:remove_images)
      return result
    end
  end
end
