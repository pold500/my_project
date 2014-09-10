//
//  EditContactDataController.h
//  TheElements
//
//  Created by Developer on 09/09/14.
//
//

#import <UIKit/UIKit.h>
#import "BookRecordDataProtocol.h"

@interface EditContactDataController : UIViewController
@property (nonatomic,strong) id<BookRecordDataProtocol, UITableViewDataSource> dataSource;
@end
