class CreateCollaborations < ActiveRecord::Migration[6.1]
  def change
    create_table :collaborations do |t|
      t.references :plan, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
