class CreateReviews < ActiveRecord::Migration

  def change
    create_table :reviews do |t|
      t.references :song
      t.references :user
      t.string :review
    end
  end

end
