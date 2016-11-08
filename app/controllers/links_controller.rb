class LinksController < ApplicationController
  def index
    @links = current_user.links
  end

  def create
    parsed_link = LinkParser.new(link_params[:url])
    link = current_user.links.new(url: parsed_link.url , title: link_params[:title])
    if link.save && parsed_link.should_be_emailed?
      UserNotifier.send_link(current_user, parsed_link.recipient, parsed_link.url).deliver_now
      flash[:success] = "Successfully created link and sent email to #{parsed_link.recipient}!"
    elsif link.save
      flash[:success] = "Successfully created link!"
    else
      flash[:error] = 'Invalid link. Please make sure you have a valid URL and enter all parameters.'
    end
    redirect_to links_path
  end

  def edit
    @link = current_user.links.find(params[:id])
  end

  def update
    @link = current_user.links.find(params[:id])
    parsed_link = LinkParser.new(link_params[:url])
    if @link.update(url: parsed_link.url, title: link_params[:title])
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
