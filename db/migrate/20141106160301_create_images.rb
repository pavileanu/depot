class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.belongs_to :user, index: true
      t.string :name
      t.string :type1
      t.binary :data
      
      t.timestamps
    end
  end
end
