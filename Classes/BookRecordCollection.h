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
@property (nonatomic, strong) NSMutableArray      *recordsArrayById;
@property (nonatomic, strong) NSMutableDictionary *idToIndexPath;

- (void)setBookRecordForIndexPath:(NSIndexPath*)indexPath
                          record: (BookRecord*) bookRecord_;

+ (BookRecordCollection*)getInstance;
@end
