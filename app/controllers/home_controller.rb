class HomeController < ApplicationController
  before_action :forbid_login_user , {only: [:about]}
  before_action :authenticate_user , {only: [:dummy]}


  def top
  end

  def about
  end

end
