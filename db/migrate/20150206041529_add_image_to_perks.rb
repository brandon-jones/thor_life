class AddImageToPerks < ActiveRecord::Migration
  def change
  	add_attachment :perks, :image
  end
end
