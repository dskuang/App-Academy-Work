class CatRentalRequest < ActiveRecord::Base
  validates :cat_id, presence: true
  validates :start_date, presence: true
  validates :end_date, presence: true
  validate :overlapping_approved_requests
  # validate :date_validation
  validate :set_correct_status

  before_validation :defaults

  belongs_to(
    :cat,
    dependent: :destroy
  )

  def date_validation
    unless self.start_date < self.end_date
      errors[:start_date] << "Start date greater than end date"
    end

  end

  def overlapping_requests
    arr = []
    rental_requests = self.cat.cat_rental_requests
    rental_requests.each do |rental|
      if (self.start_date <= rental.end_date && self.end_date >= start_date) && rental.id != self.id
        arr << rental
      end
    end
    arr
  end

  def overlapping_approved_requests
    requests = overlapping_requests.select{ |request| request.status == "APPROVED" }
    if !requests.empty? && self.status == "APPROVED"
      errors[:start_date] << "This cat is taken."
    end
  end

  def overlapping_pending_requests
    overlapping_requests.select{ |request| request.status == "PENDING" }
  end


  def defaults
    self.status ||= "PENDING"
  end

  def set_correct_status
    unless ["PENDING","APPROVED","DENIED"].include?(self.status)
      errors[:status] << "WRONG STATUS"
    end
  end

  def approve!
    CatRentalRequest.transaction do
      self.status = "APPROVED"
      self.save
      self.overlapping_pending_requests.each do |rental|
          rental.denied!
      end
    end
  end

  def denied!
    self.status = "DENIED"
    self.save
  end

end
