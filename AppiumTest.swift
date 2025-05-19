// APPIUM SETUP:
// 1. **Appium Server**: Ensure the Appium server is running before executing this script. Start it via terminal using `appium`.

// 2. **iOS Setup**:
//    - If testing on a **simulator**, make sure the simulator is running with the correct iOS version (configured in `platformVersion`).
//    - If testing on a **real device**, ensure the device is connected via USB, trusted for development, and that the UDID is correct.
//    - For real devices, also ensure the app is signed with valid certificates in Xcode and a valid provisioning profile is used.

// 3. **Capabilities Explanation**:
//    - `platformName`: Specifies the platform to run the test on (set to 'iOS' for iOS testing).
//    - `platformVersion`: The version of iOS on the simulator or device.
    //   - Example: Use iOS version "16.2" for testing on simulators or devices with iOS 16.
    // - `deviceName`: Name of the device or simulator you want to use.
    //   - Example: Use "iPhone 14" for testing on the iPhone 14 simulator.
//    - `app`: Path to your iOS `.app` file. You can also provide an `.ipa` file if testing on a real device.
    //   - Example: `/path/to/your/app.app`
//    - `automationName`: The automation framework to use. For iOS, use `XCUITest`.
//    - `udid`: (Optional) The unique device identifier for real devices. You can get it using `idevice_id -l`.
// 4. **Test Actions**:
//    - Example test actions include finding elements using various locators (e.g., accessibility IDs, XPath, class name) and interacting with them (clicking, typing, etc.).
//    - Use `driver.$` to find an element and then interact with it using actions like `.click()`, `.setValue()`, etc.
// 5. **Ending the Test**: Always call `driver.deleteSession()` to ensure the Appium session ends correctly, freeing up resources.

const { remote } = require('webdriverio');

// Appium Setup - Make sure Appium server is running before executing this script
// You can start the Appium server by running 'appium' in the terminal
// or configure Appium to run in the background before executing this code

// Define capabilities for the iOS testing session
const capabilities = {
    platformName: 'iOS',  // Set platform to iOS for testing iOS apps
    platformVersion: '16.2',  // Specify the iOS version of the simulator or real device you are using
    deviceName: 'iPhone 14',  // Simulator name, replace with actual device name if using a real device
    app: '/path/to/your/app.app',  // Path to your .app file for iOS app testing
    automationName: 'XCUITest',  // XCUITest is the automation framework for iOS
    noReset: true,  // Do not reset app between tests, useful for maintaining session state
    // If testing on a real device, use udid and other configurations
    udid: 'your-device-udid',  // Optional: Unique Device Identifier for real device testing (replace with actual udid)
    xcodeOrgId: 'your-xcode-org-id',  // Optional: Organization ID required for real device testing (Xcode signing)
    xcodeSigningId: 'iPhone Developer',  // Optional: Xcode signing identity (ensure the app is signed correctly)
};

// Establishing the Appium driver and session
async function runAppiumTest() {
    const driver = await remote({
        logLevel: 'info',  // Log level for detailed information during execution
        path: '/wd/hub',  // Path for the Appium server (default is /wd/hub)
        capabilities: capabilities,  // Pass the capabilities defined above
    });

    try {
        //Assign identifiers, to locate elements
        myButton.accessibilityIdentifier = "login_button"
       
        const element = await driver.$('~element_locator');  // Example element locator (use accessibility ID or XPath)
        await element.click();
        // Example: let text = await driver.getText('~some_element');
        // assert.strictEqual(text, 'Expected Text');  // Example assertion

    } catch (error) {
        console.error('Test failed:', error);
    } finally {
        await driver.deleteSession();  // Always clean up and end the Appium session after the test
    }
}

// Start the test script
runAppiumTest();
