class CouponsController < ApplicationController
  before_action :set_coupon, only: %i[inactivate activate]

  def inactivate
    @coupon.inactive!
    flash[:success] = t('.success')
    redirect_to @coupon.promotion
  end

  def activate
    @coupon.active!
    flash[:notice] = t('.notice')
    redirect_to @coupon.promotion
  end

  def index
    @coupons = Coupon.search(params[:query])
  end

  private

  def set_coupon
    @coupon = Coupon.find(params[:id])
  end

  def search_params
    params.require(:coupon).permit(:code, :status, :query)
  end
end
