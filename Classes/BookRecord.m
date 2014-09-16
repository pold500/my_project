//
//  BookRecord.m
//  TheElements
//
//  Created by Developer on 05/09/14.
//
//

#import "BookRecord.h"

@interface BookRecord()
+ (int)count;
@end

static int theCount = 0;





@implementation BookRecord

- (BOOL)isEqual:(id)object {
    return self.record_id == ((BookRecord*)object).record_id;
}

- (NSUInteger)hash {
    return self.record_id; // if the only field to determine uniqueness is `identifier`, this hashing method is enough
}


+ (int) count { return theCount; }

- (id)initWithDictionary:(NSDictionary *)dictionary
{

    if (self) {
        self.record_id     = [BookRecord count];
        theCount++;
		self.name          = [dictionary valueForKey:@"Name"         ];
		self.second_name   = [dictionary valueForKey:@"Second Name"  ];
        self.phone_number  = [dictionary valueForKey:@"Phone Number" ];
        self.data          = dictionary.copy;
	}
	return self;
}


@end

