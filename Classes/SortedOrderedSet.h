//
//  RecordsSortByNameProxy.h
//  AddressBook
//
//  Created by Pavel on 9/16/14.
//
//

#import <Foundation/Foundation.h>

@interface SortedOrderedSet : NSObject

- (void)addObject:(id)object;
- (id  )initWithObject:(id)object;
- (void)insertObject:(id)object atIndex:(NSUInteger)idx;
- (void)removeObjectAtIndex:(NSUInteger)idx;
- (void)replaceObjectAtIndex:(NSUInteger)idx withObject:(id)object;
- (void)setObject:(id)obj atIndex:(NSUInteger)idx;
- (void)removeObject:(id)object;

@end
