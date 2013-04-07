class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title,null: false
      t.text :content,null: false
      t.integer :vote, default: 0
			t.integer :noOfComments
			t.references :user
     
      t.timestamps
    end
		add_index :posts,:user_id
  end
end
