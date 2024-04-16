*** Settings ***
Library    SeleniumLibrary
Test Template    Logout Process
Library     DataDriver    ../TestData/Registration.xlsx    sheet_name=Sheet1


*** Variables ***
${logout_link}      xpath:/html/body/div[6]/div[1]/div[1]/div[2]/div[1]/ul/li[2]/a

*** Test Cases ***
Logout for: ${firstname}

*** Keywords ***
Logout Process
    [Arguments]    ${firstname}
# Logout
    click element    ${logout_link}
    Log     ${firstname}, you logged out suucessfully

# verifing landing page after logout

    ${landing_page_url} =    Get Location
        should contain    ${landing_page_url}    https://demo.nopcommerce.com
        capture page screenshot
        Sleep    5s
