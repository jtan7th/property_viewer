if Rails.env.production?
  # Set Chrome binary path if specified in environment
  if ENV['CHROME_BIN']
    Selenium::WebDriver::Chrome.path = ENV['CHROME_BIN']
  end

  # Let Webdrivers detect the Chrome version automatically
  Webdrivers::Chromedriver.required_version = nil
end