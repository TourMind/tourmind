class AddUserAndCommentableToComments < ActiveRecord::Migration[6.1]
  def change
    add_reference :comments, :user, foreign_key: true
    add_column :comments, :commentable_id, :integer
    add_column :comments, :commentable_type, :string
  end
end
