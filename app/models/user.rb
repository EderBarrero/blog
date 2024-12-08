class User < ApplicationRecord

  validates :role, :first_name, :last_name, presence: true

  has_many :posts, dependent: :destroy

  scope :is_admin, -> {where("role = ?", 1)}
  # Ex:- scope :active, -> {where(:active => true)}
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
 
  enum role: [:user, :moderator, :admin]

  after_initialize :set_default_role, :if => :new_record? 

  def set_default_role
    self.role ||= :user
  end
end






