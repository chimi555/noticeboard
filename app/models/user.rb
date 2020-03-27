class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         authentication_keys: [:login]
  # 追加のattribute
  attr_accessor :login
  # バリデーション
  validates :name, presence: true, length: { maximum: 20 }
  validates :email, uniqueness: true, presence: true

  def login
    @login || self.name || self.email
  end

  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions.to_h).
        where(['lower(name) = :value OR lower(email) = :value', { value: login.downcase }]).
        first
    elsif conditions.key?(:name) || conditions.key?(:email)
      where(conditions.to_h).first
    end
  end
end
