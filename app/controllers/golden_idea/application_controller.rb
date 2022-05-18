module GoldenIdea
  class ApplicationController < ::ApplicationController
    layout 'golden_idea_new'
    # before_action :check_signed_in

    def index

    end

    def exchange_records
      @exchange_records = ExchangeRecord.where(site: Employee.current_employee.site).paginate page: params[:page], per_page: 8
    end

    def assign_score_records
      @assign_score_records = AssignScoreRecord.where(site: Employee.current_employee.site).paginate page: params[:page], per_page: 8
    end

    # 不放出链接
    def user_requests
      @user_requests = UserRequest.where('url like "%golden_idea%"').paginate page: params[:page], per_page: 8
    end

    def golden_idea_score_order
      # 这里没用， view中直接取得
      @golden_ideas = GoldenIdea::Idea.order(score: :desc)
    end

    def employee_score_order
    end

    def golden_idea_score_standard

    end

    def golden_idea_template
    end

    def golden_idea_proposal
    end

    def submit_golden_idea_proposal
      title = params[:proposal][:title]
      content = params[:proposal][:content]
      real_name = current_employee.name if params[:proposal][:real_name] == "1"

      NotificationMailer.proposal(title, content, real_name).deliver

      flash["success"] = "Submit successfully"
      redirect_to golden_idea_proposal_path
    end

    def dashboard
    end

    def golden_idea_search
    end

    # 确保已登录, 否则转向登录页面
    def check_signed_in
      unless signed_in? || request.env['HTTP_USER_AGENT'] =~ /DingTalk/
        flash[:warning] = "Please sign in first!"
        store_location    #如果没登录会跳转到登录页,在这保存原本想要访问的页面,登陆后返回
        redirect_to signin_path
      else
        Employee.current_employee = current_employee
      end
    end
  end
end
