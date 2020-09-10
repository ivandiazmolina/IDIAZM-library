![IDIAZM: An utility library for Swift](https://raw.githubusercontent.com/ivandiazmolina/IDIAZM-library/master/IDIAZM.png)

[![Version](https://img.shields.io/cocoapods/v/IDIAZM.svg?style=flat)](https://cocoapods.org/pods/IDIAZM)
![Swift 5.0](https://img.shields.io/badge/Swift-5.0-orange.svg)
[![License](https://img.shields.io/cocoapods/l/IDIAZM.svg?style=flat)](https://cocoapods.org/pods/IDIAZM)
[![Platform](https://img.shields.io/cocoapods/p/IDIAZM.svg?style=flat)](https://cocoapods.org/pods/IDIAZM)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

- iOS 10.0+
- Xcode 11

## Installation

IDIAZM is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'IDIAZM' '~> 0.0.2'
```

## Global Import

In order to use the Library globally, it is necessary to create a file called “Bridging-Header”, so We are going to add a new file in Xcode (File > New > File), then in “Source” section, click “Header File“.

Type the name your file like this “YourProjectName-Bridging-Header.h” and click in ‘Create’

Now, We need to link the file in your project, so We are going to click in us target of project and navigate 'build settings' and type in “bridging header” into the searchbox.

Next to “Objective-C Bridging Header” you will need to add the name/path of your header file.

```swift
$SRCROOT/$PROJECT_NAME/YourProjectName-Bridging-Header.h
```

Finally, in us "Bridging-Header.h" file, We are going to type the library.

```obj-c
#import <IDIAZM/IDIAZM-Swift.h>
```


## Author

ivandiazmolina, ivandiazmolina92@gmail.com

## License

IDIAZM is available under the MIT license. See the LICENSE file for more info.
