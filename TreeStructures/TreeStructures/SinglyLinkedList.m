//
//  SinglyLinkedList.m
//  TreeStructures
//
//  Created by Jeremy Conkin on 9/14/14.
//  Copyright (c) 2014 Jeremy Conkin. All rights reserved.
//

#import "SinglyLinkedList.h"

#import "Edge.h"
#import "Node.h"

@interface SinglyLinkedList ()

/** The node at the beginning of the linked list */
@property (strong, nonatomic) Node *startNode;

@end

@implementation SinglyLinkedList

- (NSUInteger)lengthOfList {
    
    NSUInteger numberOfChildren = 0;
    Node *currentNode = self.startNode;
    
    while (currentNode != nil) {
        
        currentNode = [SinglyLinkedList childNodeOfNode:currentNode];
        ++numberOfChildren;
    }
    
    return numberOfChildren;
}

- (void)appendObject:(id)value {
    
    Node *node = [[Node alloc] initWithObject:value];
    [self appendNode:node];
}

- (id)objectAtIndex:(NSUInteger)index {
    
    Node *nodeAtGivenIndex = [self nodeAtIndex:index];
    
    return nodeAtGivenIndex.object;
}

- (void)removeObjectAtIndex:(NSUInteger)index {
    
    // Find the the node to remove and its parent and child
    Node *previousNode = nil;
    Node *nodeToRemove = nil;
    if (index > 0) {
        
        previousNode = [self nodeAtIndex:(index - 1)];
        nodeToRemove = [SinglyLinkedList childNodeOfNode:previousNode];
    } else {
        
        nodeToRemove = self.startNode;
        self.startNode = [SinglyLinkedList childNodeOfNode:self.startNode];
    }
    
    Node *nextNode = [SinglyLinkedList childNodeOfNode:nodeToRemove];
    
    // Orphan the current and previous nodes
    [previousNode removeAllOutgoingEdges];
    [nodeToRemove removeAllOutgoingEdges];
    
    if ((previousNode != nil)
        && (index > 0)) {
        
        [Edge connectNode:previousNode
                   toNode:nextNode
                 withCost:0
        withBidirectional:NO];
    }
}

- (void)insertObject:(id)object
            atIndex:(NSUInteger)index {
    
    if (index >= self.lengthOfList) {
        
        [self appendObject:object];
        return;
    }
    
    Node *parentNode = [self nodeAtIndex:(index - 1)];
    Node *nextNode = [SinglyLinkedList childNodeOfNode:parentNode];
    Node *nodeToInsert = [[Node alloc] initWithObject:object];
    
    // Point the parent node to the new node
    [parentNode removeAllOutgoingEdges];
    [Edge connectNode:parentNode
               toNode:nodeToInsert
             withCost:0
    withBidirectional:NO];
    
    // Point the new node to the child
    [Edge connectNode:nodeToInsert
               toNode:nextNode
             withCost:0
    withBidirectional:NO];
    
}

- (NSString *)description {
    
    NSString *descriptionString = [NSString stringWithFormat:@"Length :%lu\n", (unsigned long)self.lengthOfList];
    
    Node *currentNode = self.startNode;
    while (currentNode != nil) {
        
        NSString *nodeDescription = [NSString stringWithFormat:@"%@->", currentNode.object];
        descriptionString = [descriptionString stringByAppendingString:nodeDescription];
        currentNode = [SinglyLinkedList childNodeOfNode:currentNode];
    }
    descriptionString = [descriptionString stringByAppendingString:@"nil"];
    
    return descriptionString;
}

#pragma mark - Private methods

/**
 *  Get the node at the given index in the set
 *
 *  @param index  Position in the list.
 *
 *  @return The node at the given index. May be nil.
 */
- (Node *)nodeAtIndex:(NSUInteger)index {
    
    NSUInteger currentIndex = 0;
    Node *currentNode = self.startNode;
    
    while (currentIndex < index) {
        
        currentNode = [SinglyLinkedList childNodeOfNode:currentNode];
        if (currentNode == nil) {
            
            break;
        }
        ++currentIndex;
    }
    
    return currentNode;
}

/**
 *  Add an child node to the last node in the list
 *
 *  @param node  Node to append to this list
 */
- (void)appendNode:(Node *)node {
    
    // Handle the case of an empty list
    if (self.startNode == nil) {
        
        self.startNode = node;
        return;
    }
    
    // Find the last node
    Node *lastNode = self.startNode;
    Node *nextNode = [SinglyLinkedList childNodeOfNode:lastNode];
    
    while (nextNode != nil) {
        
        lastNode = nextNode;
        nextNode = [SinglyLinkedList childNodeOfNode:nextNode];
    }
    
    [Edge connectNode:lastNode
               toNode:node
             withCost:0
    withBidirectional:NO];
}

/**
 * Find the next node in the list from the input node
 *
 * @param parentNode  Input node for which we want the child
 *
 * @return The next node in the list after parentNode. May be nil.
 */
+ (Node *)childNodeOfNode:(Node *)parentNode {
    
    Edge *outgoingEdge = [parentNode.outgoingEdges anyObject];
    return (outgoingEdge != nil) ? outgoingEdge.endNode : nil;
}

@end
