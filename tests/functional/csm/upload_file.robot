*** Settings ***
Documentation       Test suites to verify that file upload & download can be done correctly
...                 See http://internal.example.com/docs/abs.pdf

# Often a good idea to add overall documentation to test suite files.
# Should contain background information, why tests are created, notes about execution environment, etc.
Resource            resources/settings/csm.robot

Suite Setup         Run Keywords    Set Log Level    TRACE    AND    OpenCsmOnBrowser
Suite Teardown      CloseCurrentBrowser


*** Test Cases ***
Upload and download a file successfully
    [Tags]    regression    web    upload
    LandingPage_Check_Logo    Introduction
    Header_Transit_NavigationMenu    File Upload
    FileUploadPage_Check_Title    File Upload
    FileUploadPage_StartUpload
    FileUploadFinishedPage_Check_Title    File Upload Finished
    FileUploadFinishedPage_DownloadFile
