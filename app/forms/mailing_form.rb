class MailingForm
  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend  ActiveModel::Naming

  attr_accessor :key, :phones, :text

  validates :key, :text, presence: true
  validate :at_least_one_phone,
           :phones_are_valid,
           :phones_without_plus_sign,
           :key_is_unique

  def initialize(options = {})
    @key    = options[:key]
    @text   = options[:text]
    @phones = options[:phones]
  end

  private

  #
  # validators
  #

  def phones_are_valid
    phones.split.each do |ph|
      phone = Phonelib.parse "+#{ph}"
      errors.add(:phones, "incorrect phone: #{ph}") unless phone.valid?
    end
  end

  def phones_without_plus_sign
    errors.add(:phones, 'plus \'+\' sign is not allowed') if phones.include?('+')
  end

  def at_least_one_phone
    errors.add(:phones, 'phones not presented') if phones.split.size < 1
  end

  def key_is_unique
    errors.add(:key, "key '#{key}' already exists") unless Mailing.by_key(key).empty?
  end
end
