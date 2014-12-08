MMQreki ![License MIT](https://go-shields.herokuapp.com/license-MIT-yellow.png) 
=================


MMQreki is a library to carry out the get of "Rokuyo"

## Features
- Conversion from the old lunar calendar to the Gregorian calendar
- Conversion from Gregorian calendar to the old lunar calendar
- Get Rokuyo

## System requirements
- iOS 6.0 or higher

## Installation
### CocoaPods
`pod 'MMQreki', :git => 'https://github.com/masajene/MMQreki.git', :tag => '0.1'
`

## Usage

**Conversion from Gregorian calendar to the old lunar calendar**
```objective-c
MMQreki *qreki = [[MMQreki alloc] init];
NSString *qrekiString = [qreki getNewToOldCalender:[NSDate date];
```
**Get Rokuyo**
```objective-c
MMQreki *qreki = [[MMQreki alloc] init];
NSString *qrekiString = [qreki getRokuyo:[NSDate date]];
```


## License

[Apache]: http://www.apache.org/licenses/LICENSE-2.0
[MIT]: http://www.opensource.org/licenses/mit-license.php
[GPL]: http://www.gnu.org/licenses/gpl.html
[BSD]: http://opensource.org/licenses/bsd-license.php

MMQreki is available under the [MIT license][MIT]. See the LICENSE file for more info.