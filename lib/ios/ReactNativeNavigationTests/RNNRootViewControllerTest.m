//
//  RNNRootViewControllerTest.m
//  ReactNativeNavigation
//
//  Created by Elad Bogomolny on 23/07/2017.
//  Copyright © 2017 Wix. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "RNNRootViewController.h"
#import "RNNLayoutNode.h"
#import "RNNControllerFactory.h"
#import <React/RCTConvert.h>

@interface RNNRootViewControllerTest : XCTestCase

@property (nonatomic, strong) id<RNNRootViewCreator> creator;
@property (nonatomic, strong) RNNControllerFactory *factory;
@property (nonatomic, strong) RNNStore *store;

@end

@implementation RNNRootViewControllerTest

- (void)setUp {
    [super setUp];
	self.creator = nil;
	self.store = [RNNStore new];
	self.factory = [[RNNControllerFactory alloc] initWithRootViewCreator:self.creator store:self.store eventEmitter:nil];
}

- (void)tearDown {
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

- (void)testStatusBarHidden_true {
	UIViewController *testContainer = [self.factory createLayoutAndSaveToStore: @{@"id": @"cntId_2",
																				  @"type": @"Container",
																				  @"data": @{
																						  @"navigationOptions": @{
																								  @"statusBarHidden": @(1)
																								  }
																						  },
																				  @"children": @[]}];
	XCTAssertTrue([testContainer prefersStatusBarHidden]);
	
}

- (void)testStatusBarHidden_false {
	UIViewController *testContainer = [self.factory createLayoutAndSaveToStore: @{@"id": @"cntId_2",
																				  @"type": @"Container",
																				  @"data": @{
																						  @"navigationOptions": @{
																								  @"statusBarHidden": @(0)
																								  }
																						  },
																				  @"children": @[]}];
	XCTAssertFalse([testContainer prefersStatusBarHidden]);
	
}

- (void)testStatusBarHidden_default {
	UIViewController *testContainer = [self.factory createLayoutAndSaveToStore: @{@"id": @"cntId_2",
																				  @"type": @"Container",
																				  @"data": @{
																						  @"navigationOptions": @{
																								  @"topBarColor": @(0)
																								  }
																						  },
																				  @"children": @[]}];
	XCTAssertFalse([testContainer prefersStatusBarHidden]);
	
}

- (void)testTopBarTextColor_validColor {
	NSString* dummyContainerId = @"cntId_2";
	UINavigationController* NavigationContainer = [self.factory createLayoutAndSaveToStore: @{@"id": @"cntId",
																							  @"type": @"ContainerStack",
																							  @"data": @{},
																							  @"children": @[
																									  @{@"id": dummyContainerId ,
																										@"type": @"Container",
																										@"data": @{@"navigationOptions": @{
																														   @"title": @"some title",
																														   @"topBarTextColor": @(0xffff0000),
																														   @"topBarBackgroundColor": @(4294901760)
																														   }},
																										@"children": @[]}]}];
	UIViewController* vc = [self.store findContainerForId:dummyContainerId];
	[vc viewWillAppear:true];
	UIColor* expectedColor = [UIColor redColor];
	NSLog(@"----------------- %@",vc.navigationController.navigationBar.titleTextAttributes);
	XCTAssertTrue([vc.navigationController.navigationBar.titleTextAttributes[@"NSColor"] isEqual:expectedColor]);
}

- (void)testTopBarTextFontFamily_default {
	
}

- (void)testTopBarTextFontFamily_validFont {
	NSString* dummyContainerId = @"cntId_2";
	UINavigationController* NavigationContainer = [self.factory createLayoutAndSaveToStore: @{@"id": @"cntId",
																							  @"type": @"ContainerStack",
																							  @"data": @{},
																							  @"children": @[
																									  @{@"id": dummyContainerId ,
																										@"type": @"Container",
																										@"data": @{@"navigationOptions": @{
																														   @"title": @"some title",
																														   @"topBarTextColor": @(4294901760),
																														   @"topBarBackgroundColor": @(4294901760),
																														   @"topBarTextFontFamily": @"AmericanTypewriter-CondensedLight"
																														   }},
																										@"children": @[]}]}];
	UIViewController* vc = [self.store findContainerForId:dummyContainerId];
	[vc viewWillAppear:true];
	UIFont* expectedFont = [UIFont fontWithName:@"AmericanTypewriter-CondensedLight" size:20];
	XCTAssertTrue([vc.navigationController.navigationBar.titleTextAttributes[@"NSFont"] isEqual:expectedFont]);
	
}

- (void)testTopBarTextFontFamily_invalidFont {
	NSString* dummyContainerId = @"cntId_2";
	UINavigationController* NavigationContainer = [self.factory createLayoutAndSaveToStore: @{@"id": @"cntId",
																							  @"type": @"ContainerStack",
																							  @"data": @{},
																							  @"children": @[
																									  @{@"id": dummyContainerId ,
																										@"type": @"Container",
																										@"data": @{@"navigationOptions": @{
																														   @"title": @"some title",
																														   @"topBarTextColor": @(0xffff0000),
																														   @"topBarBackgroundColor": @(4294901760),
																														   @"topBarTextFontFamily": @"AmericanTypedaADswriter-CondensedLight"
																														   }},
																										@"children": @[]}]}];
	UIViewController* vc = [self.store findContainerForId:dummyContainerId];
	XCTAssertThrows([vc viewWillAppear:true]);
}

- (void)testTopBarBackgroundColor_default {
	NSString* dummyContainerId = @"cntId_2";
	UINavigationController* NavigationContainer = [self.factory createLayoutAndSaveToStore: @{@"id": @"cntId",
																							  @"type": @"ContainerStack",
																							  @"data": @{},
																							  @"children": @[
																									  @{@"id": dummyContainerId ,
																										@"type": @"Container",
																										@"data": @{@"navigationOptions": @{
																														   @"title": @"some title",
																														   @"topBarTextColor": @(4294901760)
																														   }},
																										@"children": @[]}]}];
	UIViewController* vc = [self.store findContainerForId:dummyContainerId];
	[vc viewWillAppear:true];
	UIColor* expectedColor = [RCTConvert UIColor:@(4294901760)];
	NSLog(@"----------------- %@",[vc.navigationController.navigationBar barTintColor]);
	XCTAssertNil(vc.navigationController.navigationBar.barTintColor);

}

- (void)testTopBarBackgroundColor_validColor {
	NSString* dummyContainerId = @"cntId_2";
	UINavigationController* NavigationContainer = [self.factory createLayoutAndSaveToStore: @{@"id": @"cntId",
																							  @"type": @"ContainerStack",
																							  @"data": @{},
																							  @"children": @[
																									  @{@"id": dummyContainerId ,
																										@"type": @"Container",
																										@"data": @{@"navigationOptions": @{
																														   @"title": @"some title",
																														   @"topBarTextColor": @(4294901760),
																														   @"topBarBackgroundColor": @(4294901760)
																														   }},
																										@"children": @[]}]}];
	UIViewController* vc = [self.store findContainerForId:dummyContainerId];
	[vc viewWillAppear:true];
	UIColor* expectedColor = [RCTConvert UIColor:@(4294901760)];
	NSLog(@"----------------- %@",vc.navigationController.navigationBar.barTintColor);
	XCTAssertTrue([vc.navigationController.navigationBar.barTintColor isEqual:expectedColor]);
	
}

- (void)testTopBarButtonColor_default {
//	NSString* dummyContainerId = @"cntId_2";
//	UINavigationController* NavigationContainer = [self.factory createLayoutAndSaveToStore: @{@"id": @"cntId",
//																							  @"type": @"ContainerStack",
//																							  @"data": @{},
//																							  @"children": @[
//																									  @{@"id": dummyContainerId ,
//																										@"type": @"Container",
//																										@"data": @{@"navigationOptions": @{
//																														   @"title": @"some title",
//																														   @"topBarTextColor": @(4294901760),
//																														   @"topBarBackgroundColor": @(4294901760)
//																														   }},
//																										@"children": @[]}]}];
//	UIViewController* vc = [self.store findContainerForId:dummyContainerId];
//	[vc viewWillAppear:true];
//	NSLog(@"----------------- %@",vc.navigationController.navigationBar.barTintColor);
//	XCTAssertTrue([vc.navigationController.navigationBar.barTintColor isEqual:expectedColor]);
}

- (void)testTopBarButtonColor_validColor {
	
}

- (void)testTopBarTranslucent_default {
	
}

- (void)testTopBarTranslucent_true {
	
}

- (void)testTopBarTranslucent_false {
	
}

- (void)testNavigationOptions_true {

}

- (void)testNavigationOptions_false {

}





/* ---------------------------------------------------------------------- */


-(void)testHideStatusBar {
	RNNLayoutNode* node = [[RNNLayoutNode alloc]init];
	
//	node.data = @{@"name": @"bob", @"navigationOptions": @{@"statusBarHidden": @true}};
	id creator = nil;
	id emitter = nil;
	
	RNNNavigationOptions* opts = [[RNNNavigationOptions alloc] init];
	opts.statusBarHidden = true;
	RNNRootViewController* uut = [[RNNRootViewController alloc]initWithName:@"bob" withNavigationOptions:opts rootViewCreator:creator eventEmitter:emitter];
	
//	RNNRootViewController* uut = [[RNNRootViewController alloc]initWithNode:node rootViewCreator:creator eventEmitter:emitter];
	XCTAssertTrue([uut prefersStatusBarHidden]);
}






@end