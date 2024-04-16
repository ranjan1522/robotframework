*** Settings ***
Documentation    To validate the Registration Form
Test Template    Registration form filling
Library           SeleniumLibrary
Library     DataDriver    ../TestData/Registration.xlsx    sheet_name=Sheet1
Library     String
Library     Collections
Library     OperatingSystem
Resource    ../Resource/test_suite.robot
Suite Setup    Launch Browser


*** Variables ***
${URL}            https://demo.nopcommerce.com/
${BROWSER}        Chrome
${register_button}  xpath:/html/body/div[6]/div[1]/div[1]/div[2]/div[1]/ul/li[1]/a
${male_button}      id:gender-male
${female_button}    id:gender-female
${first_name_locator}       xpath://*[@id="FirstName"]
${last_name_locator}        xpath://*[@id="LastName"]
${email_field}      xpath://*[@id="Email"]
${dob_drop_down}      xpath:/html/body/div[6]/div[3]/div/div/div/div[2]/form/div[1]/div[2]/div[4]/div/select[1]
${mnth_drop_down}     xpath:/html/body/div[6]/div[3]/div/div/div/div[2]/form/div[1]/div[2]/div[4]/div/select[2]
${year_drop_down}     xpath:/html/body/div[6]/div[3]/div/div/div/div[2]/form/div[1]/div[2]/div[4]/div/select[3]
${password}            id:Password
${confirm_password}     id:ConfirmPassword
${company_name}     id:Company
${newsletter}       xpath://*[@id="Newsletter"]
${registration_page_url}    https://demo.nopcommerce.com/register?returnUrl=%2F
${register_heading}    xpath:/html/body/div[6]/div[3]/div/div/div/div[1]/h1
${personal_detail_heading}  xpath:/html/body/div[6]/div[3]/div/div/div/div[2]/form/div[1]/div[1]/strong
${gender_label}     xpath:/html/body/div[6]/div[3]/div/div/div/div[2]/form/div[1]/div[2]/div[1]/label
${firstname_label}      xpath:/html/body/div[6]/div[3]/div/div/div/div[2]/form/div[1]/div[2]/div[2]/label
${lastname_label}       xpath:/html/body/div[6]/div[3]/div/div/div/div[2]/form/div[1]/div[2]/div[3]/label
${dob_label}        xpath:/html/body/div[6]/div[3]/div/div/div/div[2]/form/div[1]/div[2]/div[4]/label
${email_label}      xpath:/html/body/div[6]/div[3]/div/div/div/div[2]/form/div[1]/div[2]/div[5]/label
${cmpnyname_heading}        xpath:/html/body/div[6]/div[3]/div/div/div/div[2]/form/div[2]/div[1]/strong
${companyname_label}    xpath:/html/body/div[6]/div[3]/div/div/div/div[2]/form/div[2]/div[2]/div/label
${option_heading}         css:body > div.master-wrapper-page > div.master-wrapper-content > div > div > div > div.page-body > form > div:nth-child(3) > div.title > strong
${option_label}         xpath:/html/body/div[6]/div[3]/div/div/div/div[2]/form/div[3]/div[2]/div/label
${password_heading}         css:body > div.master-wrapper-page > div.master-wrapper-content > div > div > div > div.page-body > form > div:nth-child(4) > div.title > strong
${password_label}       css:body > div.master-wrapper-page > div.master-wrapper-content > div > div > div > div.page-body > form > div:nth-child(4) > div.form-fields > div:nth-child(1) > label
${cnf_password_label}     css:body > div.master-wrapper-page > div.master-wrapper-content
${Reg_Button}      id:register-button
${Success_Message}      xpath:/html/body/div[6]/div[3]/div/div/div/div[2]/div[1]
${continue_button}      xpath:/html/body/div[6]/div[3]/div/div/div/div[2]/div[2]/a

*** Test Cases ***
Registration Test Cases with positive datasets:${firstname};${lastname};${date};${month};${year};${email};${company_nm};${pwd};${confirm_pwd};${gender}

*** Keywords ***
Registration form filling
    [Arguments]     ${firstname}	${lastname}	    ${date}	    ${month}	${year}	    ${email}	${company_nm}	    ${pwd}	    ${confirm_pwd}   ${gender}

# Click on register button
    ${register_button_text} =   get text    ${register_button}
    should contain    ${register_button_text}   Register
    click link    ${register_button}

# Verifing the lading the page
    ${landing_page_url} =    Get Location
    should contain    ${landing_page_url}    ${registration_page_url}
    ${register_title} =     get text    ${register_heading}
    should contain    ${register_title}     Register
    ${personal_detail} =     get text    ${personal_detail_heading}
    should contain    ${personal_detail}     Your Personal Details

# Verify gender heading
    ${gender_heading} =     get text    ${gender_label}
    should contain    ${gender_heading}     Gender:

# Click on male radio button

    Wait Until Element Is Visible    ${male_button}    timeout=10s
    Wait Until Element Is Visible    ${female_button}    timeout=10s
    IF    '${gender}' == 'M'
    Click Element    ${male_button}
    ELSE
    Click Element    ${female_button}
    END

# Verify First, Last Name labels
    ${firstname_heading} =     get text    ${firstname_label}
    should contain    ${firstname_heading}     First name:

    ${lastname_heading} =     get text    ${lastname_label}
    should contain    ${lastname_heading}     Last name:

# Entering first and last name
    input text    ${first_name_locator}        ${firstname}
    input text    ${last_name_locator}         ${lastname}

# Scrolling till email id
    scroll element into view    ${email_field}

# Verify dob section
    ${dob_heading} =     get text    ${dob_label}
    should contain    ${dob_heading}     Date of birth:

# Selecting drop down for DOB

    Select From List by Label   ${dob_drop_down}       ${date}
    Select From List by Label   ${mnth_drop_down}      ${month}
    Select From List by Label   ${year_drop_down}      ${year}

# Verify email section heading
    ${email_heading} =     get text    ${email_label}
    should contain    ${email_heading}     Email:

# Entering email id
    input text    ${email_field}        ${email}

# Verify company section heading
    ${company_heading} =     get text    ${cmpnyname_heading}
    should contain    ${company_heading}     Company Details

    ${company_sub_heading} =     get text    ${companyname_label}
    should contain    ${company_sub_heading}     Company name:

# Entering the company name

    input text     ${company_name}       ${company_nm}

# Verify newsletter section heading
    ${newsletter_heading} =     get text    ${option_heading}
    should contain    ${newsletter_heading}     Options

    ${newsletter_sub_heading} =     get text    ${option_label}
    should contain    ${newsletter_sub_heading}     Newsletter:

# Checking newsletter should be checked
    checkbox should be selected    ${newsletter}

# Srolling till confirm input password
    scroll element into view    ${confirm_password}

# Verify password section heading
    ${password_heading} =     get text    ${password_heading}
    should contain    ${password_heading}     Your Password

    ${pwd_label} =     get text    ${password_label}
    should contain    ${pwd_label}     Password:

    ${cnf_pwd_label} =     get text    ${cnf_password_label}
    should contain    ${cnf_pwd_label}     Confirm password:

# Entering password and confirm password

    input password    ${password}       ${pwd}
    input password    ${confirm_password}   ${confirm_pwd}

# Scrolling to bottom of the page
    wait until element is visible    ${Reg_Button}    timeout=10s
    ${element} =    Get WebElement    ${Reg_Button}
    scroll element into view    ${Reg_Button}


# Completing Registration
    click element    ${Reg_Button}
    ${message} =    get text    ${Success_Message}
    should contain    ${message}        Your registration completed
    click element    ${continue_button}
    ${completion_url} =    get location
    should contain    ${completion_url}     https://demo.nopcommerce.com/
    Log         ${firstname}, Hurry...!!! Your Registration Done
    sleep    5s