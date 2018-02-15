class RemoveAttachmentImagesToItems < ActiveRecord::Migration[5.1]
  def self.up
    remove_attachment :items, :image   
  end

  def self.down
    remove_attachment :items, :image   
  end
end
