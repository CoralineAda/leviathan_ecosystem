class SignupsController < ApplicationController

  def new
    @signup ||= Signup.new(saved: params[:saved])
  end

  def create
    @signup = Signup.new(params[:signup])
    alert = @signup.save && "Thank you for signing up!" || "Sorry, but there was a problem with the email you entered."
    redirect_to(root_path, alert: alert, saved: true)
  end

end
