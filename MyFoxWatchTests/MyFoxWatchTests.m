//
//  KaziMyFoxTests.m
//  KaziMyFoxTests
//
//  Created by Madjid KAZI-TANI on 20/07/2015.
//  Copyright (c) 2015 Madjid KAZI-TANI. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>

@interface KzMyFoxTests : XCTestCase

@end

@implementation KzMyFoxTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    XCTAssert(YES, @"Pass");
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
