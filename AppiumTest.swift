// APPIUM SETUP:
// 1. **Appium Server**: Ensure the Appium server is running before executing this script. Start it via terminal using `appium`.

// 2. **iOS Setup**:
//    - If testing on a **simulator**, make sure the simulator is running with the correct iOS version (configured in `platformVersion`).
//    - If testing on a **real device**, ensure the device is connected via USB, trusted for development, and that the UDID is correct.
//    - For real devices, also ensure the app is signed with valid certificates in Xcode and a valid provisioning profile is used.

// 3. **Capabilities Explanation**:
//    - `platformName`: Specifies the platform to run the test on (set to 'iOS' for iOS testing).
//    - `platformVersion`: The version of iOS on the simulator or device.
//    - `deviceName`: Name of the device or simulator you want to use.
//    - `app`: Path to your iOS `.app` file. You can also provide an `.ipa` file if testing on a real device.
//    - `automationName`: The automation framework to use. For iOS, use `XCUITest`.
//    - `udid`: (Optional) The unique device identifier for real devices. You can get it using `idevice_id -l`.
//    - `language`: Specifies the language for the device.
//    - `locale`: Specifies the locale for the device.
//    - `location`: Latitude and Longitude to simulate location during testing.

// Define the languages and locales to test
const languagesAndLocales = [
    { language: 'en', locale: 'US' },  // English (US)
    { language: 'pt', locale: 'BR' },  // Portuguese (Brazil)
    { language: 'es', locale: 'ES' },  // Spanish (Spain)
];

// Define the location to simulate (latitude and longitude for San Francisco)
const location = { latitude: 37.7749, longitude: -122.4194 };

// Function to run the Appium test for a specific language and locale
async function runAppiumTest(language, locale) {
    const capabilities = {
        platformName: 'iOS',  // Set platform to iOS for testing iOS apps
        platformVersion: '16.2',  // Specify the iOS version of the simulator or real device you are using
        deviceName: 'iPhone 14',  // Simulator name, replace with actual device name if using a real device
        app: '/path/to/your/app.app',  // Path to your .app file for iOS app testing
        automationName: 'XCUITest',  // XCUITest is the automation framework for iOS
        noReset: true,  // Do not reset app between tests, useful for maintaining session state
        language: language,  // Set the language for testing (English, Portuguese, Spanish)
        locale: locale,  // Set the locale for testing (US, Brazil, Spain)
        locationServicesEnabled: true,  // Enable location services if you need to simulate location during tests
        locationServicesAuthorized: true,  // Authorize location services for your app
        location: location,  // Set the simulated location (latitude and longitude)
    };

    const { remote } = require('webdriverio');
    
    // Establishing the Appium driver and session
    const driver = await remote({
        logLevel: 'info',  // Log level for detailed information during execution
        path: '/wd/hub',  // Path for the Appium server (default is /wd/hub)
        capabilities: capabilities,  // Pass the capabilities defined above
    });

    try {
        // Find and interact with an element using its accessibility ID
        const element = await driver.$('~login_button');  // Example: Using accessibility ID as a locator
        await element.click();  // Click the element (e.g., login button)

        // Optionally perform more test actions, such as assertions
        // Example: let text = await driver.getText('~some_element');
        // assert.strictEqual(text, 'Expected Text');  // Example assertion

        // Take a screenshot for debugging or logging purposes
        const screenshot = await driver.takeScreenshot();
        require('fs').writeFileSync(`screenshot-${language}-${locale}.png`, screenshot, 'base64');  // Save screenshot to disk

    } catch (error) {
        console.error(`Test failed for ${language}-${locale}:`, error);  // Log any errors that occur during the test
    } finally {
        await driver.deleteSession();  // Always clean up and end the Appium session after the test
    }
}

// Run the tests for each language/locale combination
async function runTests() {
    for (let i = 0; i < languagesAndLocales.length; i++) {
        const { language, locale } = languagesAndLocales[i];
        console.log(`Running test for language: ${language}, locale: ${locale}`);
        await runAppiumTest(language, locale);
    }
}

// Start the test script
runTests();
