if Rails.env.production?
  # Set Chrome binary path if specified in environment
  if ENV['CHROME_BIN']
    Selenium::WebDriver::Chrome.path = ENV['CHROME_BIN']
  end

  # Set specific ChromeDriver version
  Webdrivers::Chromedriver.required_version = ENV.fetch('CHROMEDRIVER_VERSION', '119.0.6045.105')
end