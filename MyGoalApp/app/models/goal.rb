class Goal  < ApplicationRecord

  validates :title, :finished, :visibiilty, :user, presence: true
  validates :finished, inclusion: %w(Yes No)
  validates :visibility, inclusion: %w(Public Private)

  belongs_to :user
  has_many :comments

end
