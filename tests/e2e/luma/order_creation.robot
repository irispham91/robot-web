*** Settings ***
Documentation       Test suites to verify that order creation succeed on luma channel correctly
...                 depending from Category/Shipping Method dependent rules.
...                 Each test will use one data from csv file,
...                 and then the status:PASSED will be updated on each data respectively after the test ends.
...                 See http://internal.example.com/docs/abs.pdf

# Often a good idea to add overall documentation to test suite files.
# Should contain background information, why tests are created, notes about execution environment, etc.
Resource            resources/settings/luma.robot

Suite Setup         Run Keywords    Set Log Level    TRACE    AND    OpenLumaOnBrowser
Suite Teardown      CloseCurrentBrowser
Test Teardown       Run Keywords    UpdateStatusCsv    AND    ReloadLuma


*** Test Cases ***
Order successfully with Category: Women, Shipping Method: Flat Rate
    [Tags]    regression    web    order
    LandingPage_Check_Logo
    Header_Transit_NavigationMenu    menu=Women    submenu=Tops    submenu2=Jackets
    ProductListPage_Check_Title    Jackets
    ProductListPage_Transit_ProductDetailsPage
    ProductDetailsPage_Check_Title    Olivia 1/4 Zip Light Jacket
    ProductDetailsPage_AddToCart_WithInfo    size=XS    color=Black    qty=1
    Header_Transit_CartPage
    MiniCartPopup_Check_Title
    MiniCartPopup_ProceedToCheckout
    CheckoutShippingPage_Check_Title    Shipping Address
    CheckoutShippingPage_Fill_RequiredInfo
    CheckoutShippingPage_Select_ShippingMethods    Best Way
    CheckoutShippingPage_Next
    CheckoutPaymentPage_Check_Title    Payment Method
    CheckoutPaymentPage_PlaceOrder
    ThankYouPage_Check_Title    Thank you for your purchase!
    ThankYouPage_Get_OrderId
    ThankYouPage_ContinueShopping
    LandingPage_Check_Logo

Order successfully with Category: Men, Shipping Method: Best Way
    [Tags]    regression    web    order
    LandingPage_Check_Logo
    Header_Transit_NavigationMenu    menu=Men    submenu=Bottoms    submenu2=Pants
    ProductListPage_Check_Title    Pants
    ProductListPage_Transit_ProductDetailsPage
    ProductDetailsPage_Check_Title    Cronus Yoga Pant
    ProductDetailsPage_AddToCart_WithInfo    size=36    color=Red    qty=2
    Header_Transit_CartPage
    MiniCartPopup_Check_Title
    MiniCartPopup_ProceedToCheckout
    CheckoutShippingPage_Check_Title    Shipping Address
    CheckoutShippingPage_Fill_RequiredInfo
    CheckoutShippingPage_Select_ShippingMethods    Best Way
    CheckoutShippingPage_Next
    CheckoutPaymentPage_Check_Title    Payment Method
    CheckoutPaymentPage_PlaceOrder
    ThankYouPage_Check_Title    Thank you for your purchase!
    ThankYouPage_Get_OrderId
    ThankYouPage_ContinueShopping
    LandingPage_Check_Logo
