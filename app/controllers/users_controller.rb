class UsersController < ApplicationController
  
  def show
  @user = User.find(paramu[:id])
  end
  
end
