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
  end
end
