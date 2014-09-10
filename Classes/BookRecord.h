//
//  BookRecord.h
//  TheElements
//
//  Created by Developer on 05/09/14.
//
//

#import <Foundation/Foundation.h>

@interface BookRecord : NSObject

@property NSString* name;
@property NSString* second_name;
@property NSString* phoneNumber;

- (id)initWithDictionary:(NSDictionary *)dictionary;
@end
