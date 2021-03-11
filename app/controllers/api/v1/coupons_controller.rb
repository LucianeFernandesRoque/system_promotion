module Api
  module V1
    class CouponsController < ApiController
      before_action :verify_order_code, only: %i[burn]

      def show
        @coupon = Coupon.find_by!(code: params[:code])
        render json: @coupon, status: :ok
      rescue ActiveRecord::RecordNotFound
        render json: 'Cupom não encontrado', status: :not_found
      end

      def burn
        @coupon = Coupon.find_by!(code: params[:code])
        @coupon.burn!(params[:order][:code])
        render json: 'Cupom utilizado com sucesso', status: :ok
      rescue ActiveRecord::RecordInvalid
        render json: '', status: :unprocessable_entity
      end

      private

      def verify_order_code
        return if params.dig(:order, :code)

        render json: '', status: :precondition_failed
      end
    end
  end
end
