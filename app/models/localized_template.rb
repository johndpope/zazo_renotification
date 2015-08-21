class LocalizedTemplate < ActiveRecord::Base
  ALLOWED_LOCALES  = %i(russian)
  MATCHING_LOCALES = [
    { russian: %w(RU UA) }
  ].freeze

  belongs_to :template

  validates :template, :body, presence: true
  validates :locale, presence: true, inclusion: { in: ALLOWED_LOCALES.map(&:to_s), message: '%{value} is not a valid locale' }
  validates_with UniqueLocaleValidator, on: :create
  validates_with Template::SyntaxValidator
end
