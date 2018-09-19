class AddRemoteIpToUserRequests < ActiveRecord::Migration[5.1]
  def change
    add_column :user_requests, :remote_ip, :string
  end
end
