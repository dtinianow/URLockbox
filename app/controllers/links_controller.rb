class LinksController < ApplicationController
  def index
    @links = Link.where(user: current_user)
  end

  def create
    if Link.create(
        user_id: current_user.id,
        title: link_params['title'],
        url: link_params['url']
      )
      flash[:success] = "Successfully created link!"
      redirect_to links_path
    else
      flash.now[:error] = 'Invalid link.'
      render :new
    end
  end

  def edit
    @link = Link.find_by(user: current_user, id: params[:id])
  end

  def update
    @link = Link.find_by(user: current_user, id: params[:id])
    if @link.update(link_params)
      flash[:success] = 'Successfully updated link.'
      redirect_to links_path
    else
      flash.now[:error] = 'Invalid update. Please make sure your url is valid.'
      render :edit
    end
  end

  private

  def link_params
    params.require(:link).permit(:title, :url)
  end
end
