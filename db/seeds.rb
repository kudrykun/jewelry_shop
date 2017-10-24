Faker::Config.locale = 'ru'

Picture.all.each do |picture|
  picture.image.destroy
  picture.destroy
end

# база названий для основных таблицЦЕПОЧКИ
category_titles = ["Кольца","Серьги","Подвески","Цепи","Браслеты"]
size_titles = ["В наличии","14","14.5","15","15.5","16","16.5","17","17.5","18","18.5","19","19.5","20","20.5","21","21.5","22","22.5","23","23.5","24","24.5","25","40","45","50","55","60","65","70","75"]
sale_Size_percent = [10,20,30,40,50]
metal_color_titles = ["Белый","Желтый","Красный","Розовый"]
metal_type_titles = ["Золото(585)","Серебро(925)"]
shop_titles = ["Универмаг","Линия"]


# количество остальных сущностей
categories_size = category_titles.size
saleSizes_size = sale_Size_percent.size
sizes_size = size_titles.size
metalColors_size = metal_color_titles.size
metalTypes_size = metal_type_titles.size
shops_size = shop_titles.size

# создание сущностей

categories = []
categories_size.times do |j|
  categories << Category.create(title: category_titles[j], to_nav: true)
end

sizes = []
sizes_size.times do
  sizes << Size.create(size: size_titles.delete(size_titles.sample))
end

shops = []
shops_size.times do
  shops << Shop.create(title: shop_titles.delete(shop_titles.sample))
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

