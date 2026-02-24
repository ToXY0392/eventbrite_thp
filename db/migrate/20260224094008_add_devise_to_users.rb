class AddDeviseToUsers < ActiveRecord::Migration[8.1]
  def self.up
    change_table :users, bulk: true do |t|
      ## Recoverable
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at

      ## Rememberable
      t.datetime :remember_created_at

      ## Trackable (désactivé mais dispo)
      # t.integer  :sign_in_count, default: 0, null: false
      # t.datetime :current_sign_in_at
      # t.datetime :last_sign_in_at
      # t.inet     :current_sign_in_ip
      # t.inet     :last_sign_in_ip

      ## Confirmable (désactivé)
      # t.string   :confirmation_token
      # t.datetime :confirmed_at
      # t.datetime :confirmation_sent_at
      # t.string   :unconfirmed_email

      ## Lockable (désactivé)
      # t.integer  :failed_attempts, default: 0, null: false
      # t.string   :unlock_token
      # t.datetime :locked_at
    end

    # -- Indexes sécurisés : ne crée que s’ils n'existent pas --

    unless index_exists?(:users, :email)
      add_index :users, :email, unique: true
    end

    unless index_exists?(:users, :reset_password_token)
      add_index :users, :reset_password_token, unique: true
    end
  end

  def self.down
    raise ActiveRecord::IrreversibleMigration
  end
end