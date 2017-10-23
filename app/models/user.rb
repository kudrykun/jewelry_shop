class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,
          :rememberable,
         :trackable,
         :lockable,
         :registerable,
         :recoverable,
         :timeoutable,
         :validatable

  has_many :activity_logs, dependent: :delete_all
  belongs_to :picture, optional: true

  validates :email, :first_name, :second_name, presence: true
  validates :first_name, format: {with: /\A[а-яА-ЯЁё]{2,20}\Z/,
                                   message:'Только от 2 до 20 кириллических символов'}
  validates :second_name, format: {with: /\A[а-яА-ЯЁё]{2,20}\Z/,
                                  message:'Только от 2 до 20 кириллических символов'}
  validates :email, uniqueness: true, confirmation: true
  validates :email_confirmation, presence: true
  after_create :generate_profile_image

  def generate_profile_image
    # генерим аватарку на основе имени и фамилии
    img = Avatarly.generate_avatar("#{self.first_name} #{self.second_name}", opts={lang: :ru, format: 'jpg', size: 300})

    # костыльное временное изображение
    File.open("#{Rails.root}/app/assets/images/avatar.jpg", 'wb') do |f|
      f.write img
    end

    # создаем новую пикчу в БД
    pic = Picture.create!(image: File.new("#{Rails.root}/app/assets/images/avatar.jpg"))

    # удаляем костыльное временное изображение
    File.delete("#{Rails.root}/app/assets/images/avatar.jpg") if File.exist?("#{Rails.root}/app/assets/images/avatar.jpg")

    # связываем пользователя и картинку и сохраняем
    self.picture_id = pic.id
    self.save
  end
end
