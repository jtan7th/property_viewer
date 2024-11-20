if ENV['CHROME_BIN']
    Selenium::WebDriver::Chrome.path = ENV['CHROME_BIN']
  end