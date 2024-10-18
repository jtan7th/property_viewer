require 'selenium-webdriver'
require 'open-uri'
require 'base64'

def scrape_images(url)
  options = Selenium::WebDriver::Chrome::Options.new
  options.add_argument('--headless')
  options.add_argument('--disable-gpu')
  options.add_argument('--no-sandbox')
  options.add_argument('--disable-dev-shm-usage')
  options.add_argument('user-agent=Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36')
  
  driver = Selenium::WebDriver.for :chrome, options: options
  wait = Selenium::WebDriver::Wait.new(timeout: 30)

  image_urls = []

  begin
    gallery_url = "#{url}/gallery/images/1"
    puts "Navigating to: #{gallery_url}"
    driver.navigate.to gallery_url

    puts "Waiting for gallery to load..."
    sleep(15)

    driver.execute_script("window.scrollTo(0, document.body.scrollHeight);")
    sleep(5)

    puts "Searching for image elements..."
    image_elements = wait.until { driver.find_elements(css: "img[src*='homes.co.nz']") }

    puts "Found #{image_elements.length} total image elements."

    image_elements.each_with_index do |img, index|
      img_url = img.attribute('src')
      
      if img_url.include?('fit') && img_url.include?('homes-listing-images')
        image_urls << img_url
        puts "Added image URL #{index + 1}: #{img_url}"
      else
        puts "Skipped image: #{img_url}"
      end
    end

    puts "Total image URLs collected: #{image_urls.length}"

  rescue => e
    puts "An error occurred: #{e.message}"
    puts e.backtrace
  ensure
    driver.quit
  end

  image_urls
end