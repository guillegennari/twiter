class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  
  before_destroy :delete_friend

  has_many :friends, dependent: :destroy
  has_many :tweets, dependent: :destroy
  has_many :likes, dependent: :delete_all
  has_many :liked_tweets, :through => :likes, :source => :tweet

  #def arr_friends_id
   # self.friends.pluck(:friend_id)
  #end

  def delete_friend
    Friend.where(friend_id: self.id).destroy_all
  end

  def users_followed
    arr_ids = self.friends.pluck(:friend_id)
    User.find(arr_ids)
  end

  def is_followed?(user)
    users_followed.include? (user)
  end

  def friends_count
    self.friends.count
  end

  def tweets_count
    self.tweets.where(rt_ref:nil).count
  end

  def likes_count
    self.likes.count
  end

  def rt_count
    self.tweets.where.not(rt_ref:nil).count
  end

  def self.authenticate(email, password)
    user = User.find_for_authentication(email: email)
    user&.valid_password?(password) ? user : nil
  end

end
