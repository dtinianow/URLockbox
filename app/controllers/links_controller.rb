class LinksController < ApplicationController
  def index
    @links = Link.where(user: current_user)
  end

  def create
    link = Link.new(
        user_id: current_user.id,
        title: link_params['title'],
        url: link_params['url']
      )
    if link.save
      flash[:success] = "Successfully created link!"
      redirect_to links_path
    else
      flash.now[:error] = 'Invalid link. Please make sure you have a valid URL and enter all parameters.'
      @links = Link.where(user: current_user)
      render :index
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
      flash.now[:error] = 'Invalid update. Please make sure you have a valid URL and enter all parameters.'
      render :edit
    end
  end

  private

  def link_params
    params.require(:link).permit(:title, :url)
  end
end
