class PurchaseRecordShippingAddress
  include ActiveModel::Model
  attr_accessor :post_code, :prefecture_id, :city, :address, :building_name, :telephone_number, :item_id, :user_id, :token
 

  # ここにバリデーションの処理を書く
  with_options presence: true do
    validates :item_id, numericality: {only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 1000000, message: 'is invalid'}
    validates :user_id
    validates :post_code, format: {with: /\A[0-9]{3}-[0-9]{4}\z/, message: "is invalid. Include hyphen(-)"}
    validates :prefecture_id, numericality: { other_than: 0, message: "can't be blank" }
    validates :city
    validates :address
    validates :telephone_number, format: { with: /\A\d{10,11}\z/, message: 'is invalid' }
    validates :token
  end
  
  def save
    # 各テーブルにデータを保存する処理を書く
    purchase_record = PurchaseRecord.create(item_id: item_id, user_id: user_id)
    ShippingAddress.create(post_code: post_code, prefecture_id: prefecture_id, city: city, address: address, building_name: building_name, telephone_number: telephone_number, purchase_record_id: purchase_record.id)
  
  end
end

