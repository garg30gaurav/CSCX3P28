######################################################################################
# Header
# -----------------------------------------------------------------------------------
# - Test code : customer inquiry flow
# - Description :
#       1) Create a sales invoice.
#       2) Check the sales invoice number on the AR Inquiry.
# - Legislation :
# - JIRA ID : N/A
# - Created by : Nirvashi Ramgutty
# - Created date - 2021-10-22
######################################################################################
# * Revision Log *
#-----------------------------------------------------------------------------------
# Rev    Issue Number    Date         User    Description
#-----------------------------------------------------------------------------------
# 000                    2021-10-22   NR      Initial version
######################################################################################

Feature: open_inquiry
    Scenario: YCP01-000 Login scenario
        Given the user is logged into Sage X3 with "param:loginType" using user name "param:loginUserName" and password "param:loginPassword"
        When the user selects the "param:endPointName1" entry on endpoint panel
        Then the "param:endPointName1" endpoint is selected

    Scenario: YCP01-001 Sales Invoice creation
        #Open Sales Invoice function
        Given the user opens the "GESSIH" function

        #Select sales Invoice transaction
        When the user selects the data table in the popup
        Then the user selects cell with text: "ALL Full entry invoice" and column header: ""
        #P26 - 1ALL Full entry invoice
        #P27 - ALL Full entry invoice
        And the user clicks on the selected cell

        Then the "Sales invoice ALL : Full entry invoice" screen is displayed
        #P26 - Sales invoice 1ALL : Full entry invoice
        #P27 - Sales invoice ALL : Full entry invoice

        #Entering in creation mode.
        When the user clicks the "New" main action button on the right panel

        #Set header information
        Then the user selects the text field with name: "Sales site"
        And the user writes "[USV_YCP_FCY_02]" to the selected text field
        And the user selects the date field with name: "Date"
        Then the user writes "[USV_YCP_DAT_01]" to the selected date field
        And the user selects the text field with name: "Bill-to customer"
        And the user writes "[USV_YCP_BPC_02]" to the selected text field
        And the user selects the text field with name: "Reference"
        And the user writes "[USV_YCP_REF_01]" to the selected text field


        When the user clicks the "Lines" tab selected by title

        #Set sales invoice lines information
        When the user selects the fixed data table of section: "Lines"
        Then the user selects last fixed cell with header: "Product"
        And the user adds the text "[USV_YCP_ITM_01]" in selected cell
        And the user selects last editable cell with column header: "Invoiced qty."
        And the user adds the text "[USV_YCP_QTY_01]" in selected cell

        #P27 Addition
        And the user selects last editable cell with column header: "Tax level 1"
        And the user adds the text "[USV_YCP_TAX_01]" in selected cell and hits tab key
        Then an alert box with the text "Recalculate prices/discounts?" appears
        Then the user clicks the "Yes" option in the alert box

        And the user hits enter

        #Create and post the sales Invoice.
        Then the user clicks the "Create" main action button on the right panel
        And the user clicks the "Post" button in the header
        And the user waits 20 seconds
        Then the user clicks the Close page action icon on the header panel
        And the user waits 20 seconds


        #Save the sales order reference in a stored value
        And the user selects the text field with name: "Invoice no."
        Then the user stores the value of the selected text field with the key: "ENV_ATPSINVNUM01"

        #Close the function
        Then the user clicks the Close page action icon on the header panel

    Scenario: YCP01-002 - Checking the AR inquiry if new invoice is picked up
        # Call Function by code
        Given the user opens the "YCPARINQ" function
        Then the "Customer Inquiry" screen is displayed

        # Set Header information
        And the user selects the text field with name: "Customer"
        And the user writes "[USV_YCP_BPC_02]" to the selected text field

        #Checkbox field: tick the checkbox and verifying the checkbox is checked
        Given the user selects the check box with name: "Invoice"
        When the user sets the check box to ticked
        Then the selected check box is checked

        Given the user selects the check box with name: "Credit Note"
        When the user sets the check box to unticked
        Then the selected check box is unchecked

        Given the user selects the check box with name: "Payment"
        When the user sets the check box to unticked
        Then the selected check box is unchecked

        Given the user selects the check box with name: "Others/Misc Item"
        When the user sets the check box to unticked
        Then the selected check box is unchecked

        And the user waits 2 seconds


        #Search the inquiry
        Then the user clicks the "Search" button in the header

        #Select Lines tab to enter line information
        When the user clicks the "Transactions" tab selected by title

        #Data table: select data table with X3 field name
        When the user selects the data table with x3 field name: "YCPARINQ1_ARRAY_NBLIG"
        Then the user sets rows to display to 50
        And the user selects row that has stored text with the key: "ENV_ATPSINVNUM01" in column with header: "Document number"
        And the user clicks on the selected row

        When the user selects the data table with x3 field name: "YCPARINQ1_ARRAY_NBINV"
        And the user selects cell with column header: "Product" and row number: 1
        And the user clicks on the selected cell
        Then the value of the selected cell is "[USV_YCP_ITM_01]"

        #Close the function
        Then the user clicks the Close page action icon on the header panel


    Scenario: YCP0102A-002 - Logout scenario
        Then the user logs-out from the system
