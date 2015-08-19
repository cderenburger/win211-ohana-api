class AddPhonehoursToPhones < ActiveRecord::Migration
  def change
    add_column :phones, :phone_hours, :text
  end
end
