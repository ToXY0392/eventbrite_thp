class AddValidationToEvents < ActiveRecord::Migration[8.1]
  def change
    add_column :events, :validated, :boolean, default: false, null: false
    add_column :events, :reviewed, :boolean, default: false, null: false
  end
end
