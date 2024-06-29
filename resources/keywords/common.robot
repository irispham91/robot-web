*** Settings ***
Library     SeleniumLibrary
Library     OperatingSystem
Library     String
Library     DateTime
Library     Collections


*** Variables ***
${wait}                 15s
${retry}                2x
${retry_interval}       5s
${reloads}              5


*** Keywords ***
### BrowserSettings ###
BrowserSettings_Common
    [Documentation]    Init common options
    IF    '${BROWSER}'=='Chrome'
        ${options}    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys, selenium.webdriver
    ELSE IF    '${BROWSER}'=='Firefox'
        ${options}    Evaluate    sys.modules['selenium.webdriver'].FirefoxOptions()    sys, selenium.webdriver
    END
    Call method    ${options}    add_argument    --lang\=en
    Call method    ${options}    add_argument    --ignore-certificate-errors
    Call method    ${options}    add_argument    --allow-running-insecure-content
    Call method    ${options}    add_argument    --use-fake-device-for-media-stream
    Call method    ${options}    add_argument    --use-fake-ui-for-media-stream
    Call method    ${options}    add_argument    --dns-prefetch-disable
    Call method    ${options}    add_argument    --no-sandbox
    Call method    ${options}    add_argument    --disable-infobars
    Call method    ${options}    add_argument    --disable-dev-shm-usage
    Call method    ${options}    add_argument    --disable-browser-side-navigation
    Call method    ${options}    add_argument    --disable-gpu
    Call method    ${options}    add_argument    --mute-audio
    [Return]    ${options}    # robotidy: off

    # Call method    ${options}    add_argument    --use-file-for-fake-video-capture\=sample.y4m

BrowserSettings_HeadlessMode
    [Documentation]    Enable Headless mode in browser settings, run test in background with no browser displayed
    [Arguments]    ${options}
    Call method    ${options}    add_argument    --headless
    [Return]    ${options}    # robotidy: off

BrowserSettings_Proxy
    [Documentation]    Enable proxy server in browser settings, some URLs are only working behind the given proxy
    [Arguments]    ${options}    ${proxy_server}
    Call method    ${options}    add_argument    --proxy-server\=${proxy_server}
    [Return]    ${options}    # robotidy: off

BrowserSettings_ProxyBypass
    [Documentation]    Enable proxy bypass list in browser settings, open access restrictions to domains in the given list
    [Arguments]    ${options}    ${proxy_bypass_list}
    Call method    ${options}    add_argument    --proxy-bypass-list\=${proxy_bypass_list}
    [Return]    ${options}    # robotidy: off

BrowserSettings_Extensions
    [Documentation]    Load extension in browser settings, the given extension has been installed on browser already
    [Arguments]    ${options}    ${extension_path}
    Call method    ${options}    add_argument    --load-extension\=${extension_path}
    [Return]    ${options}    # robotidy: off

BrowserSettings_DefaultDownloadDirectory
    [Documentation]    Enable default download directory in browser settings, save the file downloaded to the given directory
    [Arguments]    ${options}    ${download_dir}
    ${prefs}    Create Dictionary    download.default_directory=${download_dir}
    Call method    ${options}    add_experimental_option    prefs    ${prefs}
    [Return]    ${options}    # robotidy: off

CreateDriver
    [Documentation]    Create driver
    [Arguments]    ${options}
    ${alias}    Get current date    result_format=%m%d%H%M%S
    IF    '${BROWSER}'=='Chrome'
        Create webdriver    Chrome    ${alias}    chrome_options=${options}
    ELSE IF    '${BROWSER}'=='Firefox'
        Create webdriver    Firefox    ${alias}    options=${options}    firefox_binary=${FF_BINARY}
    END
    [Return]    ${alias}    # robotidy: off

CreateDriver_pageLoadStrategy
    [Documentation]    Create Chrome driver with pageLoadStrategy
    [Arguments]    ${options}
    ${desired_caps}    Evaluate
    ...    sys.modules['selenium.webdriver'].DesiredCapabilities.CHROME
    ...    sys, selenium.webdriver
    Set To Dictionary    ${desired_caps}    pageLoadStrategy=eager
    ${alias}    Get current date    result_format=%m%d%H%M%S
    Create webdriver    Chrome    ${alias}    chrome_options=${options}    desired_capabilities=${desired_caps}
    [Return]    ${alias}    # robotidy: off

MaximizeWindow
    [Documentation]    Maximize Window
    Set Window Size    2000    2000
    Maximize Browser Window
    Delete All Cookies

### OpenBrowser with the specific options ###

LaunchBrowser
    [Documentation]    Launch browser depend on env_config.py
    ${options}    BrowserSettings_Common
    ${alias}    CreateDriver    ${options}
    MaximizeWindow
    CaptureScreenshot
    [Return]    ${alias}    # robotidy: off

LaunchBrowser_Extensions
    [Documentation]    Open browser with a specific extension
    [Arguments]    ${extensions_path}
    ${options}    BrowserSettings_Common
    ${options}    BrowserSettings_Extensions    ${options}    ${extensions_path}
    ${alias}    CreateDriver    ${options}
    MaximizeWindow
    CaptureScreenshot
    [Return]    ${alias}    # robotidy: off

LaunchBrowser_Downloads
    [Documentation]    Open browser with download enabled
    [Arguments]    ${downloads_path}
    ${options}    BrowserSettings_Common
    ${options}    BrowserSettings_DefaultDownloadDirectory    ${options}    ${downloads_path}
    ${alias}    CreateDriver    ${options}
    MaximizeWindow
    CaptureScreenshot
    [Return]    ${alias}    # robotidy: off

LaunchBrowser_Proxy
    [Documentation]    Open browser with localhost proxy
    [Arguments]    ${proxy}
    ${options}    BrowserSettings_Common
    ${options}    BrowserSettings_Proxy    ${options}    ${proxy}
    ${alias}    CreateDriver    ${options}
    MaximizeWindow
    CaptureScreenshot
    [Return]    ${alias}    # robotidy: off

LaunchBrowser_HeadlessMode
    [Documentation]    Open browser with headless mode
    ${options}    BrowserSettings_Common
    ${options}    BrowserSettings_HeadlessMode    ${options}
    ${alias}    CreateDriver    ${options}
    MaximizeWindow
    CaptureScreenshot
    [Return]    ${alias}    # robotidy: off

CloseCurrentBrowser
    Log To Console    Closing current browser
    Close Browser

### Web ###

CaptureScreenshot
    [Documentation]    Capture screenshot of the current web screen
    ${timestamp}    Get Current Date    result_format=%Y%m%d_%H%M%S%f
    Capture Page Screenshot    screenshots${/}${timestamp}.png

VerifyElementDisplayed
    [Documentation]    Verify element displayed on the current page and capture screenshot
    [Arguments]    ${locator}    ${timeout}=${wait}
    Wait Until Element Is Visible    ${locator}    ${timeout}
    Wait Until Element Is Enabled    ${locator}    ${timeout}
    Run Keyword And Ignore Error    Scroll Element Into View    ${locator}
    CaptureScreenshot

VerifyElementNotDisplayed
    [Documentation]    Verify element NOT displayed on the current page and capture screenshot
    [Arguments]    ${locator}    ${timeout}=${wait}
    CaptureScreenshot
    Wait Until Element Is Not Visible    ${locator}    ${timeout}

InputTextIntoElement
    [Documentation]    Wait for the element visible/enabled and input text on element
    [Arguments]    ${locator}    ${text}
    VerifyElementDisplayed    ${locator}
    Input Text    ${locator}    ${text}
    CaptureScreenshot

ClickOnElement
    [Documentation]    Wait for the element visible/enabled and click on element
    [Arguments]    ${locator}    ${placeholder}=${EMPTY}
    ${locator}    Set Variable    ${locator.replace('%%s','${placeholder}')}
    VerifyElementDisplayed    ${locator}
    Click Element    ${locator}
    CaptureScreenshot

ClickOnElementUntilSucceeds
    [Documentation]    Wait for the element visible/enabled and click on element twice
    [Arguments]    ${locator}    ${placeholder}=${EMPTY}
    ${locator}    Set Variable    ${locator.replace('%%s','${placeholder}')}
    VerifyElementDisplayed    ${locator}
    Wait Until Keyword Succeeds    ${retry}    ${retry_interval}    Click Element    ${locator}
    CaptureScreenshot

MouseOverElement
    [Documentation]    Wait for the element visible/enabled and mouse over on element
    [Arguments]    ${locator}    ${placeholder}=${EMPTY}    ${placeholder2}=${EMPTY}
    ${locator}    Set Variable    ${locator.replace('%%s','${placeholder}').replace('%%s2','${placeholder2}')}
    VerifyElementDisplayed    ${locator}
    Mouse Over    ${locator}
    CaptureScreenshot

GetTextOnElement
    [Documentation]    Wait for the element visible/enabled and get text on element
    [Arguments]    ${locator}
    VerifyElementDisplayed    ${locator}
    ${text_displayed}    Get Text    ${locator}
    CaptureScreenshot
    [Return]    ${text_displayed}    # robotidy: off

CompareTextOnElement
    [Documentation]    Compare text on element with given text
    [Arguments]    ${locator}    ${expected_text}
    ${text_displayed}    GetTextOnElement    ${locator}
    Run Keyword And Continue On Failure    Should Contain    ${text_displayed}    ${expected_text}

SelectOptionByLabel
    [Documentation]    Wait for the element visible/enabled and select option from list by label
    [Arguments]    ${locator}    ${label}
    VerifyElementDisplayed    ${locator}
    Select From List By Label    ${locator}    ${label}
    CaptureScreenshot

PressKeysOnElement
    [Documentation]    Wait for the element visible/enabled and press keys on element
    [Arguments]    ${locator}    ${keys}
    VerifyElementDisplayed    ${locator}
    Press Keys    ${locator}    ${keys}
    CaptureScreenshot

CompareAttributeValueOnElement
    [Documentation]    Compare value on element attribute with given value
    [Arguments]    ${locator}    ${attribute}    ${expected_value}
    ${value}    Get Element Attribute    ${locator}    ${attribute}
    Run Keyword And Continue On Failure    Should Contain    ${value}    ${expected_value}

ReloadPageUntilElementEnabled
    [Documentation]    Reload pages until see locator enabled
    [Arguments]    ${locator}
    FOR    ${idx}    IN RANGE    ${reloads}
        ${status}    Run Keyword And Return Status    Wait Until Element Is Enabled    ${locator}
        IF    '${status}'=='False'
            Reload Page
            Log To Console    Reload: ${idx}
        ELSE
            IF    '${status}'=='True'    BREAK
        END
    END
    IF    '${status}'=='False'
        Fail    The locator ${locator} is not enabled after reloading page ${reloads} times
    END
