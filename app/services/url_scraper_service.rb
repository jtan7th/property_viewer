require 'selenium-webdriver'
require 'uri'

class UrlScraperService
    def self.scrape_property_urls(base_url)
      new.scrape_property_urls(base_url)
    end
  
    def scrape_property_urls(base_url)
        options = Selenium::WebDriver::Chrome::Options.new
        options.add_argument('--disable-gpu')
        options.add_argument('--no-sandbox')
        # options.add_argument('--headless')
      
        driver = Selenium::WebDriver.for :chrome, options: options
        wait = Selenium::WebDriver::Wait.new(timeout: 15)
      
        property_urls = []
      
        begin
          driver.get(base_url)
          sleep(30)  # Initial wait for page to load
        
          begin # Wait for the property count element to be present
            wait.until { driver.find_element(xpath: "//div[contains(@class, 'propertyCnt ng-star-inserted')]") }
          
            begin
              # Try to find the child element first
              element = driver.find_element(xpath: "//div[contains(@class, 'propertyCnt ng-star-inserted')]/div[1]")
            rescue Selenium::WebDriver::Error::NoSuchElementError
              # If child element not found, use the parent element
              element = driver.find_element(xpath: "//div[contains(@class, 'propertyCnt ng-star-inserted')]")
            end

            # Extract the text content using JavaScript
            js_text = driver.execute_script("return arguments[0].textContent", element)
            
            # Parse the number from the text
            target_property_count = js_text.scan(/\d+/).first.to_i
          
            puts "Target property count: #{target_property_count}"
        
          rescue Selenium::WebDriver::Error::NoSuchElementError
            puts "Failed to find the element with the given XPath"
          end
      
      
          previous_property_count = 0
          no_change_count = 0
          max_no_change = 3  # Number of attempts with no change before giving up
      
          loop do
            # Scroll to the bottom
            # Instead of scrolling the window, we are scrolling the container. We also need to do a smooth scroll since otherwise it doesn't load more items
      
            driver.execute_script("
              document.querySelector('.drawerContentContainer')?.scrollTo({
              top: document.querySelector('.drawerContentContainer').scrollHeight,
              behavior: 'smooth'
              });
            ")
            sleep(15)  # Wait 5 seconds after each scroll
      
            # Count current properties
            # current_property_count = driver.find_elements(xpath: "//a[contains(@href, 'address/christchurch/sumner')]").size
            current_property_count = driver.find_elements(css: "a.detailsLink").size
            puts "Loaded #{current_property_count} properties..."
      
            if current_property_count >= target_property_count
              puts "Target property count reached."
              break
            end
      
            if current_property_count == previous_property_count
              no_change_count += 1
              puts "No new properties loaded. Attempt #{no_change_count} of #{max_no_change}"
              if no_change_count >= max_no_change
                puts "No new properties after #{max_no_change} attempts. Stopping."
                break
              end
            else
              no_change_count = 0  # Reset if we've loaded new properties
            end
      
            previous_property_count = current_property_count
          end
      
          # Find all <a> tags with href containing "address/christchurch/sumner"
          #links = driver.find_elements(xpath: "//a[contains(@href, 'address/christchurch/sumner')]")
          links = driver.find_elements(css: "a.detailsLink")
          hrefs= links.map { |link| link.attribute('href') }
          #puts "Links count", links.count
          # Extract and process the URLs
          property_urls = links.map do |link|
            href = link.attribute('href')
            uri = URI.parse(href)
            path = uri.path
            "https://www.homes.co.nz#{path}"
          end
          #puts ({hrefs:hrefs, property_urls: property_urls, unique_property_urls: property_urls.uniq}).to_json
          property_urls.uniq
        ensure
          driver.quit
        end
      
        property_urls
    end
  end
