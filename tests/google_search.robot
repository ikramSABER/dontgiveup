*** Settings ***
Library           SeleniumLibrary

*** Variables ***
${BROWSER}        chrome
${URL}            https://www.google.com
${SEARCH_TERM}    OpenAI



*** Test Cases ***
Search Google
    [Documentation]    Open Google and search for a term, then verify results
    Open Browser    ${URL}    ${BROWSER}    remote_url=http://selenium-hub:4444/wd/hub
    Input Text      name=q    ${SEARCH_TERM}
    Press Keys      name=q    RETURN
    Wait Until Page Contains    ${SEARCH_TERM}    timeout=10s
    Capture Page Screenshot
    Close Browser
