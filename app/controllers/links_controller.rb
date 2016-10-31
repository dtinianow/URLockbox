class LinksController < ApplicationController
  def index
    @links = Link.where(user: current_user)
  end

  def create
    Link.create(
      user_id: current_user.id,
      title: link_params['title'],
      url: link_params['url']
    )
    redirect_to links_path
  end

private

  def link_params
    params.require(:link).permit(:title, :url)
  end
end
