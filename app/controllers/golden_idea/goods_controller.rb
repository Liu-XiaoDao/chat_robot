module GoldenIdea
  class GoodsController < ApplicationController
    layout 'golden_idea'
    def index
      @goods = Good.where("quantity > 0").ransack(params[:q]).result(distinct: true).paginate page: params[:page], per_page: 8
    end

    def index_admin
      @goods = Good.all.paginate page: params[:page], per_page: 10
    end

    def new
      @good = Good.new
      render layout: false
    end

    def create
      @good = Good.create(good_params)
      redirect_to index_admin_golden_idea_goods_path
    end

    def edit
      @good = Good.find params[:id]
      render layout: false
    end

    def update
      @good = Good.find(params[:id])
      if @good.update_attributes(good_params)
        flash["success"] = "编辑成功"
      else
        flash["error"] = "编辑错误:#{@good.errors.full_messages}"
      end
      # redirect_to index_admin_golden_idea_ideas_path
      redirect_to request.referer
    end

    def show_admin
      @good = Good.find(params[:id])
    end

    def show
      @good = Good.find(params[:id])
    end

    def exchange_view
      @good = Good.find(params[:id])
      render layout: false
    end

    def exchange
      @good = Good.find(params[:id])
      quantity = Integer(params[:exchange_quantity])
      required_points = quantity * @good.score
      current_employee = Employee.current_employee
      current_employee_available_score = current_employee.available_score
      good_quantity = @good.quantity
      if current_employee_available_score >= required_points && good_quantity >= quantity
        if current_employee.update(available_score: (current_employee_available_score - required_points)) && @good.update(quantity: (good_quantity - quantity))
          ExchangeRecord.create(good_id: @good.id, employee_id:current_employee.id, quantity: quantity, used_score: required_points)
          flash[:success] = "兑换成功"
        else
          # return render js: "$('#exchange_form').prepend(<h5 style='text-align: center;'>兑换失败</h5>)"
          flash[:error] = "兑换失败"
        end
      else
        # return render js: "$('#exchange_form').prepend('<h5 style=\'text-align: center;\'>您的积分不足或没有库存</h5>')"
        flash[:error] = "您的积分不足或没有库存"
      end
      redirect_to request.referer
    end

    def destroy
      @good = Good.find(params[:id])

      if @good.exchange_records.present?
        flash["error"] = "#{@good.name}有兑换记录不能删除"
      else
        if @good.destroy
          flash["success"] = "#{@good.name}删除成功"
        else
          flash["error"] = "删除失败:#{@good.errors.full_messages}"
        end
      end
      redirect_to request.referer
    end

    private
      def good_params
        params.require(:golden_idea_good).permit(:name, :description, :avatar, :quantity, :score, :content)
      end
  end
end
