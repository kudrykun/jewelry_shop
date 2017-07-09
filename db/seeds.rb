# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Faker::Config.locale = 'ru'


Product.delete_all
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


category_titles = ["Кольца","Подвески","Цепочки","Браслеты","Колье","Ожерелья","Бусы","Кулоны","Пирсы","Запонки","Иконы","Часы","Столовые приборы","Сувениры"]
collection_titles = ["Геометрия","Золото и бриллианты","Вальс тюльпанов","Цветочный рай","Природные мотивы","Золото и бриллианты","Цветной водопад","Солнечное царство","Antique","Эволюция"]
incrustation_titles = ["Алмаз"," Рубин"," Сапфир"," Аквамарин"," Изумруд"," Александрит"," Гранаты"," Аметист"," Опал благородный"," Опал огненный"," Топаз"," Жемчуг"," Янтарь"," Коралл"]


products_size = 10
categories_size = category_titles.size
collections_size = collection_titles.size
incrustations_size = incrustation_titles.size
kits_size = 10
incrustations_size = 10
productTypes_size = 10
saleSizes_size = 10
sizes_size = 10
incrustations_size = 10
metalColors_size = 10
metalTypes_size = 10
incrustations = Incrustation.create([{title: 'Алмаз'},
                                     {title: 'Фионит'},
                                     {title: 'Рубин'},
                                     {title: 'Изумруд'},
                                     {title: 'Янтарь'}])

metal_colors = MetalColor.create([{title: 'Жёлтый'},
                                     {title: 'Белый'},
                                     {title: 'Красный'}])

metal_types = MetalType.create([{title: 'Золото (585)'},
                                    {title: 'Серебро (925)'}])

product_types = ProductType.create([{title: 'С драгоценностями'},
                                   {title: 'Полудраг'}])

sale_sizes = SaleSize.create([{sale_percent: 10},
                                    {sale_percent: 20},
                                    {sale_percent: 50}])

sizes = Size.create([{size: '16'},
                     {size: '16.5'},
                     {size: '17'}])
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
=begin
products = Product.create([{title: 'Кольцо',
                            artikul: '12345',
                            price: 1000.23,
                            metal_color: metal_colors[1],
                           weight: 13.5,
                           product_type: product_types[0],
                           sale_size: sale_sizes[1],
                           old_price: 2000,
                           to_main_page: true,
                           manufacturer: 'Sokoloff',
                           priority: 3,
                           incrustations: [incrustations[2],incrustations[3]],
                           metal_types: [metal_types[0]],
                           size: [sizes[0],sizes[1],sizes[2]]}])
=end
