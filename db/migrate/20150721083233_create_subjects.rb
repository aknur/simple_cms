class CreateSubjects < ActiveRecord::Migration
  def change
    create_table :subjects do |t|
      t.string :title
      t.boolean :visible
      t.integer :position

      t.timestamps null: false
    end
  end
end
