require 'selenium-webdriver'

class PriceScraperService
  def self.update_price(property)
    new.update_price(property)
  end

  def update_price(property)
    options = Selenium::WebDriver::Chrome::Options.new
    options.add_argument('--disable-gpu')
    options.add_argument('--no-sandbox')
    options.add_argument('--headless')

    driver = Selenium::WebDriver.for :chrome, options: options

    begin
      driver.navigate.to property.url

      wait = Selenium::WebDriver::Wait.new(timeout: 10)

      # Update only the sale price
      new_sale_price = parse_price(safe_find_element(driver, wait, 'div.price_tag'))
      property.sale_price = new_sale_price if new_sale_price

      property
    ensure
      driver.quit
    end
  end

  private

  def safe_find_element(driver, wait, selector, method = :css)
    wait.until { driver.find_element(method, selector) }.text.strip
  rescue
    nil
  end

  def parse_price(price_string)
    return nil if price_string.nil? || price_string.empty? || price_string.strip.downcase == 'tbc'
    
    cleaned = price_string.gsub(/[$,]/, '').downcase
    
    if cleaned =~ /^(\d+(?:\.\d+)?)(k|m)?$/
      number = $1.to_f
      multiplier = $2
      
      result = case multiplier
      when 'k'
        number * 1_000
      when 'm'
        number * 1_000_000
      else
        number
      end
      
      result.round
    else
      nil
    end
  end
end
