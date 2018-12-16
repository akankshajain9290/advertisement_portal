class CreateAdvSpaces < ActiveRecord::Migration[5.2]
  def change
    create_table :adv_spaces do |t|
      t.string :name
      t.belongs_to :provider, index: true
    end
  end
end
