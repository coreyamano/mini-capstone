class OrdersController < ApplicationController
  def index
    if current_user
      orders = Order.all
      render json: orders.as_json
    else
      render json: { message: "user not signed in" }
    end
  end

  def show
    if current_user
      the_id = params[:id]
      order = Order.find_by(id: the_id)
      render json: order
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
