class CartedProductsController < ApplicationController
  before_action :authenticate_user

  def index
    carted_products = CartedProduct.where(user_id: current_user.id, status: "carted")
    render json: carted_products.as_json
  end

  def create
    carted_product = CartedProduct.new(
      user_id: current_user.id,
      product_id: params[:product_id],
      quantity: params[:quantity],
      status: "carted",
      order_id: params[:order_id],
    )

    if carted_product.save
      render json: carted_product.as_json
    else
      render json: { Error: carted_product.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    carted_product_id = params[:id]
    carted_product = CartedProduct.find_by(id: carted_product_id)
    carted_product.status = "removed"

    if carted_product.save
      render json: { message: "You removed this item." }
    else
      render json: { Error: carted_product.errors.full_messages }, status: :unprocessable_entity
    end
  end
end
