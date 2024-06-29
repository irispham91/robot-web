*** Variables ***
# Common
${Header_Navigation_Menu}               xpath=//a[text()="%%s"]

# LandingPage
${LandingPage_Title}                    xpath=//h1[1]

# FileUploadPage
${FileUploadPage_Title}                 xpath=(//h1)[1]
${FileUploadPage_ChooseFile}            xpath=(//input[@name="file_upload"])[2]
${FileUploadPage_ReDownload}            xpath=(//input[@name="redown"])[2]
${FileUploadPage_StartUpload}           xpath=(//input[@id="button"])[2]

# FileUploadFinishedPage
${FileUploadFinishedPage_Title}         xpath=(//h1)[1]
${FileUploadFinishedPage_Download}      xpath=//a[text()="Download at own risk"]
