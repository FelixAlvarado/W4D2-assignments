# == Schema Information
#
# Table name: cats
#
#  id          :bigint(8)        not null, primary key
#  name        :string           not null
#  birth_date  :date             not null
#  color       :string           not null
#  sex         :string(1)        not null
#  description :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

COLORS = ['Orange', 'Black', 'White', 'Grey']
class Cat < ApplicationRecord

  validates :name, :color, :birth_date, :sex, presence: true
  validates :color, inclusion: { in: COLORS,
   message: "This is not a valid color"}

   has_many :requests,
   primary_key: :id,
   foreign_key: :cat_id,
   class_name: :CatRentalRequest,
   dependent: :destroy

  def age
    Date.today.year - birth_date.year
  end
end
