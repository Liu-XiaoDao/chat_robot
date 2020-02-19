class RemoveAvatarFromGoldenIdeaGoods < ActiveRecord::Migration[5.1]
  def change
    remove_column :golden_idea_goods, :avatar
  end
end
