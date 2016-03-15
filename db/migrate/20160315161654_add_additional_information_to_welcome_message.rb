class AddAdditionalInformationToWelcomeMessage < ActiveRecord::Migration
  def change
    add_column :welcome_messages, :additional_information, :text
  end
end
