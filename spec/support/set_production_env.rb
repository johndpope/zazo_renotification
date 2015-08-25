def set_production_env
  allow(Rails).to receive(:env).and_return ActiveSupport::StringInquirer.new('production')
end
