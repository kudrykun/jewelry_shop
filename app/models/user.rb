class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,
          :rememberable, :trackable, :lockable, :registerable

  belongs_to :picture, optional: true
end
