class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :find_subjects
  
  private
  
  def find_subjects
    @subjects = Subject.sorted.visible
  end
  def confirm_logged_in
      unless session[:user_id]
        flash[:danger] = "Please log in."
        redirect_to(:controller => 'users', :action => 'login')
        return false # останавливает before_action
      else
        return true
      end
  end
end
