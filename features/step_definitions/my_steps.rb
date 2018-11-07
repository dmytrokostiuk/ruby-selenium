When("I login with {string} username and {string} password") do |username, password|
  @basic_auth.with(username, password)
end

Then("I should see the {string} message") do |message|
  expect(@basic_auth.success_message.text).to eq(message)
end

Given(/^I navigate to "([^"]*)" page(?: "([^"]*)")?$/) do |page, *path|
  instance_variable_get("@#{page}").visit path
end

When("I select {string} from dropdown") do |option|
  @dropdown.select option
end

Then("I would see the {string} selected") do |expected_selected_option|
  actual_selected_option = @dropdown.selected_option
  expect(actual_selected_option).to eq expected_selected_option
end

Then(/^I check if (\d*)(?:st|nd|rd|th) box is selected$/) do |index|
  expect(@checkboxes.is_checked? index).to eql true
end

When(/^I click on start button$/) do
  @dynamic_loading.start_button.click
end

Then(/^"([^"]*)" message is displayed$/) do |message|
  @dynamic_loading.success_message_displayed?
  expect(@dynamic_loading.finish_element.text).to eql(message)
end