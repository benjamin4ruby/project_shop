class AccountsController < ApplicationController

  def show

    $inAccount = true

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @account }
    end
  end
end
