class PublicController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index]

  def index
    # Empty
  end
end
