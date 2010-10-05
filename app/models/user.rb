class User < ActiveRecord::Base  
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  
  
  attr_accessible :username, :name, :email, :password, :password_confirmation
  
  has_many :collaborations
  has_many :lists, :through => :collaborations do
    def managed
      where(:collaborations => { :admin => true })
    end
  end
  
  validates_presence_of :username
  validates_presence_of :name
  
  validates_uniqueness_of :username, :email, :case_sensitive => false
  
  class << self
    def search(query)
      any_of({ :name => /#{query}/i }, { :username => /#{query}/i }, { :email => /#{query}/i })
    end
  end
  
  def channel
    Pusher["private-user-#{id}"]
  end
  
  def can_access_channel(channel_name)
    case channel_name
    when /^(?:presence|private)-user-(.+)/ then $1 == id.to_s
    when /^(?:presence|private)-list-([\da-f]+)/ then check_list_access($1)
    else false
    end
  end
  
  private
  
  def check_list_access(list_id)
    !!lists.find(list_id) rescue false
  end
end
