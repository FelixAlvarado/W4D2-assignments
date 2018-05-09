# == Schema Information
#
# Table name: cat_rental_requests
#
#  id         :bigint(8)        not null, primary key
#  cat_id     :integer          not null
#  start_date :date             not null
#  end_date   :date             not null
#  status     :string           default("PENDING"), not null
#

STATUS = ['PENDING','APPROVED', 'DENIED']


class CatRentalRequest < ApplicationRecord
  validates :cat_id, :start_date, :end_date, :status, presence: true
  validates :status, inclusion: { in: STATUS, message: "This is not a valid status"}
  validate :does_not_overlap_approved_requests
  belongs_to :cat,
  primary_key: :id,
  foreign_key: :cat_id,
  class_name: :Cat

  def overlapping_requests
    CatRentalRequest.where.not("end_date < #{start_date} OR #{end_date} < start_date")
    .where(cat_id: self.cat_id)
    .where.not(id: self.id )
  end

  def status_approved?
    :status == 'APPROVED'
  end

  def overlapping_approved_requests
    overlapping_requests.where("status = 'APPROVED'")
  end

  def does_not_overlap_approved_requests
    overlapping_approved_requests.exists?
  end

end
