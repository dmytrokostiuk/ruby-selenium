module PageActions

  def initialize(browser)
    @browser = browser
  end

  def visit path = nil
    page = self.path
    page += path.first unless path.first.nil?
    new_url = URI::HTTP.build({:host => $base_url, :path => page})
    @browser.navigate.to new_url
  end

  def waitFor (seconds)
    Selenium::WebDriver::Wait.new(timeout: seconds).until { yield }
  end

  def switch_to frame
    @browser.switch_to.frame frame
  end

  def switch_to_default
    @browser.switch_to.default_content
  end

end