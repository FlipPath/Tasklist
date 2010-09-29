class User
  include Mongoid::Document
  
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  
  field :username
  field :name
  key :username
  
  references_many :lists, :stored_as => :array, :inverse_of => :users
  
  validates_presence_of :username
  validates_presence_of :name
  
  validates_uniqueness_of :username, :email, :case_sensitive => false
  
  attr_accessible :username, :name, :email, :password, :password_confirmation
end
