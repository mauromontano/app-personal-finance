class HomeController < ApplicationController
  before_action :authenticate_user!

  def index
    # Empty
  end
end
