class Sin < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true
  translates :name

  validates :explanation, presence: true
  translates :explanation

  accepts_nested_attributes_for :translations, :allow_destroy => true

  has_many :projects, class_name: SinProject
end