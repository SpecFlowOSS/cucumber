Feature: Sending TestRunStarted messages

  Scenario Outline: Starting test suite sends a message (independent of feature file exist)

    Given there are <NumberOfFeatureFiles> feature files
    When the test suite is executed
    Then a TestRunStarted message has been sent

    Examples:
      | Case                              | NumberOfFeatureFiles |
      | empty test suite                  | 0                    |
      | test suite contains feature files | 1                    |

  @SpecFlow
  Scenario: Parallel test runs can send multiple messages

    Given the test runner is 'SpecFlow+Runner'
    And there are '3' feature files
    When the test suite was executed with a testThreadCount of '3'
    Then '3' TestRunStarted messages have been sent

  Scenario: Test suite starting time is included in the message

    When the test suite is started at '2019-05-13 13:09:46'
    And the test suite was executed
    Then a TestRunStarted message has been sent with the following attributes
      | Attribute | Value               |
      | timestamp | 2019-05-13 13:09:46 |

  Scenario Outline: Cucumber implementation is included in message

    Given the cucumber implementation is <implementation>
    When the test suite is executed
    Then a TestRunStarted message has been sent with the following attributes
      | Attribute              | Value              |
      | cucumberImplementation | <ImplementationId> |

    @SpecFlow
    Examples:
      | implementation | ImplementationId |
      | SpecFlow       | SpecFlow         |
