Feature: Sending TestCaseFinished Messages

    Scenario Outline: Ending test cases sends a message per test case

        Given there are <NumberOfScenarios> scenarios
        And all steps are bound and pass
        When the test suite is executed
        Then <NumberOfTestCaseFinishedMessages> TestCaseFinished messages have been sent

        Examples:
            | Case             | NumberOfScenarios | NumberOfTestCaseFinishedMessages |
            | empty test suite | 0                 | 0                                |
            | Single scenario  | 1                 | 1                                |
            | Two scenarios    | 2                 | 2                                |

    Scenario: Test case end time is included in the message

        Given there is a scenario
        And all steps are bound and pass
        When the scenario is finished at '2019-05-13 13:09:46'
        Then a TestCaseFinished message has been sent with the following attributes
            | Attribute | Value                 |
            | timestamp | '2019-05-13 13:09:46' |

    Scenario: Test case PickleId is included in the message

        Given there is a scenario with PickleId 'ff981b6f-b11e-4149-baa1-9794940ac8bf'
        And all steps are bound and pass
        When the scenario is executed
        Then a TestCaseFinished message has been sent with the following attributes
            | Attribute | Value                                |
            | pickleId  | ff981b6f-b11e-4149-baa1-9794940ac8bf |

    Scenario: Successful test case result is included in the message
        Given there is a scenario
        And all steps are bound and pass
        When the test suite is executed
        Then a TestCaseFinished message has been sent with the following TestResult
            | Attribute | Value  |
            | status    | Passed |

    Scenario: Failed test case result is included in the message
        Given there is a scenario
        And all steps are bound and fail
        When the test suite is executed
        Then a TestCaseFinished message has been sent with the following TestResult
            | Attribute | Value  |
            | status    | Failed |

    Scenario: Pending test case result is included in the message
        Given there is a scenario
        And all steps are bound and are pending
        When the test suite is executed
        Then a TestCaseFinished message has been sent with the following TestResult
            | Attribute | Value   |
            | status    | Pending |

    Scenario: Ambiguous test case result is included in the message
        Given there is a scenario
        And there are two step definitions with identical bindings
        When the test suite is executed
        Then a TestCaseFinished message has been sent with the following TestResult
            | Attribute | Value     |
            | status    | Ambiguous |

    Scenario: Undefined test case result is included in the message
        Given there is a scenario
        And there are no matching step definitions
        When the test suite is executed
        Then a TestCaseFinished message has been sent with the following TestResult
            | Attribute | Value     |
            | status    | Undefined |
