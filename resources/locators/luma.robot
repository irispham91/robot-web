*** Variables ***
# Common
${Header_Navigation_Menu}                       xpath=//li[contains(@class,"level0")]//span[text()="%%s"]
${Header_Navigation_SubMenu}
...                                             xpath=//ul[contains(@class,"level0") and @aria-expanded="true"]//span[text()="%%s"]
${Header_Navigation_SubMenu2}
...                                             xpath=//ul[contains(@class,"level1") and @aria-expanded="true"]//span[text()="%%s"]
${Header_Cart}                                  xpath=//a[contains(@class,"showcart")]

${Loader}                                       xpath=//div[@class="loader"]

# LandingPage
${LandingPage_Logo}                             xpath=//a[@class="logo"]/img[contains(@src,"luma")]

# ProductListPage
${ProductListPage_Title}                        xpath=//h1[@id="page-title-heading"]
${ProductListPage_FirstProduct}                 xpath=(//li[contains(@class,"product-item")])[1]
${ProductListPage_FirstProduct_AddToCart}       xpath=(//form[@data-role="tocart-form"]//button)[1]

# ProductDetailsPage
${ProductDetailsPage_Title}                     xpath=//div[@class="product-info-main"]//h1[@class="page-title"]
${ProductDetailsPage_Size}                      xpath=//div[@attribute-code="size"]//div[@option-label="%%s"]
${ProductDetailsPage_Color}                     xpath=//div[@attribute-code="color"]//div[@option-label="%%s"]
${ProductDetailsPage_Qty}                       xpath=//input[@id="qty"]
${ProductDetailsPage_AddToCart}                 xpath=//button[@id="product-addtocart-button"]

# MiniCartPopup
${MiniCartPopup_Title}                          xpath=//div[@id="minicart-content-wrapper"]
${MiniCartPopup_ProceedToCheckout}              xpath=//button[@id="top-cart-btn-checkout"]

# CheckoutShippingPage
${CheckoutShippingPage_Title}                   xpath=//li[@id="shipping"]/div[1]
${CheckoutShippingPage_Email}                   xpath=//input[@id="customer-email"]
${CheckoutShippingPage_FirstName}               xpath=//input[@name="firstname"]
${CheckoutShippingPage_LastName}                xpath=//input[@name="lastname"]
${CheckoutShippingPage_Company}                 xpath=//input[@name="company"]
${CheckoutShippingPage_Street}                  xpath=//input[@name="street[0]"]
${CheckoutShippingPage_City}                    xpath=//input[@name="city"]
${CheckoutShippingPage_State}                   xpath=//select[@name="region_id"]
${CheckoutShippingPage_ZipCode}                 xpath=//input[@name="postcode"]
${CheckoutShippingPage_Country}                 xpath=//select[@name="country_id"]
${CheckoutShippingPage_Phone}                   xpath=//input[@name="telephone"]
${CheckoutShippingPage_ShippingMethod_1}        xpath=//input[@value="tablerate_bestway"]
${CheckoutShippingPage_ShippingMethod_2}        xpath=//input[@value="flatrate_flatrate"]
${CheckoutShippingPage_Next}                    xpath=//button[contains(@class,"continue")]

# CheckoutPaymentPage
${CheckoutPaymentPage_Title}                    xpath=//li[@id="payment"]//div[@class="step-title"]
${CheckoutPaymentPage_PlaceOrder}               xpath=//button[@title="Place Order"]

# ThankYouPage
${ThankYouPage_Title}                           xpath=//h1[@class="page-title"]
${ThankYouPage_OrderId}                         xpath=//div[@class="checkout-success"]/p/span
${ThankYouPage_ContinueShopping}                xpath=//div[@class="checkout-success"]//a
${ThankYouPage_CreateAccount}                   xpath=//div[@id="registration"]//a
