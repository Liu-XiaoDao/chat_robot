class SessionsController < ApplicationController

  def new

  end

  def create
    if params[:session][:username] == "admin" && params[:session][:password] == "Abcam123"
      session[:admin] = 1
      redirect_to root_path
    else
      redirect_to signin_path
    end
  end

  def destroy
    session[:admin] = 0
    redirect_to root_path
  end

  private
    def session_param(attribute)
      params[:session][attribute]
    end
end
