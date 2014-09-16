//
//  RecordsSortByNameProxy.m
//  AddressBook
//
//  Created by Pavel on 9/16/14.
//
//

#import "SortedOrderedSet.h"
#import "BookRecord.h"

@interface SortedOrderedSet()
@property (strong, nonatomic) NSMutableOrderedSet* records;
@end

@implementation SortedOrderedSet

-(void)removeObjectAtIndex:(NSUInteger)index
{
    [self.records removeObjectAtIndex:index];
}

- (id)initWithObject:(id)object
{
    self = [super init];

    self.records = [[NSMutableOrderedSet alloc] initWithObject:object ];

    return self;
}

-(void)addObject:(id)object
{
    [self.records addObject:object];
    [self.records sortUsingComparator:^NSComparisonResult(BookRecord* obj1, BookRecord* obj2) {
        return [obj1.name localizedCaseInsensitiveCompare:obj2.name];
    }];
}

-(id)objectAtIndex:(NSUInteger)idx
{
    return [self.records objectAtIndex:idx];
}


-(id)init
{

    self = [super init];
    {
        //custom init...
        self.records = [[NSMutableOrderedSet alloc] init];
    }
    return self;
}

-(NSUInteger) count
{
    return [self.records count];
}



@end
