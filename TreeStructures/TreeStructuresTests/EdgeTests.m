//
//  EdgeTests.m
//  TreeStructures
//
//  Created by Jeremy Conkin on 9/8/14.
//  Copyright (c) 2014 Jeremy Conkin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>

#import "Edge.h"
#import "Node.h"

@interface EdgeTests : XCTestCase

@end

@implementation EdgeTests

/**
 * Make sure one-way edges only add outgoing edges to one node
 */
- (void)testUnidirectionalEdges {
    
    Node *nodeA = [[Node alloc] initWithObject:[NSNumber numberWithInteger:0]];
    Node *nodeB = [[Node alloc] initWithObject:[NSNumber numberWithInteger:1]];
    
    [Edge connectNode:nodeA
               toNode:nodeB
             withCost:1
    withBidirectional:NO];
    
    // Nodes may have edges added
    XCTAssert((nodeA.outgoingEdges.count == 1), @"Outgoing edges should be added to nodes");
    // When a one way node is added, the receiving node has no increase in outgoing edges
    XCTAssert((nodeB.outgoingEdges.count == 0), @"Incoming one directional edges should not be added to nodes");
}

/**
 * Make sure two-way edges only add outgoing edges to two nodes
 */
- (void)testBidirectionalEdges {
    
    Node *nodeA = [[Node alloc] initWithObject:[NSNumber numberWithInteger:0]];
    Node *nodeB = [[Node alloc] initWithObject:[NSNumber numberWithInteger:1]];
    
    [Edge connectNode:nodeA
               toNode:nodeB
             withCost:1
    withBidirectional:YES];
    
    // Nodes may have edges added
    XCTAssert((nodeA.outgoingEdges.count == 1), @"Outgoing edges should be added to nodes");
    // Bidirectional edges are added to both nodes
    XCTAssert((nodeB.outgoingEdges.count == 1), @"Incoming one directional edges should not be added to nodes");
}

/**
 * Make sure that edges do not stay in memory when removed from all nodes
 */
- (void)testCircularReferences {
    
    Node *nodeA = [[Node alloc] initWithObject:[NSNumber numberWithInteger:0]];
    Node *nodeB = [[Node alloc] initWithObject:[NSNumber numberWithInteger:1]];
    Edge *edge = [[Edge alloc] initWithStartNode:nodeA
                                     withEndNode:nodeB
                                        withCost:1
                               withBidirectional:NO];
    [nodeA removeOutgoingEdge:edge];
    edge = nil;
    
#ifdef DEBUG
    XCTAssert((nodeB.outgoingEdges.count == 0), @"Incoming one directional edges should not be added to nodes");
#endif //DEBUG
}

@end
