class SignupsController < ApplicationController

  def new
    @signup ||= Signup.new(saved: params[:saved])
    @total_signups = Signup.total_today
  end

  def create
    @signup = Signup.new(params[:signup])
    alert = @signup.save && "Thank you for signing up!" || nil
    redirect_to(root_path, alert: alert, saved: true)
  end

end
