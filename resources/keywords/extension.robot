*** Settings ***
Resource    resources/settings/extension.robot


*** Keywords ***
# Setup & Teardown ####

OpenExtensionsOnChromeBrowser
    Log To Console    Opening Extensions on Chrome browser
    LaunchBrowser_Extensions    ${EXTENSIONS_PATH}
    Go To    ${EXTENSIONS_URL}

# ExtensionsPage ####

ExtensionsPage_Check_Title
    [Arguments]    ${expected_title}
    Log To Console    Checking title of Extensions page
    CompareTextOnElement    ${ExtensionsPage_Title}    ${expected_title}

# ExtensionsSideBar ####

ExtensionsSideBar_Transit_Shortcuts
    Log To Console    Transiting to Shortcuts page
    ClickOnElement    ${ExtensionsSideBar_Shortcuts}

# ShortcutCard ####

ShortcutCard_Check_Title
    [Arguments]    ${expected_title}
    Log To Console    Checking title of Shortcut Card
    CompareTextOnElement    ${ShortcutCard_Title}    ${expected_title}

ShortcutCard_Set_Keys
    [Arguments]    ${keys}
    Log To Console    Setting Shortcut keys
    ClickOnElement    ${ShortcutCard_Edit}
    PressKeysOnElement    ${ShortcutCard_Input}    ${keys}

ShortcutCard_Verify_Keys
    [Arguments]    ${keys}
    Log To Console    Verifying keys set successfully
    CompareAttributeValueOnElement    ${ShortcutCard_Input}    placeholder    ${keys}
