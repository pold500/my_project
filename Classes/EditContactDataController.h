//
//  EditContactDataController.h
//  TheElements
//
//  Created by Developer on 09/09/14.
//
//

#import <UIKit/UIKit.h>

@interface EditContactDataController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *nameLabelOutlet;
@property (weak, nonatomic) IBOutlet UITextField *secondNameLabelOutlet;
@property (weak, nonatomic) IBOutlet UITextField *phoneNumberLabelOutlet;
- (IBAction)doneButtonAction:(id)sender;

@end
