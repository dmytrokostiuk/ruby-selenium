@frames
Feature: Frames

  Once the page loads we switch into the frame that contains TinyMCE and...

  grab the original text and store it
  clear and input new text
  grab the new text value
  assert that the original and new texts are not the same


  Scenario: working with a WYSIWYG Editor
    Given I navigate to "tinymce" page
    When I switch to "mce_0_ifr" frame
    Then I type "Hello World!" into WYSIWYG Editor
    And new text should not equal old one
    Then I return to default frame