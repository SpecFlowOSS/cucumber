Feature: Sending TestCaseFinished Messages

    Scenario: Undefined test case result is included in the message
        Given there is a scenario
        And there are no matching step definitions
        When the test suite is executed
        Then a TestCaseFinished message has been sent with the following TestResult
            | Attribute | Value     |
            | status    | Undefined |
