//
//  BookRecordViewController.m
//  TheElements
//
//  Created by Developer on 08/09/14.
//
//

#import "BookRecordDetailedViewController.h"
#import "BookRecordDetailedView.h"

//@class BookRecordView; //forward declaration

//private interface declaration
//@interface BookRecordDetailedViewController()
//
//@property (nonatomic, strong) BookRecordView *elementView;
//
//@synthesize record = _record;
////-(void)setRecord:(BookRecord*)record;
//
//@end

#import "SingleRecordSingleton.h"

@interface BookRecordDetailedViewController()
- (void) goToEditContact;
@end

@implementation BookRecordDetailedViewController

@synthesize record                      = _record;
@synthesize nameLabelOutlet             = _nameLabelOutlet;
@synthesize secondNameLabelOutlet       = _secondNameLabelOutlet;
@synthesize phoneNumberLabelOutlet      = _phoneNumberOutlet;

- (IBAction)editButtonTouchedDown:(id)sender
{
    //perfrom a transition? through a segue?
    //pass the record to the newly created uiview and\or controller
    //so it can modify it and bring back here
    [self goToEditContact];
}

-(void)setRecord:(BookRecord*)record
{
    _record = record;
    SingleRecordSingleton.getData.data = _record;
}


- (void) goToEditContact
{
    id wc = [[UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil]
              instantiateViewControllerWithIdentifier:@"EditContactDataID"];
    [self.navigationController pushViewController:wc animated:YES];
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [[self nameLabelOutlet        ] setText: _record.name        ];
    [[self secondNameLabelOutlet  ] setText: _record.second_name ];
    [[self phoneNumberLabelOutlet ] setText: _record.phoneNumber ];
    [[self editButtonOutlet       ] setTitle:@"Edit" forState:UIControlStateNormal  ];
    
}


- (void)myTransitionDidStop:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context {
    
	// re-enable user interaction when the flip animation is completed
	self.view.userInteractionEnabled = YES;
	
}

@end
