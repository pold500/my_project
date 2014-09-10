//
//  EditTableRootController.h
//  TheElements
//
//  Created by Developer on 09/09/14.
//
//

#import <UIKit/UIKit.h>

@interface EditTableRootController : UIViewController<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) NSArray *dataStore;
@end

