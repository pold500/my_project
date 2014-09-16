//
//  BookRecordCollection.h
//  TheElements
//
//  Created by Developer on 05/09/14.
//
//

#import <Foundation/Foundation.h>
@class BookRecord;

@interface BookRecordCollection : NSObject


@property (nonatomic, strong) NSArray             *recordsNameIndexArray;
@property (nonatomic, strong) NSDictionary        *recordsDictionary;

- (void)setBookRecordForIndexPath:(NSIndexPath*)indexPath
                           record: (BookRecord*) bookRecord;

- (void)insertNewRecord:   (BookRecord*) record;
- (NSArray*)recordsNameIndexArray;

+ (NSUInteger)              getNewRecordID;
+ (BookRecordCollection*)getInstance;

@end
