class Book < ApplicationRecord
    validates_presence_of :title, :author, :publication_date
    validates :rating, numericality: { only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 5 }
    validates :status, inclusion: { in: %w(available checked_out reserved) }
end
