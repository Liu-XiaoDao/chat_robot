require 'rest-client'
namespace :sync_dep_emp do

  desc "每天从钉钉上同步部门和员工"
  task(:department_employee => :environment) do
    msg =  RestClient.get("http://han-express.abcam.com/departments/update_department").body
    LogService.i("[sync_department] #{msg}");
    msg =  RestClient.get("http://han-express.abcam.com/employees/update_employee").body
    LogService.i("[sync_employee] #{msg}");
  end

  desc "每天提醒员工周年庆"
  task(:annual_blessing => :environment) do
    Employee.where(is_leave: 0).each do |employee|
      employee.annual_blessing(true)
    end
  end

  desc "每天提醒员工周年庆to chunliang"
  task(:annual_blessing_to_chunliang => :environment) do
    Employee.where(is_leave: 0).each do |employee|
      employee.annual_blessing(false)
    end
  end

end
