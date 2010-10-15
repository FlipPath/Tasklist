class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  
  
  attr_accessible false
  
  has_many :groups, :dependent => :destroy, :order => "position DESC"
  
  has_many :list_associations
  has_many :lists, :through => :list_associations
  has_many :owned_lists, :through => :list_associations, :source => :list, :conditions => ["list_associations.role = ?", "owner"]
  has_many :shared_lists, :through => :list_associations, :source => :list, :conditions => ["list_associations.role = ?", "collaborator"]
  
  validates_presence_of :username
  validates_presence_of :name
  
  validates_uniqueness_of :username, :email, :case_sensitive => false
  
  def channel
    Pusher[private_channel_name]
  end
  
  def private_channel_name
    "private-user-#{id}"
  end
  
  def can_access_channel(channel_name)
    case channel_name
    when /^(?:presence|private)-user-(\d+)/ then $1 == id.to_s
    when /^(?:presence|private)-list-(\d+)/ then check_list_access($1)
    else false
    end
  end
  
  private
  
  def check_list_access(list_id)
    !!lists.find(list_id) rescue false
  end
end

# == Schema Info
#
# Table name: users
#
#  id                   :integer         not null, primary key
#  email                :string(255)     not null, default("")
#  encrypted_password   :string(128)     not null, default("")
#  password_salt        :string(255)     not null, default("")
#  reset_password_token :string(255)
#  remember_token       :string(255)
#  remember_created_at  :datetime
#  sign_in_count        :integer         default(0)
#  current_sign_in_at   :datetime
#  last_sign_in_at      :datetime
#  current_sign_in_ip   :string(255)
#  last_sign_in_ip      :string(255)
#  username             :string(255)
#  name                 :string(255)
#  created_at           :datetime
#  updated_at           :datetime