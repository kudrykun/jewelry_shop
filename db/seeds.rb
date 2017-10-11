Faker::Config.locale = 'ru'

ProductsPromo.delete_all
Promo.delete_all
Slide.delete_all
MetalTypeProduct.delete_all
SizeItem.delete_all
Product.all.each do |product|
  product.incrustations = []
  product.metal_types = []
  product.delete
end
Shop.delete_all
Size.delete_all
ProductType.delete_all
Category.delete_all
Collection.delete_all
ChainType.delete_all
Kit.delete_all
Incrustation.delete_all
IncrustationItem.delete_all
SaleSize.delete_all
Incrustation.delete_all
MetalColor.delete_all
MetalType.delete_all
Manufacturer.delete_all
Picture.delete_all

# база названий для основных таблицЦЕПОЧКИ
category_titles = ["Кольца","Серьги","Подвески","Кулоны","Часы","Колье","Браслеты","Столовые приборы"]
collection_titles = ["Геометрия","Золото и бриллианты","Вальс тюльпанов","Цветочный рай","Природные мотивы","Золото и бриллианты","Цветной водопад","Солнечное царство","Antique","Эволюция"]
incrustation_titles = ["Алмаз","Рубин","Сапфир","Аквамарин","Изумруд","Александрит","Гранаты","Аметист","Опал благородный","Опал огненный","Топаз","Жемчуг","Янтарь","Коралл"]
kit_titles = ["Альфа","Бета","Гамма","Дельта","Эпсилон","Дзета","Эта","Тета","Йота","Каппа","Лямбда","Омикрон"]
size_titles = ["14","14.5","15","15.5","16","16.5","17","17.5","18","18.5","19","19.5","20","20.5","21","21.5","22","22.5","23","23.5","24","24.5","25","40","45","50","55","60","65","70","75"]
sale_Size_percent = [10,20,30,40,50]
metal_color_titles = ["Белый","Желтый","Красный","Розовый"]
metal_type_titles = ["Золото(585)","Серебро(925)"]
shop_titles = ["Универмаг","Линия"]
chain_type_titles = ["Якорное","Двойной якорь","Ролло","Шопард","Гарибальди","Аврора","Гавайка","Панцирная","Ромб","Нонна","Фигаро","Картье","Лав","Улитка","Скрепка","Роза","Снейк","Корда","Сингапур","Бисмарк","Питон",""]

# количество генерируемых товаров
products_size = 500

# количество остальных сущностей
categories_size = category_titles.size
collections_size = collection_titles.size
incrustations_size = incrustation_titles.size
kits_size = kit_titles.size
saleSizes_size = sale_Size_percent.size
sizes_size = size_titles.size
metalColors_size = metal_color_titles.size
metalTypes_size = metal_type_titles.size
manufacturers_size = 5;
shops_size = shop_titles.size
chain_types_size = chain_type_titles.size
promos_size = 10
slides_size = 5

# создание сущностей
manufacturers = []
manufacturers_size.times do
  manufacturers << Manufacturer.create(title: Faker::Company.name);
end

categories = []
categories_size.times do |j|
  categories << Category.create(title: category_titles[j],
                                priority: j + 1, preview_priority: j + 1, to_nav: true)
  temp = categories.last
  rand(6).times do |i|
    temp.product_types.create(title: "#{temp.title}#Вид изделия #{i}")
  end
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

promos = []
promos_size.times do
  promos << Promo.create(title: Faker::StarWars.character, text:Faker::Lorem.paragraph(6))
end

sizes = []
sizes_size.times do
  sizes << Size.create(size: size_titles.delete(size_titles.sample))
end

shops = []
shops_size.times do
  shops << Shop.create(title: shop_titles.delete(shop_titles.sample))
end

chain_types = []
chain_types_size.times do
  chain_types << ChainType.create(title: chain_type_titles.delete(chain_type_titles.sample))
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
  Kit.reset_counters(kits.last.id, :products)
end

slides = []
slides_size.times do
  slides << Slide.create(hide: Faker::Boolean.boolean(0.4), href: Faker::Internet.url)
end

# создание товаров
products = []
products_size.times do |i|
  temp = categories.sample
  products << Product.create(title: "Товар #{i}",
                             price: 5000 + rand(45001),
                             metal_color: metalColors.sample,
                             artikul: Faker::Code.asin,
                             weight: 5 + rand(26),
                             product_type: temp.product_types.sample,
                             sale_size: Faker::Boolean.boolean(0.3) ? saleSizes.sample : nil,
                             to_main_page: Faker::Boolean.boolean(0.1),
                             manufacturer: manufacturers.sample,
                             priority: Faker::Number.between(1,products_size),
                             sex: Faker::Number.between(0,3),
                             category: temp,
                             chain_type: Faker::Boolean.boolean(0.1) ? chain_types.sample : nil,
                             collection: Faker::Boolean.boolean(0.4) ? collections.sample : nil,)
  # переменная под созданный продукт
  temp = products.last

  # делаем цену за грамм, исходя из цены и веса
  temp.price_per_gramm = (temp.price / temp.weight).to_i

  # ставим новую цену в соответствии со скидкой
  if temp.sale_size != nil
    temp.new_price = (temp.price - temp.price / 100 * temp.sale_size.sale_percent.to_f).to_i
  end

  # делаем от 0 до 5 вставок
  rand(6).times do
    temp.incrustation_items.create(quantity: 1 + rand(100), weight: 0.5 + rand(4), purity: Faker::Boolean.boolean(0.5) ? 1 + rand(10) : nil, incrustation: incrustations.sample)
  end

  # выбираем рандомный металл
  # temp.metal_types << metalTypes.sample(rand(2))
  MetalTypeProduct.create(product: products.last,metal_type: metalTypes.sample)

  # Связываем товары с акциями
  if Faker::Boolean.boolean(0.1)
    ProductsPromo.create(product: products.last, promo: promos.sample)
  end

  # для каждого магазина делаем от 0 до 4 уникальных(в рамках магазина) размеров
  shops.each do |shop|
    rand(4).times do
      temp.size_items.create(shop: shop, size: sizes.delete(sizes.sample))
    end

  end

  # сохраняем изменения
  temp.save
end

# Делаем каждому комплекту по 2-3 товара
kits.each do |kit|
  (2 + rand(2)).times do
    kit.products << products.delete(products.sample)
  end
end
