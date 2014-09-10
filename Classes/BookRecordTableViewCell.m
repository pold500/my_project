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
	
    [self.textLabel setText: _record.name ];
    [self.detailTextLabel setText: _record.second_name ];
    
	//UILabel *labelView = (UILabel *)[self.contentView viewWithTag:2];
    //labelView.text = _record.name;
    
	//[elementTileView setNeedsDisplay];
	//[labelView setNeedsDisplay];
}

@end
