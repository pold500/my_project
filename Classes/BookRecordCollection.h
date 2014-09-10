//
//  BookRecordCollection.h
//  TheElements
//
//  Created by Developer on 05/09/14.
//
//

#import <Foundation/Foundation.h>

@interface BookRecordCollection : NSObject

@property (nonatomic, strong) NSMutableArray      *recordsArray;

@property (nonatomic, strong) NSArray *recordsNameIndexArray;
@property (nonatomic, strong) NSArray *recordsSortedByName;

@property (nonatomic, strong) NSDictionary* recordsDictionary;

+ (BookRecordCollection*)getBookRecordCollection;
@end
