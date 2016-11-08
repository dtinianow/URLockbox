class LinksController < ApplicationController
  def index
    @links = current_user.links
  end

  def create
    link_params['url'] = Link.parse(link_params['url'])
    link = current_user.links.new(link_params)
    if link.save
      flash[:success] = "Successfully created link!"
      redirect_to links_path
    else
      flash[:error] = 'Invalid link. Please make sure you have a valid URL and enter all parameters.'
      redirect_to links_path
    end
  end

  def edit
    @link = current_user.links.find(params[:id])
  end

  def update
    @link = current_user.links.find(params[:id])
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
