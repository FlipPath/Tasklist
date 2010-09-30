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
  
  class << self
    def search(query)
      where(:username => /#{query}/i)
    end
  end
  
  def as_json(options={})
    attributes.slice("username")
  end
  
  def can_access_channel(channel_name)
    case channel_name
    when /^(?:presence|private)-list-([\da-f]+)/ then check_list_access($1)
    else false
    end
  end
  
  private
  
  def check_list_access(list_id)
    !!lists.find(list_id) rescue false
  end
end
