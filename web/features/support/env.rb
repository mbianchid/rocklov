require "allure-cucumber"
require "capybara"
require "capybara/cucumber"
require "faker"
require "webdrivers"

CONFIG = YAML.load_file(File.join(Dir.pwd, "features/support/config/#{ENV["CONFIG"]}"))

case ENV["BROWSER"]
when "firefox"
  @driver = :selenium
when "chrome"
  @driver = :selenium_chrome
when "fire_headless"
  @driver = :selenium_headless
when "chrome_headless"
  Capybara.register_driver :selenium_chrome_headless do |app|
    version = Capybara::Selenium::Driver.load_selenium
    
    browser_options = ::Selenium::WebDriver::Chrome::Options.new.tap do |opts|
      opts.add_argument("--headless")
      opts.add_argument("--disable-gpu") if Gem.win_platform?
      # Workaround https://bugs.chromium.org/p/chromedriver/issues/detail?id=2650&q=load&sort=-id&colspec=ID%20Status%20Pri%20Owner%20Summary
      opts.add_argument("--disable-site-isolation-trials")
      opts.add_argument("--no-sandbox")
      opts.add_argument("--disable-dev-shm-usage")
    end

    Capybara::Selenium::Driver.new(app, **{ :browser => :chrome, options: browser_options })
  end
  @driver = :selenium_chrome_headless
else
  raise "Invalid Browser :("
end

# Configuração do Capybara.
Capybara.configure do |config|
  config.default_driver = @driver
  config.app_host = CONFIG["url"] # URL padrão
  config.default_max_wait_time = 10
end

AllureCucumber.configure do |config|
  config.results_directory = "/logs"
  config.clean_results_directory = true
end
