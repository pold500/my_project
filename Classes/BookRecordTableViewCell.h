//
//  BookRecordTableViewCell.h
//  TheElements
//
//  Created by Developer on 08/09/14.
//
//

#import <Foundation/Foundation.h>

@class BookRecord;

@interface BookRecordTableViewCell : UITableViewCell

@property (nonatomic, strong, setter = setElement:) BookRecord *record;

- (void)setElement:(BookRecord *)aRecord;

@end
