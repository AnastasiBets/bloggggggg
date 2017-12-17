class CreateVoteForPhotos < ActiveRecord::Migration[5.1]
  def change
    create_table :vote_for_photos do |t|
      t.integer :user_id
      t.integer :image_id
      t.integer :like

      t.timestamps
    end
  end
end