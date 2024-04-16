*** Settings ***
Library    SeleniumLibrary
Library     DataDriver    ../TestData/Registration.xlsx    sheet_name=Sheet1
Library     String
Library     Collections
Library     OperatingSystem
Resource    ../Resource/test_suite.robot
Test Template    Successfull Login

*** Variables ***
${login_url}        xpath:/html/body/div[6]/div[1]/div[1]/div[2]/div[1]/ul/li[2]/a
${login_user}       id:Email
${login_password}   id:Password
${login_button}     xpath:/html/body/div[6]/div[3]/div/div/div/div[2]/div[1]/div[2]/form/div[3]/button
${login_page_heading}       xpath:/html/body/div[6]/div[3]/div/div/div/div[1]/h1
${returing_customer}        xpath:/html/body/div[6]/div[3]/div/div/div/div[2]/div[1]/div[2]/form/div[1]/strong
${email_label}      xpath:/html/body/div[6]/div[3]/div/div/div/div[2]/div[1]/div[2]/form/div[2]/div[1]/label
${password_label}       css:body > div.master-wrapper-page > div.master-wrapper-content > div > div > div > div.page-body > div.customer-blocks > div.returning-wrapper.fieldset > form > div.form-fields > div:nth-child(2) > label


*** Test Cases ***
Login for: ${firstname}

*** Keywords ***

Successfull Login
# Click on login click link
     Click Element    ${login_url}

# Verifing the lading the page
    ${landing_page_url} =    Get Location
    should contain    ${landing_page_url}    https://demo.nopcommerce.com/login?returnUrl=%2F

# Verifying login page elements
    ${login_h1} =   Get Text    ${login_page_heading}
    Should Contain      ${login_h1}         Welcome, Please Sign In!

    ${login_h2} =   Get Text    ${returing_customer}
    Should Contain      ${login_h2}         Returning Customer

    ${login_email_label} =  Get Text    ${email_label}
    Should Contain   ${login_email_label}   Email:

    ${login_pwd_label} =  Get Text    ${password_label}
    Should Contain   ${login_pwd_label}   Password:

# Login process
    [Arguments]    ${email}    ${pwd}    ${firstname}
    Input Text    ${login_user}     ${email}
    Input Password    ${login_password}     ${pwd}
    Click Element     ${login_button}
    Log    ${firstname}, your login is successful
    Sleep   5s