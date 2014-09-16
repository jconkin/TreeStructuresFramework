//
//  AncestorNode.m
//  TreeStructures
//
//  Created by Jeremy Conkin on 9/14/14.
//  Copyright (c) 2014 Jeremy Conkin. All rights reserved.
//

#import "AncestorNode.h"

@interface AncestorNode ()

/** Node that serves as this node's parent */
@property (strong, nonatomic) AncestorNode *parentNode;

/** Children of which this node is a parent */
@property (strong, nonatomic) NSMutableOrderedSet *childrenNodes;

@end

@implementation AncestorNode

- (instancetype)init {
    
    self = [super init];
    
    if (self) {
        
        _childrenNodes = [NSMutableOrderedSet new];
    }
    
    return self;
}

- (instancetype)initWithParent:(AncestorNode *)parentNode {
    
    self = [self init];
    
    if (self) {
        
        _parentNode = parentNode;
    }
    
    return self;
}

- (AncestorNode *)addChild {
    
    AncestorNode *childNode = [[AncestorNode alloc] initWithParent:self];
    [(NSMutableOrderedSet *)(self.childrenNodes) addObject:childNode];
    
    return childNode;
}

- (void)removeChild:(AncestorNode *)childNode {
    
    [(NSMutableOrderedSet *)(self.childrenNodes) removeObject:childNode];
}

@end
