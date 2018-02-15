class RemoveAttachmentImagesToOrders < ActiveRecord::Migration[5.1]
  def self.up
    remove_attachment :orders, :image
  end

  def self.down
    remove_attachment :orders, :image
  end
end
