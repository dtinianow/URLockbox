class Api::V1::LinksController < ApplicationController
  def index
    render json: Link.where(user: params[:user_id])
  end

  def update
    Link.find_by(user: params[:user_id], id: params[:link_id])
    link = Link.update(link_params)
    render json: link
  end

private

  def link_params
    params.require(:link).permit(:title, :url, :read)
  end
end
