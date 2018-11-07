class DynamicLoading
  include PageActions

  START_BUTTON = {css: '#start button'}
  FINISH_ELEMENT = {css: '#finish'}

  def path
    "/dynamic_loading"
  end

  def start_button
    @browser.find_element(START_BUTTON)
  end

  def finish_element
    @browser.find_element(FINISH_ELEMENT)
  end

  def success_message_displayed?
    waitFor(10){finish_element.displayed?}
  end

end