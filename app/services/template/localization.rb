class Template::Localization
  attr_reader :user_mkey, :template

  def initialize(user_mkey, template)
    @user_mkey = user_mkey
    @template  = template
    @locale    = :default
  end

  def select
    @locale = user_locale
    return template if default_locale?

    localized = localized_by_locale
    @template.tap do |t|
      t.title = localized.title
      t.body  = localized.body
    end
  end

  private

  def user_locale
    country = user_country
    template.locales.each do |loc|
      allowed = LocalizedTemplate::ALLOWED_LOCALES
      return loc if allowed[loc].find { |c| c == country }
    end if country
    :default
  end

  def user_country
    return nil if Rails.env.test?
    DataProviderApi.new(user: user_mkey, attrs: :country).query(:attributes)['country']
  rescue Faraday::ClientError => e
    Zazo::Tool::Logger.info(self, "faraday exception; class: #{e.class}; response #{e.response[:body]}")
    nil
  end

  def localized_by_locale
    template.localized_templates.by_locale @locale
  end

  def default_locale?
    @locale == :default
  end
end
