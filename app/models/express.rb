class Express < ApplicationRecord
  belongs_to :employee
  has_one :notification, ->{ where( notifications: { target_class: "expresses" } ) }, :foreign_key => :target_id #
  default_scope { order('id DESC') }
  after_create :create_notification




  def create_notification
    Notification.create(target_class: self.class.table_name, target_id: self.id, content: "# 快递来了!!! \n#{self.express_type == "基因快递" ? "![screenshot]( http://han-express.abcam.com/images/sos.png)" : ""} \n##### Hi,#{employee.name}您有#{self.express_type == "基因快递" ? "**#{self.express_type}**" : "快递"}到了,请及时领取,不要有遗漏. [快递查询]( http://han-express.abcam.com/expresses/) \n###### #{Time.now.try(:strftime, "%Y-%m-%d %H:%M:%S")}")
  end
end
