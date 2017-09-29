class Product < ApplicationRecord
  belongs_to :metal_color, optional: true
  belongs_to :product_type, optional: true
  belongs_to :category
  belongs_to :sale_size, optional: true
  belongs_to :collection, optional: true
  belongs_to :kit, optional: true, counter_cache: true
  belongs_to :manufacturer, optional: true
  belongs_to :chain_type, optional: true
  has_many :metal_type_products
  has_many :metal_types, through: :metal_type_products
  has_many :incrustation_items, inverse_of: :product
  accepts_nested_attributes_for :incrustation_items, allow_destroy: true
  has_many :incrustations, :through => :incrustation_items
  has_many :size_items, inverse_of: :product
  accepts_nested_attributes_for :size_items, allow_destroy: true
  has_many :sizes, -> { distinct }, :through => :size_items
  has_many :shops, -> { distinct }, :through => :size_items

  #связан полиморфной связью с картинками. Связанные картинки удаляются при удалении товара.
  #TODO Удаляются именно объекты класса Picture. Необходимо явно удалять сами файлы изображений
  has_many :pictures, as: :imageable, dependent: :destroy
  belongs_to :preview, class_name: 'Picture', optional: true

  enum sex: {female: 0, male: 1, unisex: 2, genderless: 3}

  validates :priority,numericality: { greater_than_or_equal_to: 0 }, allow_nil: true
  validates :artikul, :title, presence: true

  def get_shop_sizes(shop)
    a = []
    self.size_items.where(shop: shop).each do |item|
      a << item.size
    end
    a
  end
  self.per_page = 10
  filterrific(
      default_filter_params: { sorted_by: 'created_at_desc' },
      available_filters: [
          :sorted_by,
          :with_metal_type,
          :with_all_metal_type_ids
      ]
  )

  scope :sorted_by, lambda { |sort_option|
    # extract the sort direction from the param value.
    direction = (sort_option =~ /desc$/) ? 'desc' : 'asc'
    case sort_option.to_s
      when /^created_at_/
        order("products.created_at #{ direction }")
      when /^price_/
        order("products.price #{ direction }")
      when /^artikul/
        order("products.artikul #{ direction }")
      else
        raise(ArgumentError, "Invalid sort option: #{ sort_option.inspect }")
    end
  }
  scope :with_metal_type, lambda { |metal_type|
    where(metal_type: {title: metal_type}).joins(:metal_types)
  }

  scope :with_all_metal_type_ids, lambda{ |metal_type_ids|
    # get a reference to the join table
    metal_types_products = MetalTypeProduct.arel_table
    # get a reference to the filtered table
    products = Product.arel_table
    # let AREL generate a complex SQL query
      where(
          MetalTypeProduct \
        .where(metal_types_products[:product_id].eq(products[:id])) \
        .where(metal_types_products[:metal_type_id].in([*metal_type_ids].map(&:to_i))) \
        .exists
      )
  }

=begin
  scope :with_any_role_ids, lambda{ |role_ids|
    # get a reference to the join table
    role_assignments = RoleAssignment.arel_table
    # get a reference to the filtered table
    students = Student.arel_table
    # let AREL generate a complex SQL query
    where(
        RoleAssignment \
      .where(role_assignments[:student_id].eq(students[:id])) \
      .where(role_assignments[:role_id].in([*role_ids].map(&:to_i))) \
      .project(Arel.star) \
      .exists
    )
  }
=end

  # This method provides select options for the `sorted_by` filter select input.
  # It is called in the controller as part of `initialize_filterrific`.
  def self.options_for_sorted_by
    [
        ['Возрастанию цены', 'price_asc'],
        ['Убыванию цены', 'price_desc'],
        ['Новизне', 'created_at_desc'],
        ['Артикулу', 'artikul_asc']
    ]
  end
end
