*** Settings ***
Resource    resources/settings/luma.robot


*** Keywords ***
# Setup & Teardown ####

OpenLumaOnBrowser
    Log To Console    Opening Luma on browser
    # LaunchBrowser
    LaunchBrowser_HeadlessMode
    Go To    ${LUMA_URL}

UpdateStatusCsv
    Log To Console    Updating status in CSV file
    Run Keyword If Test Passed    update_status_in_customer    ${Email}    PASSED

ReloadLuma
    Log To Console    Reloading Luma
    Delete All Cookies
    Go To    ${LUMA_URL}
    Reload Page

# Common ####

Common_Wait_Loader
    VerifyElementNotDisplayed    ${Loader}

# LandingPage ####

LandingPage_Check_Logo
    Log To Console    Checking logo of Landing page
    VerifyElementDisplayed    ${LandingPage_Logo}

# Header ####

Header_Transit_NavigationMenu
    [Documentation]    Transit to different parts of website via navigation on header
    ...    Usage:
    ...    Header_Transit_Category    menu=Women    submenu=Tops    submenu2=Jackets
    ...    Header_Transit_Category    menu=Gear    submenu=Bags
    ...    Header_Transit_Category    menu=Sale
    [Arguments]    ${menu}=${EMPTY}    ${submenu}=${EMPTY}    ${submenu2}=${EMPTY}
    Log To Console    Transiting category on header
    IF    '${menu}'=='${EMPTY}'
        Log To Console    Menu is EMPTY
    ELSE
        Log To Console    Navigating Menu: ${menu}
        MouseOverElement    ${Header_Navigation_Menu}    ${menu}
    END
    IF    '${submenu}'=='${EMPTY}'
        Log To Console    SubMenu is EMPTY
    ELSE IF    '${submenu2}'=='${EMPTY}'
        Log To Console    Navigating SubMenu: ${submenu}
        ClickOnElement    ${Header_Navigation_SubMenu}    ${submenu}
    ELSE
        Log To Console    Navigating SubMenu: ${submenu}
        MouseOverElement    ${Header_Navigation_SubMenu}    ${submenu}
        IF    '${submenu2}'=='${EMPTY}'
            Log To Console    SubMenu2 is EMPTY
        ELSE
            Log To Console    Navigating Submenu2: ${submenu2}
            ClickOnElement    ${Header_Navigation_SubMenu2}    ${submenu2}
        END
    END

Header_Transit_CartPage
    Common_Wait_Loader
    ClickOnElement    ${Header_Cart}

# ProductListPage ####

ProductListPage_Check_Title
    [Arguments]    ${expected_title}
    Log To Console    Checking title of Product List page
    CompareTextOnElement    ${ProductListPage_Title}    ${expected_title}

ProductListPage_Transit_ProductDetailsPage
    Log To Console    Transiting to Product Details page
    MouseOverElement    ${ProductListPage_FirstProduct}
    ClickOnElement    ${ProductListPage_FirstProduct_AddToCart}

# ProductDetailsPage ####

ProductDetailsPage_Check_Title
    [Arguments]    ${expected_title}
    Log To Console    Checking title of Product Details page
    CompareTextOnElement    ${ProductDetailsPage_Title}    ${expected_title}

ProductDetailsPage_AddToCart_WithInfo
    [Arguments]    ${size}=${EMPTY}    ${color}=${EMPTY}    ${qty}=${EMPTY}
    Log To Console    Adding the product to cart
    IF    '${size}'=='${EMPTY}'
        Log To Console    Size is EMPTY
    ELSE
        Log To Console    Size: ${size}
        ClickOnElement    ${ProductDetailsPage_Size}    ${size}
    END
    IF    '${color}'=='${EMPTY}'
        Log To Console    Color is EMPTY
    ELSE
        Log To Console    Color: ${color}
        ClickOnElement    ${ProductDetailsPage_Color}    ${color}
    END
    IF    '${qty}'=='${EMPTY}'
        Log To Console    Qty is EMPTY
    ELSE
        Log To Console    Qty: ${qty}
        InputTextIntoElement    ${ProductDetailsPage_Qty}    ${qty}
    END
    ClickOnElement    ${ProductDetailsPage_AddToCart}

# MiniCartPopup ####

MiniCartPopup_Check_Title
    Log To Console    Checking Mini Cart popup displayed
    VerifyElementDisplayed    ${MiniCartPopup_Title}

MiniCartPopup_ProceedToCheckout
    Log To Console    Clicking Proceed To Checkout on popup
    ClickOnElement    ${MiniCartPopup_ProceedToCheckout}

# CheckoutShippingPage ####

CheckoutShippingPage_Check_Title
    [Arguments]    ${expected_title}
    Log To Console    Checking title of Checkout Shipping page
    CompareTextOnElement    ${CheckoutShippingPage_Title}    ${expected_title}

CheckoutShippingPage_Fill_RequiredInfo
    Log To Console    Filling required info to the form
    # Get data from input file
    ${Customer_DAO}    get_customer_from_csv    ${CUSTOMER_INPUT}
    ${Email}    Set Variable    ${Customer_DAO.Email}
    ${FirstName}    Set Variable    ${Customer_DAO.FirstName}
    ${LastName}    Set Variable    ${Customer_DAO.LastName}
    ${Company}    Set Variable    ${Customer_DAO.Company}
    ${StreetAddress}    Set Variable    ${Customer_DAO.StreetAddress}
    ${City}    Set Variable    ${Customer_DAO.City}
    ${State}    Set Variable    ${Customer_DAO.State}
    ${ZipCode}    Set Variable    ${Customer_DAO.ZipCode}
    ${Country}    Set Variable    ${Customer_DAO.Country}
    ${Phone}    Set Variable    ${Customer_DAO.Phone}
    Set Test Variable    ${Email}
    InputTextIntoElement    ${CheckoutShippingPage_Email}    ${Email}
    InputTextIntoElement    ${CheckoutShippingPage_FirstName}    ${FirstName}
    InputTextIntoElement    ${CheckoutShippingPage_LastName}    ${LastName}
    InputTextIntoElement    ${CheckoutShippingPage_Company}    ${Company}
    InputTextIntoElement    ${CheckoutShippingPage_Street}    ${StreetAddress}
    InputTextIntoElement    ${CheckoutShippingPage_City}    ${City}
    SelectOptionByLabel    ${CheckoutShippingPage_State}    ${State}
    InputTextIntoElement    ${CheckoutShippingPage_ZipCode}    ${ZipCode}
    InputTextIntoElement    ${CheckoutShippingPage_Phone}    ${Phone}
    SelectOptionByLabel    ${CheckoutShippingPage_Country}    ${Country}
    Common_Wait_Loader

CheckoutShippingPage_Select_ShippingMethods
    [Arguments]    ${shipping_method}
    Log To Console    Selecting Shipping Method: ${shipping_method}
    IF    '${shipping_method}'=='Best Way'
        ClickOnElementUntilSucceeds    ${CheckoutShippingPage_ShippingMethod_1}
    ELSE
        ClickOnElementUntilSucceeds    ${CheckoutShippingPage_ShippingMethod_2}
    END

CheckoutShippingPage_Next
    Log To Console    Submitting the Next button on Shipping page
    ClickOnElement    ${CheckoutShippingPage_Next}
    Common_Wait_Loader

# CheckoutPaymentPage ####

CheckoutPaymentPage_Check_Title
    [Arguments]    ${expected_title}
    Log To Console    Checking title of Checkout Payment page
    CompareTextOnElement    ${CheckoutPaymentPage_Title}    ${expected_title}

CheckoutPaymentPage_PlaceOrder
    Log To Console    Submitting the Place Order button on Payment page
    ClickOnElement    ${CheckoutPaymentPage_PlaceOrder}
    Common_Wait_Loader

# ThankYouPage ####

ThankYouPage_Check_Title
    [Arguments]    ${expected_title}
    Log To Console    Checking title of Thank You page
    CompareTextOnElement    ${ThankYouPage_Title}    ${expected_title}

ThankYouPage_Get_OrderId
    Log To Console    Getting Order Id on Thank You page
    ${OrderId}    GetTextOnElement    ${ThankYouPage_OrderId}
    update_orderid_in_customer    ${Email}    ${OrderId}

ThankYouPage_ContinueShopping
    Log To Console    Continuing shopping
    ClickOnElement    ${ThankYouPage_ContinueShopping}
