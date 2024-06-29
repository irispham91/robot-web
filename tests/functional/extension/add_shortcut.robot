*** Settings ***
Documentation       Test suites to verify that shortcut key in Chrome Extension is set correctly
...                 You need to install EditThisCookie extension on Chrome &
...                 set EXTENSIONS_PATH correctly in data_variables/env_config.py
...                 See https://chromewebstore.google.com/detail/editthiscookie/fngmhnnpilhplaeedifhccceomclgfbg
...                 Note: Shadow DOM is existing in Chrome Extension page

# Often a good idea to add overall documentation to test suite files.
# Should contain background information, why tests are created, notes about execution environment, etc.
Resource            resources/settings/extension.robot

Suite Setup         Run Keywords    Set Log Level    TRACE    AND    OpenExtensionsOnChromeBrowser
Test Teardown       CloseCurrentBrowser


*** Test Cases ***
Shortcut key is set successfully
    [Tags]    web    extensions
    ExtensionsPage_Check_Title    Extensions
    ExtensionsSideBar_Transit_Shortcuts
    ShortcutCard_Check_Title    EditThisCookie
    ShortcutCard_Set_Keys    CTRL+0
    ShortcutCard_Verify_Keys    Ctrl + 0
