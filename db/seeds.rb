# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
# 管理者作成
Admin.create!(
    email: "test@test",
    password: "testes"
)
# ジャンル作成
[
    'ケーキ','プリン','焼き菓子','キャンディ'
    ].each do |name|
    Genre.create!(
    name: name
    )
end
# 商品作成
[
  [1,'チーズタルト', 'チーズタルトです',1200,true],
  [1,'ザッハトルテ', 'ザッハトルです',2900,true],
  [1,'モンブラン', 'モンブランです',500,false],
  [2,'濃厚プリン', '濃厚プリンです',500,false],
  [3,'クッキー', 'クッキーです',800,true]
].each do |genre_id,name, introduction, notax_price,is_active|
  Item.create!(
    { genre_id:genre_id, name:name,introduction:introduction, notax_price:notax_price,is_active:is_active}
  )
  end