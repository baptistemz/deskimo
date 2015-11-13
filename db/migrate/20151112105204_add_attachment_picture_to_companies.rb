class AddAttachmentPictureToCompanies < ActiveRecord::Migration
  def self.up
    change_table :companies do |t|
      t.attachment :picture
    end
  end

  def self.down
    remove_attachment :companies, :picture
  end
end
