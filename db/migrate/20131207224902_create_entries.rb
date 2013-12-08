class CreateEntries < ActiveRecord::Migration
  def change
    create_table :entries do |t|
      t.belongs_to :member
      t.string :original_body
      t.string :formatted_body

      t.timestamps
    end
  end
end
