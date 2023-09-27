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
- has_many :purchase_records

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
- has_one : purchase_record


## purchase_recordsテーブル
 Column | Type | Option |
|-|-|-|
| user | references | null: false |foreign_key: true |
| item | references | null: false |foreign_key: true |

### Association
- belongs_to : user
- belongs_to : item
- has_one : shipping_address

## shipping_addressesテーブル
Column | Type | Option |
|-|-|-|
| purchase_record | references | null: false |foreign_key: true |
| post_code | string | null: false |
| prefecture_id | integer | null: false |
| city | string | null: false |
| address | string | null: false |
| building_name | string |
| telephone_number | string | null: false |

## Association
- belongs_to : purchase_record


