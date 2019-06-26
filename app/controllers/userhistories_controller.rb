class UserhistoriesController < ApplicationController
  before_action :authenticate_user , {only: [:index, :show, :edit, :update]}
  before_action :forbid_login_user, {only: [:dummy]}

  def new
    @userhistory = Userhistory.new
  end

  def list
    @userhistory = Userhistory.all
  end

end
