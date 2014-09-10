//
//  BookRecordDataProtocol.h
//  TheElements
//
//  Created by Developer on 08/09/14.
//
//

#import <Foundation/Foundation.h>
#import "BookRecord.h"

@protocol BookRecordDataProtocol <NSObject>

@required

// these properties are used by the view controller
// for the navigation and tab bar
@property (readonly) NSString *name;
@property (readonly) NSString *navigationBarName;

// this property determines the style of table view displayed
@property (readonly) UITableViewStyle tableViewStyle;

// provides a standardized means of asking for the element at the specific
// index path, regardless of the sorting or display technique for the specific
// datasource
- (BookRecord *)bookRecordForIndexPath:(NSIndexPath *)indexPath;

@optional

// this optional protocol allows us to send the datasource this message, since it has the
// required information
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section;

@end
