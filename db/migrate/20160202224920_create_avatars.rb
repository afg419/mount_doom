class CreateAvatars < ActiveRecord::Migration
  def change
    create_table :avatars do |t|
      t.string :name
      t.string :image_url
      t.references :skill_set, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
