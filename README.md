# 'Techniques for Generating and Managing Test Data' Sample 
> This project is the official sample for the `Techniques for Generating and Managing Test Data` 2018 San Francisco [TestBash](https://www.ministryoftesting.com/events/testbash-san-francisco-2018) Conference talk given by Omose Ogala. 

## Setup

###### Local Http Server
> This local server will be providing the data to the application. Requests that are made localhost from the app will return JSON.

Before you open the iOS workspace, you must first start the local server.

```
$ cd generating-managing-test-data
$ npm start 
```

> `$ npm start` will install the lastest node modules and well as start up the local server on port 8080.

At this point, you can go to `localhost:8080/sample-data` with any browser or a program like [Postman](https://www.getpostman.com)
to view the JSON pretty printed.

----
###### iOS Project
Before you open the workspace, you must install the pods. If you dont have CocoaPods installed on your computer, 
run `sudo gem install cocoapods` to install it.

To install the pods:
```
$ cd generating-managing-test-data/GeneratingAndManagingTestDataSampleApp
$ pod install
```
> The pod required is [Fakery](https://github.com/vadymmarkov/Fakery), which helps with generating random raw data.

## Running

You are now ready to open the iOS workspace with [XCode](https://itunes.apple.com/us/app/xcode/id497799835?mt=12).

```
open GeneratingAndManagingTestDataSampleApp.xcworkspace
```

You can now run the sample app to see it live, or you can run the test case to see the testing in action.

###### Running

To run the app, choose a device from the top of XCode, and hit the play button. Alternatively, you can click `Command + R`

To run the tests, go to `GeneratingAndManagingTestDataSampleAppUITests/tests/ArticleCellTests.swift`, and run the test case availble.

## Author
Omose Ogala, omose.ogala@gmail.com
Twitter: [@Omoseisreal](https://twitter.com/omoseisreal)
