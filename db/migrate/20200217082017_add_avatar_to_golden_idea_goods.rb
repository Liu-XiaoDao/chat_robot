class AddAvatarToGoldenIdeaGoods < ActiveRecord::Migration[5.1]
  def change
    add_attachment :golden_idea_goods, :avatar
  end
end
