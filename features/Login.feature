@login @acceptance
Feature: Basic Authentication
  @wip
  Scenario: User with valid credentials can login
    Given I login with "admin" username and "admin" password
    Then I should see the "Congratulations! You must have the proper credentials." message