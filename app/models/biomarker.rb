class Biomarker < ApplicationRecord
  validates :biomarker_type, presence: true
  validates :value, presence: true
  validates :recorded_at, presence: true
end
