######################################################################################
# Header
# -----------------------------------------------------------------------------------
# - Test code : open_inquiry
# - Description : Scenario to open the AR Customer inquiry
# - Legislation :
# - JIRA ID : N/A
# - Created by : Thierry Vaidie
# - Created date - 2021-09-01
######################################################################################
# * Revision Log *
#-----------------------------------------------------------------------------------
# Rev    Issue Number    Date         User    Description
#-----------------------------------------------------------------------------------
# 001                    2021-09-03   TV      Expand script scope
# 000                    2021-09-01   TV      Initial version
######################################################################################

Feature: open_inquiry
    Scenario: YCP0102A-000 Login scenario
        Given the user is logged into Sage X3 with "param:loginType" using user name "param:loginUserName" and password "param:loginPassword"
        When the user selects the "param:endPointName1" entry on endpoint panel
        Then the "param:endPointName1" endpoint is selected

    Scenario: YCP0102A-001 Open Inquiry
        # Call Function by code
        Given the user opens the "YCPARINQ" function
        Then the "Customer Inquiry" screen is displayed
        # 001 s.n
        # And the user waits 2 seconds
        #
        # Set Header information
        Then the user selects the text field with name: "Customer"
        And the user writes "[USV_YCP_BPC_01]" to the selected text field
        Then the user selects the text field with name: "Site"
        And the user writes "[USV_YCP_FCY_01]" to the selected text field
        And the user waits 2 seconds
        # 001 e.n

        #Close the function
        Then the user clicks the Close page action icon on the header panel


    Scenario: YCP0102A-002 - Logout scenario
        Then the user logs-out from the system
