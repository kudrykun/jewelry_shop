# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Faker::Config.locale = 'ru'


Product.all.each do |product|
  product.incrustations = []
  product.sizes = []
  product.metal_types = []
  product.delete
end
Category.delete_all
Collection.delete_all
Kit.delete_all
Incrustation.delete_all
ProductType.delete_all
SaleSize.delete_all
Size.delete_all
Incrustation.delete_all
MetalColor.delete_all
MetalType.delete_all
Manufacturer.delete_all


category_titles = ["Кольца","Подвески","Цепочки","Браслеты","Колье","Ожерелья","Бусы","Кулоны","Пирсы","Запонки","Иконы","Часы","Столовые приборы","Сувениры"]
collection_titles = ["Геометрия","Золото и бриллианты","Вальс тюльпанов","Цветочный рай","Природные мотивы","Золото и бриллианты","Цветной водопад","Солнечное царство","Antique","Эволюция"]
incrustation_titles = ["Алмаз"," Рубин"," Сапфир"," Аквамарин"," Изумруд"," Александрит"," Гранаты"," Аметист"," Опал благородный"," Опал огненный"," Топаз"," Жемчуг"," Янтарь"," Коралл"]
kit_titles = ["Альфа","Бета","Гамма","Дельта","Эпсилон","Дзета","Эта","Тета","Йота","Каппа","Лямбда","Омикрон"]
size_titles = ["15","15.5","16","16.5","17","17.5","18","18.5","19","19.5","20"]
sale_Size_percent = [10,20,30]
metal_color_titles = ["Белый","Желтый","Красный","Розовый"]
metal_type_titles = ["Золото(585)","Серебро(825)","Красное золото","Белое золото"]
product_type_titles = ["Полудраг","С драгоценностями"]

products_size = 1000
categories_size = category_titles.size
collections_size = collection_titles.size
incrustations_size = incrustation_titles.size
kits_size = kit_titles.size
productTypes_size = product_type_titles.size
saleSizes_size = sale_Size_percent.size
sizes_size = size_titles.size
metalColors_size = metal_color_titles.size
metalTypes_size = metal_type_titles.size
manufacturers_size = 5;

manufacturers = []
manufacturers_size.times do
  manufacturers << Manufacturer.create(title: Faker::Company.name);
end

categories = []
categories_size.times do
  categories << Category.create(title: category_titles.delete(category_titles.sample),
                                priority: Faker::Number.between(1,categories_size))
end

collections = []
collections_size.times do
  collections << Collection.create(title: collection_titles.delete(collection_titles.sample),
                                 description: Faker::Boolean.boolean ? Faker::Hipster.paragraph : '',
                                 priority: Faker::Number.between(1,collections_size))
end

incrustations = []
incrustations_size.times do
  incrustations << Incrustation.create(title: incrustation_titles.delete(incrustation_titles.sample))
end

sizes = []
sizes_size.times do
  sizes << Size.create(size: size_titles.delete(size_titles.sample))
end

saleSizes = []
saleSizes_size.times do
  saleSizes << SaleSize.create(sale_percent: sale_Size_percent.delete(sale_Size_percent.sample))
end

metalColors = []
metalColors_size.times do
  metalColors << MetalColor.create(title: metal_color_titles.delete(metal_color_titles.sample))
end

metalTypes = []
metalTypes_size.times do
  metalTypes << MetalType.create(title: metal_type_titles.delete(metal_type_titles.sample))
end

kits = []
kits_size.times do
  kits << Kit.create(title: kit_titles.delete(kit_titles.sample))
end

product_types = []
productTypes_size.times do
  product_types << ProductType.create(title: product_type_titles.delete(product_type_titles.sample))
end

products = []
products_size.times do |i|
  products << Product.create(title: "Товар #{i}",
                             price: Faker::Number.between(5000,50000),
                             metal_color: metalColors.sample,
                              artikul: Faker::Code.asin,
                              weight: Faker::Number.between(5,30),
                              product_type: product_types.sample,
                              sale_size: Faker::Boolean.boolean(0.2) ? saleSizes.sample : nil,
                              new_price: Faker::Number.between(5000,50000),
                              to_main_page: Faker::Boolean.boolean(0.1),
                              manufacturer: manufacturers.sample,
                              priority: Faker::Number.between(1,products_size),
                              sex: Faker::Number.between(0,3),
                              category: categories.sample,
                              collection: Faker::Boolean.boolean(0.4) ? collections.sample : nil,
                              kit: Faker::Boolean.boolean(0.2) ? kits.sample : nil)
  products.last.incrustations << incrustations.sample(Faker::Number.between(0,3))
  products.last.metal_types << metalTypes.sample(Faker::Number.between(0,2))
  products.last.sizes << sizes.sample(Faker::Number.between(1,5))

end

