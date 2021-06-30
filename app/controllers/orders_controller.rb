class OrdersController < ApplicationController

  before_action :authenticate_user

  def index
    orders = Order.where(user_id: current_user.id)
    render json: orders.as_json
  end

  def show
    if current_user
      order = Order.find_by(id: params[:id], user_id: current_user.id)
      render json: order.as_json
    else
      render json: { message: "user not signed in" }
    end
  end

  def create
    if current_user
      order = Order.new(
        user_id: current_user.id,
        product_id: params[:product_id],
        quantity: params[:quantity],
      )
      product = Product.find_by(id: order.product_id)
      order.subtotal = order.quantity * product.price
      order.tax = order.subtotal * 0.09
      order.total = order.subtotal + order.tax

      if order.save
        render json: order.as_json
      else
        render json: { Error: order.errors.full_messages }, status: :unprocessable_entity
      end
    else
      render json: { message: "user not signed in" }
    end
  end
end
