# To change this template, choose Tools | Templates
# and open the template in the editor.

class SessionsController < ApplicationController
  
  def new
  end
  
  def create

    user_valid = User.find(:first, :conditions => ['email = ?', params[:email]])

    if (user_valid && PasswordHelper::check(params[:password], user_valid.password))

        session[:user] = user_valid
        redirect_to users_path

    else
        session[:user] = User.find(:first, :conditions => { :name => "Guest"})
        flash[:notice]  = 'Login unsuccessful'
        redirect_to new_session_path
    end
  end

  def destroy
    session[:user] = User.find(:first, :conditions => { :name => "Guest"})
    redirect_to products_path
  end

  def delete
    session[:user] = User.find(:first, :conditions => { :name => "Guest"})
    redirect_to products_path
  end

end
