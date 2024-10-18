require 'selenium-webdriver'
require_relative 'image_scraper_service'

class SeleniumScraperService
    def self.scrape(url)
      new.scraper(url) 
    end
  
    def scraper(url)
        options = Selenium::WebDriver::Chrome::Options.new
        options.add_argument('--disable-gpu')
        options.add_argument('--no-sandbox')
        options.add_argument('--headless')  # Run in headless mode
      
        driver = Selenium::WebDriver.for :chrome, options: options
      
        property_data = {}
      
        begin
          driver.navigate.to url
      
          # Explicit wait for up to 10 seconds
          wait = Selenium::WebDriver::Wait.new(timeout: 10)
      
          # Click the "See more records" link
          see_more_records_link = driver.find_element(css: "a.homes-link")
          see_more_records_link.click
      
          sleep(10)
          
          # Helper method to safely find first set of elements
          def safe_find_element(driver, wait, selector, method = :css)
            wait.until { driver.find_element(method, selector) }.text.strip
          rescue
            nil
          end
      
          # Helper to find estimate range
          def safe_find_estimate_range(driver, wait)
            wait.until {
              estimate_range_h4 = driver.find_element(:xpath, "//h4[text()='Estimate range']")
              range_div = estimate_range_h4.find_element(:xpath, "./following-sibling::div[contains(@class, 'estimate_range_price')]")
              price_spans = range_div.find_elements(:xpath, ".//span[contains(@class, 'display_price')]")
              if price_spans.length >= 2
                [price_spans[0].text, price_spans[1].text]
              else
                raise "Not enough price spans found"
              end
            }
          rescue => e
            puts "Error finding estimate range: #{e.message}"
            [nil, nil]
          end
      
          # Helper method to find elements by XPath containing text (second set that after see more records)
          def safe_find_element_by_text(driver, wait, text)
            elements = wait.until { driver.find_elements(:xpath, "//*[contains(text(), '#{text}')]") }
            elements.each do |element|
              sibling = element.find_element(:xpath, "./following-sibling::*")
              return sibling.text.strip if sibling
            end
            nil
          rescue
            nil
          end
      
          def click_capital_valuation_tab(driver, wait)
            wait.until {
              tab = driver.find_element(:xpath, "//div[contains(@id, 'mat-tab-label-0-2')]")
              driver.execute_script("arguments[0].scrollIntoView(true);", tab)
              sleep 3  # Give the page a moment to settle after scrolling
              driver.execute_script("arguments[0].click();", tab)
              sleep 8
              true
            }
          rescue => e
            puts "Error clicking Capital Valuation tab: #{e.message}"
            false
          end
      
          # Helper method to convert price string to integer, accounting for 'k' and 'm', and handling 'TBC'
          def parse_price(price_string)
            return nil if price_string.nil? || price_string.empty? || price_string.strip.downcase == 'tbc'
            
            # Remove dollar sign and commas, convert to lowercase
            cleaned = price_string.gsub(/[$,]/, '').downcase
            
            # Extract the numeric part and the multiplier (if any)
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
              
              result.round  # Round to nearest integer
            else
              nil # Return nil if the string doesn't match the expected format
            end
          end
      
          # Helper method to convert area string to integer
          def parse_area(area_string)
            return nil if area_string.nil? || area_string.empty?
            
            # Remove all non-numeric characters except decimal point
            cleaned = area_string.gsub(/[^\d.]/, '')
            
            # Convert to float, round to integer, otherwise return nil
            cleaned.empty? ? nil : cleaned.to_f.round
          end
      
          # Helper method to convert string to integer, removing non-numeric characters
          def to_integer(string)
            string.to_s.gsub(/[^\d]/, '').to_i
          end
      
          # Helper method to convert string to float, removing non-numeric characters except decimal point
          def to_float(string)
            string.to_s.gsub(/[^\d.]/, '').to_f
          end
      
          # Collect property data
          estimate_range = safe_find_estimate_range(driver, wait)
          
          def extract_suburb_from_address(address)
            # Split the address by commas and get the second-to-last element
            parts = address.split(',')
            parts[-2]&.strip
          end
          
          property_data = {
            url: url,
            sale_price: parse_price(safe_find_element(driver, wait, 'div.price_tag')),
            address: safe_find_element(driver, wait, 'h1.summary_address'),
            sold_date: safe_find_element_by_text(driver, wait, 'Sold:'),
            homes_estimate_date: safe_find_element(driver, wait, 'h3.date')&.sub(/^HomesEstimate:\s*/, ''),
            homes_estimate_price: parse_price(safe_find_element(driver, wait, 'span.display_price.large')),
            homes_estimate_range_low: parse_price(estimate_range[0]),
            homes_estimate_range_high: parse_price(estimate_range[1]),
            bedroom_count: to_integer(safe_find_element(driver, wait, "//img[contains(@src, 'Bedrooms.svg')]/following::div[contains(@class, 'detail_value')]", :xpath)),
            bathroom_count: to_integer(safe_find_element(driver, wait, "//img[contains(@src, 'Bathrooms.svg')]/following::div[contains(@class, 'detail_value')]", :xpath)),
            carpark_spaces_count: to_integer(safe_find_element(driver, wait, "//img[contains(@src, 'Car-spaces.svg')]/following::div[contains(@class, 'detail_value')]", :xpath)),
            floor_area: parse_area(safe_find_element(driver, wait, "//img[contains(@src, 'Floor-area.svg')]/following::div[contains(@class, 'detail_value')]", :xpath)),
            land_area: parse_area(safe_find_element(driver, wait, "//img[contains(@src, 'Land-area.svg')]/following::div[contains(@class, 'detail_value')]", :xpath)),
            deck: safe_find_element_by_text(driver, wait, 'Deck'),
            property_contour: safe_find_element_by_text(driver, wait, 'Property contour'),
            view_type: safe_find_element_by_text(driver, wait, 'View type'),
            decade_built: safe_find_element_by_text(driver, wait, 'Decade built'),
            view_living_area: safe_find_element_by_text(driver, wait, 'View: living area'),
            condition: safe_find_element_by_text(driver, wait, 'Condition')
          }
      
          # Extract suburb from address after the property_data hash is created
          property_data[:suburb] = extract_suburb_from_address(property_data[:address])
      
          if click_capital_valuation_tab(driver, wait)
            sleep 8  # Add a short wait to allow content to load
            
            # Add Capital Valuation data directly to property_data
            property_data[:capital_valuation] = parse_price(safe_find_element(driver, wait, "homes-price-tag-simple.capital-value"))
            property_data[:capital_valuation_date] = safe_find_element(driver, wait, "//homes-council-rates-tab//h3[contains(text(), 'Capital Valuation:')]", :xpath)&.split("\n")&.last&.strip&.sub(/^Capital Valuation:\s*/, '')
            property_data[:land_value] = parse_price(safe_find_element(driver, wait, "h4.valueLabel + h2.valueAmount"))
            property_data[:improvement_value] = parse_price(safe_find_element(driver, wait, "h4.valueLabel:nth-of-type(2) + h2.valueAmount"))
          end
      
          # Add this line to scrape images
          property_data[:image_urls] = scrape_images(url)
      
          # Output the collected data
          property_data.each do |key, value|
            puts "#{key.to_s.capitalize.gsub('_', ' ')}: #{value}"
          end
      
        ensure
          driver.quit
        end
      
        property_data  # Return property_data at the end of the method
    end
end
