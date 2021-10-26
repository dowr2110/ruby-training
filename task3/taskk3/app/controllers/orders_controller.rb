class OrdersController < ApplicationController
  def index
    @orders = Order.all
    render json: @orders
  end

  def show
    @order = Order.find(params[:id])
    render json: @order
  end

  def create
    @phone = Phone.find(params[:phone_id])
    @order = Order.create(
      phone_id: params[:phone_id],
      user_id: params[:user_id],
      count: params[:count],
      date: params[:date],
      sum: params[:count].to_i * @phone.price
    )
    render json: @order
  end

  def update
    @order = Order.find(params[:id])
    @order.update(
      phone_id: params[:phone_id],
      user_id: params[:user_id],
      count: params[:count],
      date: params[:date],
      sum: params[:sum]
    )
    render json: @order
  end

  def destroy
    @orders = Order.all
    @order = Order.find(params[:id])
    @order.destroy
    render json: @orders
  end
end
