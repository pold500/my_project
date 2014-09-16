//
//  BookRecord.h
//  TheElements
//
//  Created by Developer on 05/09/14.
//
//

#import <Foundation/Foundation.h>

@interface BookRecord : NSObject

@property NSUInteger            record_id;
@property NSString*             name;
@property NSString*             second_name;
@property NSString*             phone_number;
@property NSMutableDictionary*  data;
@property NSIndexPath*          index_path;
- (id)initWithDictionary:(NSDictionary *)dictionary;
@end
