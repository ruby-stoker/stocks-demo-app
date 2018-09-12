class StocksController < ApplicationController
  before_action :authenticate_user!, except: :index
  before_action :set_stock, only: %i[edit update show destroy]

  def index
    # TODO, IMPLEMENT PAGINATION
    @stocks = current_user ? current_user.stocks : []
  end

  def new
    @stock = current_user.stocks.new
  end

  def create
    @stock = current_user.stocks.new(stock_params)
    if @stock.save
      redirect_to root_path, notice: 'Successfully created.'
    else
      render :new
    end
  end

  def show; end

  def edit; end

  def update
    if @stock.update(stock_params)
      redirect_to root_path, notice: 'Successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    if @stock.destroy
      flash[:notice] = 'Successfully deleted.'
    else
      flash[:alert] = 'Something went wrong, can\'t delete this Stock.'
    end
    redirect_to root_path
  end

  private

  def set_stock
    @stock = current_user.stocks.find(params[:id])
  end

  def stock_params
    params.require(:stock).permit(:name, :duration, :price, :interest)
  end
end
