class LinksController < ApplicationController
  def index
    if current_user != nil
      @links = current_user.links.all
    else

    end
  end

  def edit
    @link = Link.find(params[:id])
  end

  def update
    link = Link.find(params[:id].to_i)
    if link.update(link_params)
      flash[:success] = "Updated Link Successfully!"
      redirect_to root_path
    else
      error = link.errors.messages.first[1][0]
      flash[:error] = possible_errors[error]
      redirect_to edit_link_path(link)
    end
  end

  def create
    @link = current_user.links.create(link_params)
    if @link.save
      flash[:success] = "Link saved!"
      redirect_to root_path
    else
      error = @link.errors.messages.first[1][0]
      flash[:notice] = possible_errors[error]
      redirect_to root_path
    end
  end

  private

  def link_params
    params.permit(:url, :title)
  end


  def possible_errors
    {"is invalid" => "You entered an invalid URL, please try again",
     "can't be blank" => "Please enter something into the fields"}
  end
end
