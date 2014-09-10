//
//  SingleRecordSingleton.h
//  TheElements
//
//  Created by Pavel on 9/10/14.
//
//

#import <Foundation/Foundation.h>
#import "BookRecord.h"

@interface SingleRecordSingleton : NSObject

@property (nonatomic, strong) BookRecord* data;

+(SingleRecordSingleton*)getData;

@end
