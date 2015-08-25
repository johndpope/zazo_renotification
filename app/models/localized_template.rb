class LocalizedTemplate < ActiveRecord::Base
  ALLOWED_LOCALES = {
    russian: %w(RU UA)
  }.freeze

  belongs_to :template

  validates :template, :body, presence: true
  validates :locale, presence: true, inclusion: { in: ALLOWED_LOCALES.keys.map(&:to_s), message: '%{value} is not a valid locale' }
  validates_with UniqueLocaleValidator, on: :create
  validates_with Template::SyntaxValidator

  def self.by_locale(loc)
    where(locale: loc).limit(1).first
  end
end
