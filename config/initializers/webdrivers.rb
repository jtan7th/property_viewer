if Rails.env.production?
  Selenium::WebDriver::Chrome.path = ENV.fetch('CHROME_BIN', nil)
  Selenium::WebDriver::Chrome::Service.driver_path = ENV.fetch('CHROME_DRIVER_PATH', nil)
  
  Selenium::WebDriver::Chrome::Options.new.tap do |opts|
    opts.add_argument('--headless')
    opts.add_argument('--no-sandbox')
    opts.add_argument('--disable-dev-shm-usage')
    opts.add_argument('--disable-gpu')
    opts.binary = ENV.fetch('CHROME_BIN')
  end
end