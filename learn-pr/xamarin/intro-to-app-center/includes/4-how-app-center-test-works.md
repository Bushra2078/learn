Now that you understand the aspects of App Center Build, let's see how App Center ATest can run test suites against your app's user interface (UI). App Center tests are performed on your app while it is running on physical devices. Running tests against real devices gives you much more confidence in your app's ability to handle real user interactions when it is released to testers or app store users. When your app works as expected, you help avoid user frustration and poor app store ratings.

## What is a device configuration?

The _device configuration_ is the combination of device model and operating system version. An iPhone XS running iOS 12.1 is a device configuration, and it is be a different device configuration than an iPhone XS running iOS 12.4.

## What is a device tier?

_Device tier_ is a measure of device popularity, which is sometimes adjusted by the age of a device. Device configurations are grouped into tiers. The most popular devices are tier 1, such as flagship phones from major manufacturers. App Center maintains more and more of these tier 1 devices, meaning shorter wait times when running tests. Tier 1 devices will eventually become tier 2 devices as they age. Lastly, tier 3 devices are edge devices that are not common or popular in the market. Tier 3 devices are available in smaller volumes and may have longer wait times.

## What is a device set?

A _device set_ is a collection of device configurations. Device sets provide convenient access to devices that are commonly used for repeated tasks. For example, you might define a device set representing a broad range of device configurations for a minimal launch test to make sure your app launches correctly for each planned app store release.

## What devices are available?

App Center Test maintains a [list of available devices and their operating system versions](/appcenter/test-cloud/devices/android). Generally, you will find the most common device configurations, representing the most popular devices from major manufacturers. You can also find older configurations of popular devices that may have reached the end of their system updates.

## What is a test run?

A _test run_ is the execution of a set of tests against a device set using an application binary. App Center Test will load your application and the necessary test files onto each device configuration in the set and run the set of tests.

## Execute a test run on physical devices

Your test runs execute on actual devices in a Microsoft data center in a hosted situation. As devices become available, the application and test files are loaded. As the tests are run on the device, App Center Test maintains any logs or screenshots that are generated during the run in the resulting test report; these reports are maintained for review for six months.
