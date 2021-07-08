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
    #find all carted_products for current user with status "carted"
    carted_products = CartedProduct.where(user_id: current_user.id, status: "carted")

    #each loop for all items that are "carted"
    sub = 0
    carted_products.each do |carted_product|
      sub += carted_product.product.quantity * carted_product.product.price
    end
    #sum of subtotals
    order.subtotal = sub
    #subtotal with tax method
    order.tax = order.subtotal * 0.09
    order.total = order.subtotal + order.tax
    #total method using the subtotal and tax

    #when an order saves, update carted prodcuts status to purchase and order_id to current order's id

    order = Order.new(
      user_id: current_user.id,
      subtotal: order.subtotal,
      tax: order.tax,
      total: order.total,
    )

    if order.save
      carted_products.each do |carted_product|
        carted_product.status = "purchased"
        carted_product.order_id = order.id
      end
      render json: order.as_json
    else
      render json: { Error: order.errors.full_messages }, status: :unprocessable_entity
    end

    # if current_user
    #   order = Order.new(
    #     user_id: current_user.id,
    #     product_id: params[:product_id],
    #   )
    #   product = Product.find_by(id: order.product_id)
    #   order.subtotal = order.quantity * product.price
    #   order.tax = order.subtotal * 0.09
    #   order.total = order.subtotal + order.tax

    # if order.save
    #   carted_product.status = "purchased"
    #   carted_product.order_id = order.id
    #   render json: order.as_json
    # else
    #   render json: { Error: order.errors.full_messages }, status: :unprocessable_entity
    # end
    # else
    #   render json: { message: "user not signed in" }
    # end
  end
end
