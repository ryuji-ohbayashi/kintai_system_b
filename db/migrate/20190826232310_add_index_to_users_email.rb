class AddIndexToUsersEmail < ActiveRecord::Migration[5.1]
  def change
    add_index :users, :email, unique: true # 4.4.6
  end
end
