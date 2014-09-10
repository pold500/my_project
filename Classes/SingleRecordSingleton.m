//
//  SingleRecordSingleton.m
//  TheElements
//
//  Created by Pavel on 9/10/14.
//
//

#import "SingleRecordSingleton.h"

@implementation SingleRecordSingleton

static SingleRecordSingleton *sharedInstance = nil;

- (instancetype)init
{
    self = [super init];
    if (self) {
        _data = nil;
    }
    return self;
}

+(SingleRecordSingleton*)getData
{
    @synchronized(self) {
        static dispatch_once_t pred;
        dispatch_once(&pred, ^{ sharedInstance = [[self alloc] init]; });
    }
    return sharedInstance;
}

@end
