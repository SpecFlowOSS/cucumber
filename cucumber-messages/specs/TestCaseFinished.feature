Feature: Sending TestCaseFinished Messages

    Scenario: Ambiguous test case result is included in the message
        Given there is a scenario
        And there are two step definitions with identical bindings
        When the test suite is executed
        Then a TestCaseFinished message has been sent with the following TestResult
            | Attribute | Value     |
            | status    | Ambiguous |
