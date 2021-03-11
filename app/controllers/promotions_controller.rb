class PromotionsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_promotion, only: %i[show edit destroy update generate_coupons]

  def index
    @promotions = Promotion.all
  end

  def edit; end

  def show; end

  def new
    @promotion = Promotion.new
  end

  def create
    @promotion = Promotion.new(promotion_params)
    if @promotion.save
      redirect_to @promotion
    else
      render :new
    end
  end

  def update
    if @promotion.update(promotion_params)
      redirect_to @promotion
    else
      render :edit
    end
  end

  def destroy
    @promotion.destroy
    redirect_to promotions_path
  end

  def generate_coupons
    @promotion.generate_coupons!
    flash[:success] = 'Cupons gerados com sucesso'
    redirect_to @promotion
  end

  private

  def set_promotion
    @promotion = Promotion.find(params[:id])
  end

  def promotion_params
    params
      .require(:promotion)
      .permit(:name, :description, :code,
              :discount_rate, :expiration_date, :coupon_quantity,
              product_category_ids: [])
  end
end
