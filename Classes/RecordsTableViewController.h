//
//  RecordsTableViewController.h
//  TheElements
//
//  Created by Developer on 08/09/14.
//
//

#import <UIKit/UIKit.h>
#import "BookRecordDataProtocol.h"

@interface RecordsTableViewController : UITableViewController

@property (nonatomic,strong) id<BookRecordDataProtocol, UITableViewDataSource> dataSource;

@end
