class BankAccount < ApplicationRecord
  belongs_to :client

  validates :client, presense: true
  validates :account_number, presense: true, uniqueness: true
  validates :balance, presense: true, numbericality: true

  before_validation :load_defaults

  def load_defaults
    if self.new_record?
      self.balance = 0.00
    end
  end

  def to_s
    account_number
  end
end
