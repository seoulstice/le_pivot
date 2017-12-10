module SantasLittleHelper
  def testing_image
    Rails.root + "spec/support/images/test_image.jpg"
  end

  def paperclip_image
    File.open(testing_image)
  end
end
