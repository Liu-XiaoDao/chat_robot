module GoldenIdea
  class Suggest < ApplicationRecord
    belongs_to :employee, optional: true
    belongs_to :suggest, optional: true
    has_many :replys, class_name: "Suggest", foreign_key: "suggest_id"

    before_create :set_employee
    before_create :create_notificaion #收到回复后钉钉通知提问人


    def employee_name
      employee.try :name
    end

    def set_employee
      self.employee_id = Employee.current_employee.id
    end

    def create_notificaion
      return if suggest.blank?

      Notification.create(target_type: self.class.name, target_id: self.id, content: "# 收到新的回复!!! \n##### #{content}.(dingtalk://dingtalkclient/page/link?url=http%3A%2F%2Fhan-express.abcam.com%2questions%22&pc_slide=true) \n###### #{Time.now.try(:strftime, "%Y-%m-%d %H:%M:%S")}")
    end

  end
end
