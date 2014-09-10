//
//  RecordsSortedByName.h
//  TheElements
//
//  Created by Developer on 08/09/14.
//
//

#import <Foundation/Foundation.h>
#import "BookRecordDataProtocol.h"

@interface RecordsSortedByNameDataSource : NSObject <UITableViewDataSource, BookRecordDataProtocol>
@property (nonatomic, strong) NSArray *titlesForIndexSections;

@end
