*** Settings ***
Library  AppiumLibrary

*** Variables ***
${ANDROID_AUTOMATION_NAME}    UIAutomator2
${ANDROID_APP}                path/to/app
${ANDROID_PLATFORM_NAME}      Android
${ANDROID_PLATFORM_VERSION}   %{ANDROID_PLATFORM_VERSION=12}

*** Test Cases ***
Cek Tarif
  Given Open Test Application
  When I click setuju on kebijakan dan privasi
  And I login with valid account
  When I click cek tarif button
  And I fill in origin and destination address
  Then I click cek tarif


*** Keywords ***
Open Test Application
  Open Application  http://127.0.0.1:4723  automationName=${ANDROID_AUTOMATION_NAME}
  ...  platformName=${ANDROID_PLATFORM_NAME}  platformVersion=${ANDROID_PLATFORM_VERSION}
#  ...  app=${ANDROID_APP}
  ...  noReset=true
  ...  appPackage=com.lionparcel.services.consumer  appActivity=com.lionparcel.services.consumer.view.splash.BrandingActivity


I click setuju on kebijakan dan privasi
  Click Element    com.lionparcel.services.consumer:id/btnAgree


I login with valid account
  Wait Until Element Is Visible   xpath=//android.widget.Button[contains(@text, "Masuk")]
  Click Element   xpath=//android.widget.Button[contains(@text, "Masuk")]
  Wait Until Element Is Visible  xpath=//android.widget.EditText[contains(@text, "Nomor Handphone")]
  Input Text  xpath=//android.widget.EditText[contains(@text, "Nomor Handphone")]  [fill with your phone number]
  Input Text  xpath=//android.widget.EditText[contains(@text, "Password")]  password
  Click Element   xpath=//android.widget.Button[contains(@text, "Masuk")]

I click cek tarif button
  Wait Until Page Contains Element  com.lionparcel.services.consumer:id/ivClose
  Click Element  com.lionparcel.services.consumer:id/ivClose
  Wait Until Page Contains Element  xpath=//androidx.recyclerview.widget.RecyclerView/android.view.ViewGroup[3]
  Click Element  xpath=//androidx.recyclerview.widget.RecyclerView/android.view.ViewGroup[3]
  ${is_visible}=    Run Keyword And Return Status    Element Should Be Visible    com.android.permissioncontroller:id/permission_allow_foreground_only_button
  Run Keyword If    ${is_visible}    Click Element    com.android.permissioncontroller:id/permission_allow_foreground_only_button

I fill in origin and destination address
  Wait Until Page Contains Element  com.lionparcel.services.consumer:id/edtOriginAddress
  Click Element  com.lionparcel.services.consumer:id/edtOriginAddress
  Wait Until Page Contains Element  com.lionparcel.services.consumer:id/edtRouteSearch
  Input Text  com.lionparcel.services.consumer:id/edtRouteSearch  jakarta
  Click Element   xpath=//android.widget.TextView[contains(@text, "Cakung, Jakarta Timur (CGK)")]
  Wait Until Page Contains Element  com.lionparcel.services.consumer:id/edtDestinationAddress
  Click Element  com.lionparcel.services.consumer:id/edtDestinationAddress
  Wait Until Page Contains Element  com.lionparcel.services.consumer:id/edtRouteSearch
  Input Text  com.lionparcel.services.consumer:id/edtRouteSearch  jakarta
  Click Element   xpath=//android.widget.TextView[contains(@text, "Jakarta Pusat (CGK)")]

I click cek tarif
  Wait Until Page Contains Element  com.lionparcel.services.consumer:id/btnCheckTariff
  Click Element  com.lionparcel.services.consumer:id/btnCheckTariff
    FOR    ${i}    IN RANGE    5
        Swipe By Percent    50    50    50    20
    END
  Element Text Should Be    com.lionparcel.services.consumer:id/txtTotalTariffEstimation    Rp10.000
