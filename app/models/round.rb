class Round < ApplicationRecord

  has_many :results, as: :resultable

end
