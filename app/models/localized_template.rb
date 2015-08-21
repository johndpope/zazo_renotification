class LocalizedTemplate < ActiveRecord::Base
  ALLOWED_LOCALES  = %i(russian)
  MATCHING_LOCALES = [
    { russian: %w(RU UA) }
  ].freeze

  belongs_to :template

  validates :template, :body, :locale, presence: true
  validates_with Template::SyntaxValidator
  validates_with UniqueLocaleValidator
end
