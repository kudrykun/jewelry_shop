# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Incrustation.delete_all
MetalColor.delete_all
MetalType.delete_all
ProductType.delete_all
SaleSize.delete_all
Size.delete_all
Product.delete_all

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
