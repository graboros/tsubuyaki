require 'factory_girl_rails'

RSpec.configure do |config|
  # FactoryGirl.definition_file_paths = %w('./factories')
  config.include FactoryGirl::Syntax::Methods
  config.before do
    FactoryGirl.reload
    # FactoryGirl.find_definitions
  end
end
