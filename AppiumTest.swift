const { remote } = require('webdriverio');

// ---------------------------------------------
// APPIUM SETUP:
// ---------------------------------------------

// 1. Appium Server:
// Ensure the Appium server is running before executing this script.
// Start it via terminal using: `appium`

// 2. iOS Setup:
// - If testing on a simulator, ensure the simulator is running with correct iOS version (`platformVersion`).
// - If testing on a real device, connect it via USB and ensure it’s trusted and has a valid provisioning profile.

// 3. Capabilities Explanation:
// - platformName: iOS
// - platformVersion: e.g., "16.2"
// - deviceName: e.g., "iPhone 14"
// - app: Path to your `.app` or `.ipa` file
// - automationName: XCUITest (used for iOS UI automation)
// - language/locale: To set test in different languages

const capabilities = {
    platformName: 'iOS',                   // Platform set to iOS
    platformVersion: '16.2',              // iOS version of the device or simulator
    deviceName: 'iPhone 14',              // Name of the simulator or real device
    app: '/path/to/your/app.app',         // Path to your app build (.app or .ipa)
    automationName: 'XCUITest',           // Required automation engine for iOS
    noReset: true,                        // Preserve app state between sessions
    language: 'en',                       // Change to 'es' (Spanish), 'pt' (Portuguese) as needed
    locale: 'US',                         // Change to 'ES', 'BR' respectively
    // Optional real device settings:
    // udid: 'your-device-udid',
    // xcodeOrgId: 'your-xcode-org-id',
    // xcodeSigningId: 'iPhone Developer'
};

// ---------------------------------------------
// INTEGRATION TEST: LOGIN + DASHBOARD
// ---------------------------------------------

async function runIntegrationTest() {
    const driver = await remote({
        logLevel: 'info',
        path: '/wd/hub',
        capabilities,
    });

    try {
        // Step 1: Locate login inputs and login button
        const usernameField = await driver.$('~username_input');  // Use accessibility ID
        await usernameField.setValue('testuser');

        const passwordField = await driver.$('~password_input');
        await passwordField.setValue('securepassword');

        const loginButton = await driver.$('~login_button');
        await loginButton.click();

        // Step 2: Wait for dashboard screen to load
        const dashboardHeader = await driver.$('~dashboard_header');
        const isDisplayed = await dashboardHeader.isDisplayed();

        if (isDisplayed) {
            console.log('✅ Integration Test Passed: Login + Dashboard');
        } else {
            throw new Error('❌ Dashboard did not load after login');
        }

        // Step 3: Optional - Simulate location access (multilingual context)
        const allowLocationButton = await driver.$('~allow_location_button');
        if (await allowLocationButton.isDisplayed()) {
            await allowLocationButton.click();
            console.log('📍 Location permission allowed');
        }

    } catch (error) {
        console.error('❌ Integration Test Failed:', error);
    } finally {
        await driver.deleteSession();  // End Appium session
    }
}

// ---------------------------------------------
// MULTILANGUAGE LOCATION TESTING NOTES:
// ---------------------------------------------

// To test location permissions across multiple languages, change:
// capabilities.language and capabilities.locale
//
// English:
// language: 'en', locale: 'US'
// Look for buttons like: "Allow While Using App", "Don't Allow"
//
// Español:
// language: 'es', locale: 'ES'
// Look for buttons like: "Permitir una vez", "No permitir"
//
// Português:
// language: 'pt', locale: 'BR'
// Look for buttons like: "Permitir durante o uso do app", "Não permitir"
//
// Use different accessibility IDs or use driver.$('//XCUIElementTypeButton[@name="..."]')
// if the button text changes per language

// ---------------------------------------------
// Run the test
// ---------------------------------------------
runIntegrationTest();
