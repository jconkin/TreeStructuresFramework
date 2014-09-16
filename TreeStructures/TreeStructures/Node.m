//
//  Node.m
//  TreeStructures
//
//  Created by Jeremy Conkin on 9/6/14.
//  Copyright (c) 2014 Jeremy Conkin. All rights reserved.
//

#import "Node.h"

@interface Node ()

/** All edges serving as exits from this node */
@property (strong, nonatomic) NSMutableSet *outgoingEdges;

/** NSNumber, location, etc. Whatever concrete value this node represents. */
@property (strong, nonatomic) id object;

@end

@implementation Node

- (instancetype)init {
    
    self = [super init];
    
    if (self) {
        
        _outgoingEdges = [NSMutableSet new];
    }
    
    return self;
}

- (instancetype)initWithObject:(id)object {
    
    self = [self init];
    
    if (self) {
        
        _object = object;
    }
    
    return self;
}

- (NSString *)description {
    
    return [NSString stringWithFormat:@"Value: %@", self.object];
}

- (NSComparisonResult)compare:(Node *)otherNode {
    
    NSAssert([self.object respondsToSelector:@selector(compare:)], @"Object types for a node should implement compare:");
    
    return [self.object compare:otherNode.object];
}

- (void)addOutgoingEdge:(Edge *)outgoingEdge {
    
    NSAssert(self.outgoingEdges != nil, @"Set of outgoing edges should be initialized before adding to it.");
    NSAssert([self.outgoingEdges isKindOfClass:[NSMutableSet class]], @"A node's set of outgoing edges should be mutable");
    [(NSMutableSet *)(self.outgoingEdges) addObject:outgoingEdge];
}

- (void)removeOutgoingEdge:(Edge *)edgeToRemove {

    NSAssert(self.outgoingEdges != nil, @"Set of outgoing edges should be initialized before removing from it.");
    NSAssert([self.outgoingEdges isKindOfClass:[NSMutableSet class]], @"A node's set of outgoing edges should be mutable");
    [(NSMutableSet *)(self.outgoingEdges) removeObject:edgeToRemove];
}

- (void)removeAllOutgoingEdges {
    
    NSAssert(self.outgoingEdges != nil, @"Set of outgoing edges should be initialized before removing from it.");
    [(NSMutableSet *)(self.outgoingEdges) removeAllObjects];
}

@end
