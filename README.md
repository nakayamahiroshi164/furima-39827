# DB設計
## usersテーブル
| Column | Type | Option |
|-|-|-|
| id(PK) | integer | null: false |      
| nickname | string | null: false |
| email | string | null: false, unique: true |
| encrypted_password | string | null: false |
| last_name | string | null: false |
| first_name | string | null: false |
| last_name_kana | string | null: false |
| first_name_kana | string | null: false |
| date_of_birth | date | null: false |

### Association
- has_many :items

## itemsテーブル
 Column | Type | Option |
|-|-|-|
| id(PK) | integer | null: false |
| name | string | null: false |
| descritption | text | null: false |
| price | integer | null: false |
| category_id | integer | null: false |
| condition_id | integer | null: false |
| shipping_charge_id | integer | null: false |
| shipping_date_id | integer | null: false |
| prefecture_id | integer | null: false |
| user(FK) | references | null: false, |foreign_key: true |

### Association
- belongs_to :user

## purchase_recordsテーブル
 Column | Type | Option |
|-|-|-|
| user_id | integer | null: false |
| item_id | references | null: false |foreign_key: true |

### Association
- has_one :items

## shipping_addressesテーブル
Column | Type | Option |
|-|-|-|
| user_id | references | null: false |foreign_key: true |
| post_code | string | null: false |
| prefecture | integer | null: false |
| city | string | null: false |
| address | string | null: false |
| building_name | string | null: false |
| telephone_number | string | null: false |

validates :post_code, presence: true, format: { with: /\A\d{3}-\d{4}\z/ }
validates :telephone_number, presence: true, length: { minimum: 10, maximum: 11 }, format: { with: /\A\d+\z/ }

## Association
- belongs_to :user



