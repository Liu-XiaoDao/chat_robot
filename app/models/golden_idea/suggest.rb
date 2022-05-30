module GoldenIdea
  class Suggest < ApplicationRecord
    belongs_to :employee, optional: true
    belongs_to :suggest, optional: true
    has_many :replys, class_name: "Suggest", foreign_key: "suggest_id"

    before_create :set_employee
    before_create :set_site
    # after_create :create_notificaion #收到回复后钉钉通知提问人


    def employee_name
      employee.try :name
    end

    def set_employee
      self.employee_id = Employee.current_employee.id
    end

    def set_site
      self.site = Employee.current_employee.site
    end

    def create_notificaion
      return if suggest.blank?

      Notification.create(target_type: self.class.name, target_id: self.id, content: "# 收到新的回复!!! \n##### #{content}. [查看详情](dingtalk://dingtalkclient/page/link?url=http%3a%2f%2fhan-express.abcam.com%2fgolden_idea%2fsuggests%2f#{suggest.id}%2fslide_show&pc_slide=true) \n###### #{Time.now.try(:strftime, "%Y-%m-%d %H:%M:%S")}")
    end

    def self.unreply_count
      Suggest.where(suggest_id: nil, site: Employee.current_employee.try(:site)).select{|s| s.replys.blank? }.count
    end
  end
end
