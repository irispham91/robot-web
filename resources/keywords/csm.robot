*** Settings ***
Resource    resources/settings/csm.robot


*** Keywords ***
# Setup & Teardown ####

OpenCsmOnBrowser
    Log To Console    Opening Csm on browser
    LaunchBrowser_Downloads    ${DOWNLOADS_PATH}
    Go To    ${CSM_URL}

# LandingPage ####

LandingPage_Check_Logo
    [Arguments]    ${expected_title}
    Log To Console    Checking title of Landing page
    CompareTextOnElement    ${LandingPage_Title}    ${expected_title}

# Header ####

Header_Transit_NavigationMenu
    [Documentation]    Transit to different parts of website via navigation on header
    ...    Usage:
    ...    Header_Transit_Category    File Upload
    [Arguments]    ${menu}
    Log To Console    Navigating Menu: ${menu}
    ClickOnElement    ${Header_Navigation_Menu}    ${menu}

# FileUploadPage ####

FileUploadPage_Check_Title
    [Arguments]    ${expected_title}
    Log To Console    Checking title of File Upload page
    CompareTextOnElement    ${FileUploadPage_Title}    ${expected_title}

FileUploadPage_StartUpload
    Log To Console    Starting upload a file
    InputTextIntoElement    ${FileUploadPage_ChooseFile}    ${FILE_TO_UPLOAD}
    ClickOnElement    ${FileUploadPage_ReDownload}
    ClickOnElement    ${FileUploadPage_StartUpload}

# FileUploadFinishedPage ####

FileUploadFinishedPage_Check_Title
    [Arguments]    ${expected_title}
    Log To Console    Checking title of File Upload Finished page
    CompareTextOnElement    ${FileUploadFinishedPage_Title}    ${expected_title}

FileUploadFinishedPage_DownloadFile
    Log To Console    Downloading the file
    ClickOnElement    ${FileUploadFinishedPage_Download}
