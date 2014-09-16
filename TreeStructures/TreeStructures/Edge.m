//
//  Edge.m
//  TreeStructures
//
//  Created by Jeremy Conkin on 9/6/14.
//  Copyright (c) 2014 Jeremy Conkin. All rights reserved.
//

#import "Edge.h"

#import "Node.h"

@interface Edge ()

/** The node at the start (tail) of this edge */
@property (strong, nonatomic) Node *startNode;

/** The node at the end (tip) of this edge */
@property (strong, nonatomic) Node *endNode;

/** How much a traversal algorithm pays to traverse this edge */
@property (assign, nonatomic) NSUInteger cost;

/**
 * When YES, start and end nodes are no different. Both ends of this edge
 * function as a tip and a tail.
 */
@property (assign, nonatomic) BOOL bidirectional;

@end

@implementation Edge

#ifdef DEBUG
- (instancetype)init {
    
    self = [super init];
    
    ++edgeInstanceCount;
    
    return self;
}
#endif //DEBUG

+ (void)connectNode:(Node *)startNode
             toNode:(Node *)endNode
           withCost:(NSUInteger)cost
  withBidirectional:(BOOL)biDirectional {

    Edge *edge __unused = [[Edge alloc] initWithStartNode:startNode
                                     withEndNode:endNode
                                        withCost:cost
                               withBidirectional:biDirectional];
}

- (instancetype)initWithStartNode:(Node *)startNode
                      withEndNode:(Node *)endNode
                         withCost:(NSUInteger)cost
                withBidirectional:(BOOL)bidirectional {
    
    self = [self init];
    
    if (self) {
        
        _startNode = startNode;
        _endNode = endNode;
        _cost = cost;
        _bidirectional = bidirectional;
        
        // Add outgoing edges
        [_startNode addOutgoingEdge:self];
        if (bidirectional) {
            [_endNode addOutgoingEdge:self];
        }
    }
    
    return self;
}

- (NSString *)description {
    
    return [NSString stringWithFormat:@"Start Node: %@\n  End Node: %@\n  Cost: %lu  Biderctional: %d", self.startNode, self.endNode, (unsigned long)self.cost, self.bidirectional];
}

#ifdef DEBUG
- (void)dealloc {
    
    --edgeInstanceCount;
}
#endif //DEBUG

@end
