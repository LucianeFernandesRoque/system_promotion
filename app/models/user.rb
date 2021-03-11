class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validate :email_domain

  def email_domain
    return if email.include?('@locaweb.com.br')

    errors.add(:email, :domain_invalid)
  end
end
