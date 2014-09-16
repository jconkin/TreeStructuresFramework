//
//  NodeTests.m
//  TreeStructures
//
//  Created by Jeremy Conkin on 9/8/14.
//  Copyright (c) 2014 Jeremy Conkin. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "Node.h"

@interface NodeTests : XCTestCase

@end

@implementation NodeTests

/**
 *  Verify that nodes may be given a integer value and that those with greater
 *  values will be returned as greater than those with lesser values
 */
- (void)testNumberIntegerNodes {
    
    Node *fiveNode = [[Node alloc] initWithObject:[NSNumber numberWithFloat:5]];
    Node *sixNode = [[Node alloc] initWithObject:[NSNumber numberWithInteger:6]];
    
    XCTAssert(([fiveNode compare:sixNode] == NSOrderedAscending), @"Pass");
    XCTAssert(([sixNode compare:fiveNode] == NSOrderedDescending), @"Pass");
    XCTAssert(([sixNode compare:sixNode] == NSOrderedSame), @"Pass");
}

/**
 *  Verify that nodes initialized with ints and floats still compare as expected
 */
- (void)testNumberFloatIntegerNodes {
    
    Node *fiveNode = [[Node alloc] initWithObject:[NSNumber numberWithFloat:5.f]];
    Node *fivePlusNode = [[Node alloc] initWithObject:[NSNumber numberWithFloat:5.01f]];
    Node *sixNode = [[Node alloc] initWithObject:[NSNumber numberWithInteger:6]];
    
    XCTAssert(([fiveNode compare:sixNode] == NSOrderedAscending), @"Pass");
    XCTAssert(([fivePlusNode compare:sixNode] == NSOrderedAscending), @"Pass");
    XCTAssert(([sixNode compare:fiveNode] == NSOrderedDescending), @"Pass");
    XCTAssert(([sixNode compare:fivePlusNode] == NSOrderedDescending), @"Pass");

}

@end
