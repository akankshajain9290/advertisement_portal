class CreateSlots < ActiveRecord::Migration[5.2]
  def change
    create_table :slots do |t|
      t.string :name
      t.datetime :start_time
      t.datetime :end_time
      t.float :price
      t.string :status
      t.belongs_to :agent, index: true
      t.belongs_to :organiser, index: true
      t.belongs_to :adv_space
      t.timestamps
    end
  end
end
