class PurchaseRecordsController < ApplicationController
  before_action :authenticate_user!
  before_action :non_purchased_item, only: [:index, :create]
  before_action :set_public_key, only: [:index, :create]



  def index
    @purchase_record_shipping_address = PurchaseRecordShippingAddress.new
  end


    def create
      @purchase_record_shipping_address = PurchaseRecordShippingAddress.new(purchase_record_params)       
      if @purchase_record_shipping_address.valid?
        pay_item
         @purchase_record_shipping_address.save
         redirect_to root_path
      else
        gon.public_key = ENV["PAYJP_PUBLIC_KEY"]
        render :index
      end
    end
 
 private

 def purchase_record_params
  params.require(:purchase_record_shipping_address).permit(:post_code, :prefecture_id, :city, :address, :building_name, :telephone_number).merge(user_id: current_user.id, item_id:  params[:item_id], token: params[:token])
end

def pay_item
  Payjp.api_key = ENV['PAYJP_SECRET_KEY']
  Payjp::Charge.create(
    amount: @item.price,        # 商品の値段
    card: purchase_record_params[:token], # カードトークン
    currency: 'jpy'             # 通貨の種類（日本円）
  )
end

def set_public_key
  gon.public_key = ENV["PAYJP_PUBLIC_KEY"]
end


def non_purchased_item
  @item = Item.find(params[:item_id])
  redirect_to root_path if current_user.id == @item.user_id || @item.purchase_record.present?

end
end


