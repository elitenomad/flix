class SessionsController < ApplicationController
  def new
  end

  def create
    usermail = params[:email]
    userpwd = params[:password]
    if usermail.empty? || userpwd.empty?
      flash.now[:notice] = "Please enter user details to sign in"
      render :new
    else
      user = User.find_by(email:usermail) || User.find_by(username:usermail)
      if user.nil?
        flash.now[:notice] = "User do not exist. Please sign up"
        render :new
      else
        isValidUser = user.authenticate(userpwd)
        if isValidUser
          session[:user_id] = user.id
          if session[:redirect_url].nil?
            redirect_to movies_path, notice:"Successfully logged in"
          else
            redirect_to session[:redirect_url], notice: "Successfully logged in"
            session[:redirect_url] = nil
          end
        else
          flash.now[:notice] = "Password entered is incorrect, Please try again"
          render :new
        end

      end
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to signin_path, notice:"Logged out successfully"
  end


end
