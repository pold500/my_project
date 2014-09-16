//
//  EditContactDataController.h
//  TheElements
//
//  Created by Developer on 09/09/14.
//
//

#import <UIKit/UIKit.h>
@class BookRecord;

@interface EditContactDataController : UIViewController <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *nameLabelOutlet;
@property (weak, nonatomic) IBOutlet UITextField *secondNameLabelOutlet;
@property (weak, nonatomic) IBOutlet UITextField *phoneNumberLabelOutlet;

- (IBAction)doneButtonAction:(id)          sender;

@property (nonatomic, strong) BookRecord   * record;
@property (nonatomic, strong) NSIndexPath  * path;

@end
