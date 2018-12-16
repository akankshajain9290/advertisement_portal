class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :username
      t.string :email
      t.string :encrypted_password
      t.string :first_name
      t.string :last_name
      t.string :organisation
      t.belongs_to :role
      t.timestamps
    end
  end
end
