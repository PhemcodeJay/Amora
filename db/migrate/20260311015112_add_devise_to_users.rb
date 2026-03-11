# frozen_string_literal: true

class AddDeviseToUsers < ActiveRecord::Migration[8.1]
  def self.up
    if table_exists?(:users)
      # Table exists - just add missing columns
      change_table :users, bulk: true do |t|
        ## Database authenticatable
        t.string :email, null: false, default: "" unless column_exists?(:users, :email)
        t.string :encrypted_password, null: false, default: "" unless column_exists?(:users, :encrypted_password)

        ## Recoverable
        t.string :reset_password_token unless column_exists?(:users, :reset_password_token)
        t.datetime :reset_password_sent_at unless column_exists?(:users, :reset_password_sent_at)

        ## Rememberable
        t.datetime :remember_created_at unless column_exists?(:users, :remember_created_at)

        ## Trackable
        t.integer :sign_in_count, default: 0, null: false unless column_exists?(:users, :sign_in_count)
        t.datetime :current_sign_in_at unless column_exists?(:users, :current_sign_in_at)
        t.datetime :last_sign_in_at unless column_exists?(:users, :last_sign_in_at)
        t.string :current_sign_in_ip unless column_exists?(:users, :current_sign_in_ip)
        t.string :last_sign_in_ip unless column_exists?(:users, :last_sign_in_ip)

        ## Confirmable
        t.string :confirmation_token unless column_exists?(:users, :confirmation_token)
        t.datetime :confirmed_at unless column_exists?(:users, :confirmed_at)
        t.datetime :confirmation_sent_at unless column_exists?(:users, :confirmation_sent_at)
        t.string :unconfirmed_email unless column_exists?(:users, :unconfirmed_email)

        ## Lockable
        t.integer :failed_attempts, default: 0, null: false unless column_exists?(:users, :failed_attempts)
        t.string :unlock_token unless column_exists?(:users, :unlock_token)
        t.datetime :locked_at unless column_exists?(:users, :locked_at)

        # Timestamps
        t.timestamps null: false unless column_exists?(:users, :created_at)
      end

      # Add indexes if they don't exist
      add_index :users, :email, unique: true unless index_exists?(:users, :email)
      add_index :users, :reset_password_token, unique: true unless index_exists?(:users, :reset_password_token)
      add_index :users, :confirmation_token, unique: true unless index_exists?(:users, :confirmation_token)
      add_index :users, :unlock_token, unique: true unless index_exists?(:users, :unlock_token)
    else
      # Table doesn't exist - create it with all columns
      create_table :users do |t|
        ## Database authenticatable
        t.string :email, null: false, default: ""
        t.string :encrypted_password, null: false, default: ""

        ## Recoverable
        t.string :reset_password_token
        t.datetime :reset_password_sent_at

        ## Rememberable
        t.datetime :remember_created_at

        ## Trackable
        t.integer :sign_in_count, default: 0, null: false
        t.datetime :current_sign_in_at
        t.datetime :last_sign_in_at
        t.string :current_sign_in_ip
        t.string :last_sign_in_ip

        ## Confirmable
        t.string :confirmation_token
        t.datetime :confirmed_at
        t.datetime :confirmation_sent_at
        t.string :unconfirmed_email

        ## Lockable
        t.integer :failed_attempts, default: 0, null: false
        t.string :unlock_token
        t.datetime :locked_at

        ## Timestamps
        t.timestamps null: false
      end

      # Add indexes
      add_index :users, :email, unique: true
      add_index :users, :reset_password_token, unique: true
      add_index :users, :confirmation_token, unique: true
      add_index :users, :unlock_token, unique: true
    end
  end

  def self.down
    # Only try to remove columns if table exists
    if table_exists?(:users)
      columns_to_remove = [
        :email, :encrypted_password, :reset_password_token, :reset_password_sent_at,
        :remember_created_at, :sign_in_count, :current_sign_in_at, :last_sign_in_at,
        :current_sign_in_ip, :last_sign_in_ip, :confirmation_token, :confirmed_at,
        :confirmation_sent_at, :unconfirmed_email, :failed_attempts, :unlock_token,
        :locked_at
      ]
      columns_to_remove.each do |column|
        remove_column :users, column if column_exists?(:users, column)
      end
    else
      # If table doesn't exist, nothing to do
      puts "Table :users doesn't exist - nothing to rollback"
    end
  end
end
