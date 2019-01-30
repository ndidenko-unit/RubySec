class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.string :date
      t.string :rubygem
      t.string :link
      t.string :title
      t.string :cve

      t.timestamps
    end
  end
end
