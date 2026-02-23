class CreateEvents < ActiveRecord::Migration[8.1]
  def change
    create_table :events do |t|
      t.datetime :start_date,  null: false
      t.integer  :duration,    null: false
      t.string   :title,       null: false
      t.text     :description, null: false
      t.integer  :price,       null: false
      t.string   :location,    null: false

      t.integer :admin_id,     null: false

      t.timestamps
    end

    add_index :events, :admin_id
  end
end