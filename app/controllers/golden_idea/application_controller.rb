module GoldenIdea
  class ApplicationController < ::ApplicationController
    layout 'golden_idea_new'
    def index

    end

    def exchange_records
      @exchange_records = ExchangeRecord.all.paginate page: params[:page], per_page: 8
    end

    def assign_score_records
      @assign_score_records = AssignScoreRecord.all.paginate page: params[:page], per_page: 8
    end

    def user_requests
      @user_requests = UserRequest.where('url like "%golden_idea%"').paginate page: params[:page], per_page: 8
    end

    def golden_idea_score_order
      @golden_ideas = GoldenIdea::Idea.order(score: :desc)
    end

    def employee_score_order
    end

    def golden_idea_score_standard

    end

    def golden_idea_template
    end

    def dashboard
    end
  end
end
