if Rails.env.production?
  # Set Chrome binary path if specified in environment
  if ENV['CHROME_BIN']
    Selenium::WebDriver::Chrome.path = ENV['CHROME_BIN']
  end

  # Set specific ChromeDriver version that matches Chrome 120
  Webdrivers::Chromedriver.required_version = '120.0.6099.71'
end