class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email, null:false
      t.string :password,null:false
      t.date :dob
      t.string :dp_url,default: '/images/default_dp.jpg'
      t.integer :exp,default:0
      t.integer :level,default:1

      t.timestamps
    end
  end
end
