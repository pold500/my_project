//
//  BookRecord.m
//  TheElements
//
//  Created by Developer on 05/09/14.
//
//

#import "BookRecord.h"

@implementation BookRecord

- (id)initWithDictionary:(NSDictionary *)dictionary
{

    if (self) {
		self.name        = [dictionary valueForKey:@"Name"         ];
		self.second_name = [dictionary valueForKey:@"Second Name"  ];
        self.phoneNumber = [dictionary valueForKey:@"Phone Number" ];
	}
	return self;
}


@end


//#import <Foundation/Foundation.h>
//
//@interface AtomicElement : NSObject
//
//@property (nonatomic, strong) NSNumber *atomicNumber;
//@property (nonatomic, strong) NSString *name;
//@property (nonatomic, strong) NSString *symbol;
//@property (nonatomic, strong) NSString *state;
//@property (weak, readonly) UIImage *flipperImageForAtomicElementNavigationItem;
//@property (weak, readonly) UIImage *stateImageForAtomicElementTileView;
//@property (weak, readonly) UIImage *stateImageForAtomicElementView;
//@property (nonatomic, strong) NSString *atomicWeight;
//@property (nonatomic, strong) NSNumber *group;
//@property (nonatomic, strong) NSNumber *period;
//@property (nonatomic, strong) NSString *discoveryYear;
//
//- (id)initWithDictionary:(NSDictionary *)aDictionary;

