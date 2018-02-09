desc "upload image to cloudinary"
    task upload_image: :environment do
      Item.find_each do |item|
        Cloudinary::Uploader.upload("app/assets/images/#{item.image_file_name}", :height => 300, :width => 300 )
      end
    end


puts "image swapped!"
