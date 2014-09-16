//
//  SinglyLinkedListTest.m
//  TreeStructures
//
//  Created by Jeremy Conkin on 9/14/14.
//  Copyright (c) 2014 Jeremy Conkin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>

#import "Node.h"
#import "SinglyLinkedList.h"

@interface SinglyLinkedListTest : XCTestCase

@end

@implementation SinglyLinkedListTest

/**
 *  Verify that the size of the list is the number of nodes added to it
 */
- (void)testLength {
    
    SinglyLinkedList *list = [SinglyLinkedList new];
    NSNumber *zeroValue = [NSNumber numberWithInt:0];
    [list appendObject:zeroValue];
    XCTAssert((list.lengthOfList == 1), @"List with 1 node added should have length of 1");
    
    [list appendObject:[NSNumber numberWithInt:1]];
    XCTAssert((list.lengthOfList == 2), @"List with 2 nodes added should have length of 2");
    
    [list appendObject:[NSNumber numberWithInt:2]];
    XCTAssert((list.lengthOfList == 3), @"List with 3 node added should have length of 3");
    
    [list appendObject:zeroValue];
    XCTAssert((list.lengthOfList == 4), @"Should be able to re-add values as new nodes");
}

/**
 * Verify that the values added to the list are the same when dereferenced
 */
- (void)testValues {
    
    SinglyLinkedList *list = [SinglyLinkedList new];
    [list appendObject:[NSNumber numberWithInt:0]];
    [list appendObject:[NSNumber numberWithInt:1]];
    [list appendObject:[NSNumber numberWithInt:2]];
    
    XCTAssert(([[list objectAtIndex:0] isKindOfClass:[NSNumber class]]), @"Values added to a list should not change type");
    NSNumber *zeroValue = [list objectAtIndex:0];
    XCTAssert(([zeroValue integerValue] == 0), @"Value of 0 added should be value of 0 when found");
    NSNumber *oneValue = [list objectAtIndex:1];
    XCTAssert(([oneValue integerValue] == 1), @"Value of 1 added should be value of 1 when found");
    NSNumber *twoValue = [list objectAtIndex:2];
    XCTAssert(([twoValue integerValue] == 2), @"Value of 2 added should be value of 2 when found");
    XCTAssert(([zeroValue integerValue] == 0), @"Value of 0 added should be value of 0 when found");
    XCTAssert(([oneValue integerValue] == 1), @"Value of 1 added should be value of 1 when found");
    XCTAssert(([twoValue integerValue] == 2), @"Value of 2 added should be value of 2 when found");

}

- (void)testRemovingValues {
    
    SinglyLinkedList *list = [SinglyLinkedList new];
    
    NSNumber *zeroValue = [NSNumber numberWithInt:0];
    NSNumber *oneValue = [NSNumber numberWithInt:1];
    NSNumber *twoValue = [NSNumber numberWithInt:2];
    
    // Make sure removing from an empty list doesn't crash
    [list removeObjectAtIndex:0];
    [list removeObjectAtIndex:1];
    [list removeObjectAtIndex:2];
    
    [list appendObject:zeroValue];
    
    // Make sure removing indices greater than the list size doesn't crash
    [list removeObjectAtIndex:1];
    XCTAssert((list.lengthOfList == 1), @"Removing a node at an invalid index should do nothing");
    [list removeObjectAtIndex:2];
    XCTAssert((list.lengthOfList == 1), @"Removing a node at an invalid index should do nothing");
    [list removeObjectAtIndex:0];
    XCTAssert((list.lengthOfList == 0), @"Removing the only node in a list should make an empty list");
    
    [list appendObject:zeroValue];
    [list appendObject:oneValue];
    [list removeObjectAtIndex:0];
    XCTAssert((list.lengthOfList == 1), @"Removing first node should decrement list size");
    [list removeObjectAtIndex:0];
    XCTAssert((list.lengthOfList == 0), @"Removing first node should decrement list size");
    
    [list appendObject:zeroValue];
    [list appendObject:oneValue];
    [list appendObject:twoValue];
    
    // Test removing the final value
    [list removeObjectAtIndex:2];
    XCTAssert((list.lengthOfList == 2), @"Removing the last node in a list should result in a list one smaller");
    XCTAssert([[list objectAtIndex:0] isEqual:[NSNumber numberWithInteger:0]], @"Removing the last node in a list should not effect the other values");
    XCTAssert([[list objectAtIndex:1] isEqual:[NSNumber numberWithInteger:1]], @"Removing the last node in a list should not effect the other values");
    
    // Test removing center value
    [list appendObject:twoValue];
    [list removeObjectAtIndex:1];
    XCTAssert((list.lengthOfList == 2), @"Removing a center node in a list should result in a list one smaller");
    XCTAssert([[list objectAtIndex:0] isEqual:[NSNumber numberWithInteger:0]], @"Removing a center node in a list should not effect the other values");
    XCTAssert([[list objectAtIndex:1] isEqual:[NSNumber numberWithInteger:2]], @"Removing a center node in a list should not effect the other values");
}

- (void)testInsertingValues {
    
    SinglyLinkedList *list = [SinglyLinkedList new];
    
    NSNumber *zeroValue = [NSNumber numberWithInt:0];
    NSNumber *oneValue = [NSNumber numberWithInt:1];
    NSNumber *twoValue = [NSNumber numberWithInt:2];
    
    [list insertObject:zeroValue
              atIndex:100];
    XCTAssert((list.lengthOfList == 1), @"Inserting a value at an index beyond the list length should append the value");
    XCTAssert([[list objectAtIndex:0] isEqual:[NSNumber numberWithInteger:0]], @"Inserting a value should not change its value");
    
    [list insertObject:twoValue
              atIndex:1];
    XCTAssert((list.lengthOfList == 2), @"Inserting a value at an index of the list length should append the value");
    XCTAssert([[list objectAtIndex:1] isEqual:[NSNumber numberWithInteger:2]], @"Inserting a value should not change its value");
    
    [list insertObject:oneValue
              atIndex:1];
    XCTAssert((list.lengthOfList == 3), @"Inserting a value at an index less than the length list should grow the list size");
    XCTAssert([[list objectAtIndex:1] isEqual:[NSNumber numberWithInteger:1]], @"Inserting a value should not change its value");
}

@end
