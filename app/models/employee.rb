class Employee < ApplicationRecord
  cattr_accessor :current_employee

  belongs_to :department, optional: true
  # has_many :consumablerecords
  # has_many :attached_files, ->{ where( attached_files: { target_class: "authorizationservices" } ) }, :foreign_key => :target_id
  has_many :books, :foreign_key => :borrower_id
  has_many :borrow_records
  has_many :return_records
  has_many :comments
  has_many :count_records, ->{ where( count_records: { target_class: "book" } ) }

  # def self.current_employee
  #   Thread.current[:employee]
  # end
  #
  # def self.current_employee=(employee)
  #   Thread.current[:employee] = employee
  # end

  def department_name
    department.try(:name)
  end

  def annual_blessing(is_manager=false)
    return if hired_date.blank?
    hired_year, hired_month, hired_day = hired_date.year, hired_date.month, hired_date.day
    current_year, current_month, current_day = Date.today.year, Date.today.month, Date.today.day

    if current_month == hired_month && current_day == hired_day
      if is_manager
        send_annual_blessing_notificaion(current_year - hired_year)
      else
        send_annual_blessing_notificaion_to_chunliang(current_year - hired_year)
      end
    end
  end

  def send_annual_blessing_notificaion(number)
    accessToken = AuthService.new.getAccessToken()
    data = {
      "chatid":'chat9b2fe210aee984aa0f46fb4611afc144',
      "agentid":180734473,
      "msgtype":"text",
      "text": {
        "content": "恭喜 #{name}入职#{number}周年"
      }
    }
    msg = MessageService.new.send_chat(accessToken,data)
    if msg.code == 200
      LogService.i("[notification_send] SUC: 员工祝贺发送成功,姓名:#{self.name}")
    else
      LogService.e("[notification_send] ERR: 员工祝贺发送失败,姓名:#{self.name}")
    end
  end

  def send_annual_blessing_notificaion_to_chunliang(number)
    accessToken = AuthService.new.getAccessToken()
    data = {
      "touser":130841175621040386,
      "agentid":180734473,
      "msgtype":"text",
      "text": {
        "content": "恭喜 #{name}入职#{number}周年"
      }
    }
    msg = MessageService.new.send(accessToken,data)
    if msg.code == 200
      LogService.i("[notification_send] SUC: 员工祝贺发送成功,姓名:#{self.name}")
    else
      LogService.e("[notification_send] ERR: 员工祝贺发送失败,姓名:#{self.name}")
    end
  end
end
