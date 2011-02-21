class CreateStackOverflowSearches < ActiveRecord::Migration
  def self.up
    create_table :stack_overflow_searches do |t|
      t.string :title
      t.string :prefix

      t.timestamps
    end
  end

  def self.down
    drop_table :stack_overflow_searches
  end
end
