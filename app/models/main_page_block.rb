class MainPageBlock < ApplicationRecord
  belongs_to :picture, class_name: 'Picture', optional: true
end