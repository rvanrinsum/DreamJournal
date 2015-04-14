class DreamsController < ApplicationController
  before_action :logged_in_user, only: [:show, :create, :destroy]

  def show
    @dream = Dream.find(params[:id])
  end

  def create
    @dream = current_user.dreams.build(dream_params)

    if @dream.save
      flash[:success] = 'Dream was successfully added'
      redirect_to current_user
    else
      @dreams = Dream.order("created_at DESC")
      render 'index', locals: {form_hidden: false}
    end
  end

  private
    def dream_params
      params.require(:dream).permit(:name, :description, :date, :lucid, dreamsign_ids: [] )
    end
    
end
