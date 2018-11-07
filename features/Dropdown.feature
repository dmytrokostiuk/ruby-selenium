@dropdown @acceptance
Feature: Selecting from Dropdown

  Scenario Outline: Select Option 1 from dropdown
    Given I navigate to "dropdown" page
    And I select "<option>" from dropdown
    Then I would see the "<option>" selected

  Examples: options from dropdown menu
    |    option    |
    |   Option 1   |
    |   Option 2   |