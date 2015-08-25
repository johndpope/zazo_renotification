class LocalizedTemplate::UniqueLocaleValidator < ActiveModel::Validator
  def validate(record)
    msg = "template with #{record.locale} locale already exist"
    record.errors.add(:locale, msg) if locale_exist?(record.template, record.locale)
  end

  private

  def locale_exist?(template, locale)
    !LocalizedTemplate.where(template: template).where(locale: locale).empty?
  end
end
