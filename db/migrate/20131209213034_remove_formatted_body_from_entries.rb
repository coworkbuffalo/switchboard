class RemoveFormattedBodyFromEntries < ActiveRecord::Migration
  def up
    change_table :entries do |t|
      t.rename :formatted_body, :action
      t.rename :original_body, :body
    end
  end

  def down
    change_table :entries do |t|
      t.rename :action, :formatted_body
      t.rename :body, :original_body
    end
  end
end
