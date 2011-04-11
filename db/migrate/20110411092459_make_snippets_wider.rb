class MakeSnippetsWider < ActiveRecord::Migration
  def self.up
    change_column :snippets, :content, :string, :limit => 5000
  end

  def self.down
    change_column :snippets, :content, :string
  end
end
