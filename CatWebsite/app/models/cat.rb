COLORS = ['Orange', 'Black', 'White', 'Grey']
class Cat < ApplicationRecord

  validates :name, :color, :birth_date, :sex, presence: true
  validates :color, inclusion: { in: COLORS,
   message: "This is not a valid color"}
  def age
    Date.today.year - birth_date.year
  end
end
