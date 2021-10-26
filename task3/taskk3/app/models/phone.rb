class Phone < ApplicationRecord
  has_many :orders

  belongs_to :provider
  belongs_to :company
end
