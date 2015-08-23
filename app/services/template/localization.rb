class Template::Localization
  attr_reader :user_mkey, :template

  def initialize(user_mkey, template)
    @user_mkey = user_mkey
    @template  = template
    @locale    = :default
  end

  def select
    country = user_country
    @locale = user_locale(country) if country
    return template if default_locale?

    localized = localized_by_locale
    @template.tap do |t|
      t.title = localized.title
      t.body  = localized.body
    end
  end

  private

  def user_locale(country)
    template.locales.each do |loc|
      allowed = LocalizedTemplate::ALLOWED_LOCALES
      return loc if allowed[loc].find { |c| c == country }
    end
    :default
  end

  def user_country
    StatisticsApi.new(user: user_mkey).country['country']
  rescue Faraday::ClientError => e
    WriteLog.faraday_error self, e
    nil
  end

  def localized_by_locale
    template.localized_templates.by_locale @locale
  end

  def default_locale?
    @locale == :default
  end
end
