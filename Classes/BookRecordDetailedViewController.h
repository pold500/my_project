//
//  BookRecordViewController.h
//  TheElements
//
//  Created by Developer on 08/09/14.
//
//
//  Detailed page of the each contact
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class BookRecord;


// This guy represents the detailed view for each contact in a book
//
//
@interface BookRecordDetailedViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *nameLabelOutlet;
@property (weak, nonatomic) IBOutlet UILabel *secondNameLabelOutlet;
@property (weak, nonatomic) IBOutlet UILabel *phoneNumberLabelOutlet;
@property (weak, nonatomic) IBOutlet UIButton *editButtonOutlet;

@property (nonatomic, strong) BookRecord        *record;

- (IBAction)editButtonTouchedDown:(id)sender;


- (void)setRecord:(BookRecord *)record;
- (void)goToEditContact;

@end
