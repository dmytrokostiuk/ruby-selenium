require_relative '../pages/page_actions.rb'

Dir["../pages/*.rb"].each {|file| require_relative file}

driver_path = File.join(File.dirname(__FILE__), '..', '..','drivers', 'chromedriver')

$base_url = ENV['BASE'] || "the-internet.herokuapp.com"

Before '@wip' do
  skip_this_scenario
end

Before do |scenario|
  if SERVER == :local && BROWSER == :chrome
    @browser = Selenium::WebDriver.for :chrome, driver_path: driver_path
  end

  if SERVER == :remote
    capabilities_config = {
        :version => "#{ENV['version']}",
        :platform => "#{ENV['platform']}",
        :name => "#{scenario.feature.name} - #{scenario.name}"
    }

    capabilities = Selenium::WebDriver::Remote::Capabilities.send(ENV['browserName'].to_sym, capabilities_config)

    url = "https://#{ENV['SAUCE_USERNAME']}:#{ENV['SAUCE_ACCESS_KEY']}@ondemand.saucelabs.com:443/wd/hub".strip
    client = Selenium::WebDriver::Remote:Http::Default.new
    @browser = Selenium::WebDriver.for(:remote, :url => url, :desired_capabilities => capabilities, :http_client => client)
  end

  @basic_auth = BasicAuth.new @browser
  @dropdown = Dropdown.new @browser
  @checkboxes = Checkboxes.new @browser
  @dynamic_loading = DynamicLoading.new @browser
  @tinymce = Tinymce.new @browser
end

After do |scenario|
  # sessionid = @browser.send(:bridge).session_id
  # jobname = "#{scenario.feature.name} - #{scenario.name}"
  # @browser.quit

  if scenario.passed?
    puts "PASS"
    # SauceWhisk::Jobs.pass_job sessionid
  else
    puts "FAIL"
    # SauceWhisk::Jobs.fail_job sessionid
    screenshots_dir = File.join(File.dirname(__FILE__), "..", "..", "screenshots")
    unless File.directory? screenshots_dir
      FileUtils.mkdir screenshots_dir
    end
    time_stamp = Time.now.strftime("%Y-%m-%d_at_%H.%M.%S").to_s
    screenshot_name = "#{time_stamp}_failure_#{scenario.name.gsub(/[^\w`~!@#\$%&\(\)_\-\+=\[\]\{\};:',]/, '-')}.png"
    screenshots_file = File.join(screenshots_dir, screenshot_name)
    @browser.save_screenshot(screenshots_file)
    embed(screenshots_file, "image/png")
  end
  @browser.quit
end