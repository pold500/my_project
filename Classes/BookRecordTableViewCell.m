//
//  BookRecordTableViewCell.m
//  TheElements
//
//  Created by Developer on 08/09/14.
//
//

#import "BookRecordTableViewCell.h"
#import "BookRecord.h"

@implementation BookRecordTableViewCell


// the element setter
- (void)setElement:(BookRecord *)aRecord {
    
    if (aRecord != _record) {
		_record = aRecord;
	}
    
	UILabel *namelabelView = (UILabel *)[self.contentView viewWithTag:1];
    namelabelView.text = _record.name;
    [namelabelView setNeedsDisplay];
    
    UILabel *phoneNumber = (UILabel *)[self.contentView viewWithTag:2];
    phoneNumber.text = _record.phone_number;
    [phoneNumber setNeedsDisplay];
}

@end
