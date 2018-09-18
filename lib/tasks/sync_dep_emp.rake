require 'rest-client'
namespace :sync_dep_emp do

  desc "每天从钉钉上同步部门和员工"
  task(:department_employee => :environment) do
    msg =  RestClient.get("http://han-express.abcam.com/departments/update_department").body
    LogService.i("[sync_department] #{msg}");
    msg =  RestClient.get("http://han-express.abcam.com/employees/update_employee").body
    LogService.i("[sync_employee] #{msg}");
  end

end
