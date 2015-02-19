class CartsController < ApplicationController
  before_action :set_cart, only: [:show, :edit, :update, :destroy]

  # GET /carts
  # GET /carts.json
  def index
    @carts = Cart.all.where.not(donation_id: nil )
  end

  # GET /carts/1
  # GET /carts/1.json
  def show
    @path = false
  end

  # GET /carts/new
  def new
    @cart = Cart.new
  end

  # GET /carts/1/edit
  def edit
  end

  def delivered
    if cart = Cart.find_by_id(params["cart_id"])
      cart.update_attributes(delivered_by: current_user.id, delivered: true, delivered_on: DateTime.now.utc)
      render partial: "layouts/carts", locals: { cart: cart }
    end
  end

  def add_to_cart
    if params["item_type"] && params["item_id"] && current_user
      if obj =  params["item_type"].capitalize.constantize.find_by_id(params["item_id"])
        cart = CartItem.new(item_id: obj.id, item_type: obj.class.to_s, price_in_cents: obj.price_in_cents, cart_id: current_user.cart.id)
        cart.save
        render text: cart.cart.total_money
      end
    end
  end

  def deliverer_username
    return self.deliverer.username if self.deliverer
    return nil
  end

  def remove_from_cart
    if params["item_id"] && current_user
      if cart_item = CartItem.find_by_id(params["item_id"])
        cart_item.destroy
        render text: current_user.cart.total_money
      end
    end
  end

  # POST /carts
  # POST /carts.json
  def create
    @cart = Cart.new(cart_params)

    respond_to do |format|
      if @cart.save
        format.html { redirect_to @cart, notice: 'Cart was successfully created.' }
        format.json { render :show, status: :created, location: @cart }
      else
        format.html { render :new }
        format.json { render json: @cart.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /carts/1
  # PATCH/PUT /carts/1.json
  def update
    respond_to do |format|
      if @cart.update(cart_params)
        format.html { redirect_to @cart, notice: 'Cart was successfully updated.' }
        format.json { render :show, status: :ok, location: @cart }
      else
        format.html { render :edit }
        format.json { render json: @cart.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /carts/1
  # DELETE /carts/1.json
  def destroy
    @cart.destroy
    respond_to do |format|
      format.html { redirect_to carts_url, notice: 'Cart was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cart
      @cart = Cart.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def cart_params
      params.require(:cart).permit(:user_id, :total, :delivered, :delivered_by)
    end
end
