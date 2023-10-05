require 'rails_helper'

RSpec.describe PurchaseRecordShippingAddress, type: :model do
  before do
    @purchase_record_shipping_address  = FactoryBot.build(:purchase_record_shipping_address)
  end

  describe '配送先情報の保存' do
    context '配送先情報の保存ができるとき' do
      it 'すべての値が正しく入力されていれば保存できること' do
        expect(@purchase_record_shipping_address ).to be_valid
      end
      it 'user_idが空でなければ保存できる' do
        @purchase_record_shipping_address .user_id = 1
        expect(@purchase_record_shipping_address ).to be_valid
      end
      it 'item_idが空でなければ保存できる' do
        @purchase_record_shipping_address .item_id = 1
        expect(@purchase_record_shipping_address ).to be_valid
      end
      it '郵便番号が「3桁＋ハイフン＋4桁」の組み合わせであれば保存できる' do
        @purchase_record_shipping_address .post_code = '123-4560'
        expect(@purchase_record_shipping_address ).to be_valid
      end
      it '都道府県が「---」以外かつ空でなければ保存できる' do
        @purchase_record_shipping_address .prefecture_id = 1
        expect(@purchase_record_shipping_address ).to be_valid
      end
      it '市区町村が空でなければ保存できる' do
        @purchase_record_shipping_address .city = '大阪市'
        expect(@purchase_record_shipping_address ).to be_valid
      end
      it '番地が空でなければ保存できる' do
        @purchase_record_shipping_address .address = '城東区１２３'
        expect(@purchase_record_shipping_address ).to be_valid
      end
      it '建物名が空でも保存できる' do
        @purchase_record_shipping_address .building_name = nil
        expect(@purchase_record_shipping_address ).to be_valid
      end
      it '電話番号が11番桁以内かつハイフンなしであれば保存できる' do
        @purchase_record_shipping_address .telephone_number = 12_345_678_910
        expect(@purchase_record_shipping_address ).to be_valid
      end
    end

    context '配送先情報の保存ができないとき' do
      it 'user_idが空だと保存できない' do
        @purchase_record_shipping_address.user_id = nil
        @purchase_record_shipping_address.valid?
        expect(@purchase_record_shipping_address.errors.full_messages).to include("User can't be blank")
      end
      it 'item_idが空だと保存できない' do
        @purchase_record_shipping_address.item_id = nil
        @purchase_record_shipping_address.valid?
        expect(@purchase_record_shipping_address.errors.full_messages).to include("Item can't be blank")
      end
      it '郵便番号が空だと保存できないこと' do
        @purchase_record_shipping_address.post_code = nil
        @purchase_record_shipping_address.valid?
        expect(@purchase_record_shipping_address.errors.full_messages).to include("Post code can't be blank", 'Post code is invalid. Include hyphen(-)')
      end
      it '郵便番号にハイフンがないと保存できないこと' do
        @purchase_record_shipping_address.post_code = 1_234_567
        @purchase_record_shipping_address.valid?
        expect(@purchase_record_shipping_address.errors.full_messages).to include('Post code is invalid. Include hyphen(-)')
      end
      it '都道府県が「---」だと保存できないこと' do
        @purchase_record_shipping_address.prefecture_id = 0
        @purchase_record_shipping_address.valid?
        expect(@purchase_record_shipping_address.errors.full_messages).to include("Prefecture can't be blank")
      end
      it '都道府県が空だと保存できないこと' do
        @purchase_record_shipping_address.prefecture_id = nil
        @purchase_record_shipping_address.valid?
        expect(@purchase_record_shipping_address.errors.full_messages).to include("Prefecture can't be blank")
      end
      it '市区町村が空だと保存できないこと' do
        @purchase_record_shipping_address.city = nil
        @purchase_record_shipping_address.valid?
        expect(@purchase_record_shipping_address.errors.full_messages).to include("City can't be blank")
      end
      it '番地が空だと保存できないこと' do
        @purchase_record_shipping_address.address = nil
        @purchase_record_shipping_address.valid?
        expect(@purchase_record_shipping_address.errors.full_messages).to include("Address can't be blank")
      end
      it '電話番号が空だと保存できないこと' do
        @purchase_record_shipping_address.telephone_number = nil
        @purchase_record_shipping_address.valid?
        expect(@purchase_record_shipping_address.errors.full_messages).to include("Telephone number can't be blank")
      end
      it '電話番号にハイフンがあると保存できないこと' do
        @purchase_record_shipping_address.telephone_number = '123 - 1234 - 1234'
        @purchase_record_shipping_address.valid?
        expect(@purchase_record_shipping_address.errors.full_messages).to include('Telephone number is invalid')
      end
      it '電話番号が12桁以上あると保存できないこと' do
        @purchase_record_shipping_address.telephone_number = 12_345_678_910_123_111
        @purchase_record_shipping_address.valid?
        expect(@purchase_record_shipping_address.errors.full_messages).to include('Telephone number is invalid')
      end
      it 'トークンが空だと保存できないこと' do
        @purchase_record_shipping_address.token = nil
        @purchase_record_shipping_address.valid?
        expect(@purchase_record_shipping_address.errors.full_messages).to include("Token can't be blank")
      end
    end
  end
end