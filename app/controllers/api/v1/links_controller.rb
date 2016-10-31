class Api::V1::LinksController < ApplicationController
  def index
    render json: Link.where(user: params[:user_id])
  end
end
