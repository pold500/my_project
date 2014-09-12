//
//  EditContactDataController.m
//  TheElements
//
//  Created by Developer on 09/09/14.
//
//

#import "EditContactDataController.h"
#import "SingleRecordSingleton.h"
#import "BookRecord.h"
#import <FacebookSDK/FacebookSDK.h>


@interface EditContactDataController ()
@property (nonatomic, strong) BookRecord* data;
@end

@implementation EditContactDataController

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        
    }
    return self;
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _data =                     [[SingleRecordSingleton getData] data ];
    [_nameLabelOutlet           setText:_data.name        ];
    [_secondNameLabelOutlet     setText:_data.second_name ];
    [_phoneNumberLabelOutlet    setText:_data.phoneNumber ];
    

    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)doneButtonAction:(id)sender {
    _data.name = _nameLabelOutlet.text;
    _data.second_name = _secondNameLabelOutlet.text;
    _data.phoneNumber = _phoneNumberLabelOutlet.text;
    SingleRecordSingleton.getData.data = _data;
    [[self navigationController ] popToRootViewControllerAnimated:YES];
    
}

-(void)viewDidUnload
{
    
}

@end
