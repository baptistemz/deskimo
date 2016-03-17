class AddAccessInformationToWelcomeMessage < ActiveRecord::Migration
  def change
    add_column :welcome_messages, :access_information, :text
  end
end
