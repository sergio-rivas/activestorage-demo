class PagesController < ApplicationController
  def home
    @user = User.first
  end
end
