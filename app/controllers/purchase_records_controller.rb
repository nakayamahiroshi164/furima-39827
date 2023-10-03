class PurchaseRecordsController < ApplicationController
  before_action :authenticate_user!
  before_action :non_purchased_item, only: [:index, :create]


  def index
    @purchase_record_shipping_address = PurchaseRecordShippingAddress.new
  end


    def create
      @purchase_record_shipping_address = PurchaseRecordShippingAddress.new(purchase_record_params)
      if @purchase_record_shipping_address.valid?
         @purchase_record_shipping_address.save
         redirect_to root_path
      else
        render :index
      end
    end
 
 private

 def purchase_record_params
  params.require(:purchase_record_shipping_address).permit(:post_code, :prefecture_id, :city, :address, :building_name, :telephone_number).merge(user_id: current_user.id, item_id:  params[:item_id])
end

def non_purchased_item
  @item = Item.find(params[:item_id])
  redirect_to root_path if current_user.id == @item.user_id || @item.purchase_record.present?
end
end


