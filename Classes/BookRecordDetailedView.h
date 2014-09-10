//
//  BookRecordView.h
//  TheElements
//
//  Created by Developer on 08/09/14.
//
//

#import <UIKit/UIKit.h>
#import "BookRecord.h"
#import "RecordsTableViewController.h"

@interface BookRecordDetailedView : UIView
@property (nonatomic, strong ) BookRecord                 *element;
@property (nonatomic, weak   ) RecordsTableViewController *viewController;
@end

