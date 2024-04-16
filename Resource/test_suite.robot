*** Settings ***
Library         SeleniumLibrary
Library    SeleniumLibrary

*** Variables ***
${url}      https://demo.nopcommerce.com/
${browser}      Chrome
*** Keywords ***
Launch Browser
    Open Browser        ${url}      ${browser}
    maximize browser window

Close Browser
    close all browsers
