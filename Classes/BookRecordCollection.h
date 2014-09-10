//
//  BookRecordCollection.h
//  TheElements
//
//  Created by Developer on 05/09/14.
//
//

#import <Foundation/Foundation.h>

@interface BookRecordCollection : NSObject

@property (nonatomic, strong) NSMutableDictionary *namesDictionary;
@property (nonatomic, strong) NSMutableDictionary *phonesDictionary;
@property (nonatomic, strong) NSMutableArray *recordsArray;
@property (nonatomic, strong) NSArray *recordsNameIndexArray;
@property (nonatomic, strong) NSArray *recordsSortedByNumber;
@property (nonatomic, strong) NSArray *recordsSortedBySecondName;
@property (nonatomic, strong) NSArray *recordsSortedByName;

+ (BookRecordCollection*)getBookRecordCollection;
@end
