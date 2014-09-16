//
//  EditContactDataController.m
//  TheElements
//
//  Created by Developer on 09/09/14.
//
//

#import "EditContactDataController.h"
#import "BookRecord.h"
#import "BookRecordCollection.h"
#import <FacebookSDK/FacebookSDK.h>
#import "TextFiledInputDelegate.h"


@interface EditContactDataController ()

@end

@implementation EditContactDataController

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
    }
    return self;
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    if(self.viewState==ADD)
    {
        if(self.record==nil)
            self.record = [[BookRecord alloc] init];
    }

    [_nameLabelOutlet           setText:_record.name         ];
    [_secondNameLabelOutlet     setText:_record.second_name  ];
    [_phoneNumberLabelOutlet    setText:_record.phone_number ];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    //Do nothing.
    //We save only on 'Done' button click
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.nameLabelOutlet        .delegate = [TextFiledInputDelegate getInstance];
    self.secondNameLabelOutlet  .delegate = [TextFiledInputDelegate getInstance];
    self.phoneNumberLabelOutlet .delegate = self;

    [_nameLabelOutlet           setText:_record.name        ];
    [_secondNameLabelOutlet     setText:_record.second_name ];
    [_phoneNumberLabelOutlet    setText:_record.phone_number ];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



/**
 *
 * Method used to validate data in a phoneNumber UITextEdit element on the 
 * edit contact form
 *
 *
 * @param  dataToValidate NSString passed from UI control element, in our case
 *         it's a phone number
 * @return YES if validation was passed and data is sane, NO otherwise.
 */
- (BOOL)validatePhoneNumber:(NSString*)dataToValidate
{
    NSError *error = nil;
    
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"[^0-9.]"
                                  options:NSRegularExpressionCaseInsensitive
                                  error:&error];
    NSUInteger numberOfMatches = [regex  numberOfMatchesInString:dataToValidate
                                                           options:0
                                                             range:NSMakeRange(0, [dataToValidate length])];
    return (numberOfMatches>0)?NO:YES;
}

-(BOOL)validateInputFields:(NSString*)name
                  secondName:(NSString*)secondName
                 phoneNumber:(NSString*)phoneNumber
{
    BOOL retValue = NO;
    if (![name isEqualToString:@""]&&
        ![secondName isEqualToString:@""]&&
        ![phoneNumber isEqualToString:@""]&&
        [self validatePhoneNumber:phoneNumber]) {
        retValue = YES;
    }
    return retValue;
}

- (IBAction)doneButtonAction:(id)sender {
    //Validation comes first
    if([self validatePhoneNumber:self.phoneNumberLabelOutlet.text])
    {
        //Validation of phone number went successful
         //Save data to model
        _record.name            = self.nameLabelOutlet       .text;
        _record.second_name     = self.secondNameLabelOutlet .text;
        _record.phone_number    = self.phoneNumberLabelOutlet.text;

        if(self.viewState==EDIT)
        {
            if([_record.name substringToIndex:1] != [self.nameLabelOutlet.text substringToIndex:1])
            {   //first letter of the name has changed
                [[BookRecordCollection getInstance] setBookRecordForIndexPath:self.path record:_record];
                [[self navigationController] popViewControllerAnimated:YES];
            }
        } else {
            if([self validateInputFields:_record.name secondName:_record.second_name
                             phoneNumber:_record.phone_number])
            {
                [[BookRecordCollection getInstance] insertNewRecord:_record];
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Woohoo!" message:
                            @"New record added!"
                            delegate:nil cancelButtonTitle:@"Ok"
                            otherButtonTitles:nil, nil];
                [alert show];
                [[self navigationController] popViewControllerAnimated:YES];
            }
            else {
                //validation not passed
                //Show error message
                UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Error!"
                message:@"You've entered invalid data. Please check that all fields is filled with data and "
                        @"phone number contains only digits"
                delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
                [alert show];
            }
        }
        

    }
    else
    {
        //Validation failed
        //Show error message to a user
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                             message:@"Oops! You can use only digits in a phone number"
                             delegate:nil cancelButtonTitle:@"OK!" otherButtonTitles:nil, nil];
        [alert show];
    }
    
}

#pragma mark UITextFieldDelegate

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [self animateTextField: textField up: YES];
}


- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [self animateTextField: textField up: NO];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (void) animateTextField: (UITextField*) textField up: (BOOL) up
{
    const int   movementDistance = 100; // tweak as needed
    const float movementDuration = 0.3f; // tweak as needed

    int movement = (up ? -movementDistance : movementDistance);

    [UIView beginAnimations: @"anim" context: nil];
    [UIView setAnimationBeginsFromCurrentState: YES];
    [UIView setAnimationDuration: movementDuration];
    self.view.frame = CGRectOffset(self.view.frame, 0, movement);
    [UIView commitAnimations];
}

@end
