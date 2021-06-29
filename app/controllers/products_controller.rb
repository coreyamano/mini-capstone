class ProductsController < ApplicationController
  def index
    if current_user
      render json: current_user.as_json
    else
      render json: { message: "user not signed in" }
    end
    #products = Product.all
    #render json: products.as_json
  end

  def show
    the_id = params[:id]
    product = Product.find_by(id: the_id)
    render json: product
  end

  def create
    product = Product.new(
      name: params[:name],
      price: params[:price],
      image_url: params[:image_url],
      description: params[:description],
    )
    if product.save
      render json: product.as_json
    else
      render json: { Error: product.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    the_id = params[:id]
    product = Product.find_by(id: the_id)

    product.name = params[:name] || product.name
    product.price = params[:price] || product.price
    product.image_url = params[:image_url] || product.image_url
    product.description = params[:description] || product.description

    if product.save
      render json: product
    else
      render json: { Error: product.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    the_id = params[:id]
    product = Product.find_by(id: the_id)
    product.destroy
    render json: { messge: "you deleted this" }
  end
end
