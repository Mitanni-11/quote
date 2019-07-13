class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable
  has_many :rhetorics, dependent: :destroy
  has_many :picks, dependent: :destroy
  # has_many :pick_rhetorics, through: :picks, source: :rhetoric
  has_many :comments,dependent: :destroy
  has_many :active_relationships, class_name: "Relationship",
                                  foreign_key: "follower_id",
                                  dependent: :destroy
  has_many :passive_relationships,class_name: "Relationship",
                                  foreign_key: "followed_id",
                                  dependent: :destroy
  has_many :following,through: :active_relationships,source: :followed
  has_many :followers,through: :passive_relationships,source: :follower

  mount_uploader :picture, PictureUploader


  def follow(other_user)
    active_relationships.create(followed_ids: other_user.id)
  end

  def unfollow(other_user)
    passive_relationships.find_by(followed_id: other_user.id).destroy
  end

  def following?(other_user)
    following.include?(other_user)
  end


                 def self.find_for_oauth(auth)
    user = User.where(uid: auth.uid, provider: auth.provider).first

    validates :name, presence: true #追記
    validates :profile, length: { maximum: 200 } #追記

    unless user
      user = User.create(
          uid:      auth.uid,
          provider: auth.provider,
          email:    User.dummy_email(auth),
          password: Devise.friendly_token[0, 20]
      )
    end

    user
  end


  private

  def self.dummy_email(auth)
    "#{auth.uid}-#{auth.provider}@example.com"
  end
end
