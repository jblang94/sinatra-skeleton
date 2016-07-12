class CreateUpvotes < ActiveRecord::Migration

  def change
    create_table :upvotes do |t|
      t.references :song
      t.references :user
    end
  end

end
