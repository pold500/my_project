//
//  BookRecordViewController.m
//  TheElements
//
//  Created by Developer on 08/09/14.
//
//

#import "BookRecordDetailedViewController.h"
#import "BookRecordDetailedView.h"
#import "BookRecordCollection.h"
#import <FacebookSDK/FacebookSDK.h>
#import "EditContactDataController.h"

@interface BookRecordDetailedViewController()
- (void) goToEditContact;
@end

@implementation BookRecordDetailedViewController

- (IBAction)editButtonTouchedDown:(id)sender
{
    [self goToEditContact];
}

- (void) goToEditContact
{
    id wc = [[UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil]
             instantiateViewControllerWithIdentifier:@"EditContactDataID"];
    
    [((EditContactDataController*)wc) setRecord: self.record ];
    [((EditContactDataController*)wc) setPath  : self.path   ];
    [((EditContactDataController*)wc) setViewState:EDIT      ];
    [self.navigationController pushViewController:wc animated:YES];
}

- (void)viewDidLoad {
    //Init all displayable data here
    [super viewDidLoad];

    [[self nameLabelOutlet        ] setText : _record.name         ];
    [[self secondNameLabelOutlet  ] setText : _record.second_name  ];
    [[self phoneNumberLabelOutlet ] setText : _record.phone_number ];
    [[self editButtonOutlet       ] setTitle:@"Edit"
                                    forState:UIControlStateNormal ];
 
}

-(void)viewWillAppear:(BOOL)animated
{
    //restore state
    [super viewWillAppear:animated];
    [[self nameLabelOutlet        ] setText: _record.name        ];
    [[self secondNameLabelOutlet  ] setText: _record.second_name ];
    [[self phoneNumberLabelOutlet ] setText: _record.phone_number];
    
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)myTransitionDidStop:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context {
 	// re-enable user interaction when the flip animation is completed
	self.view.userInteractionEnabled = YES;
}
/*
* Request a publish permissions form a Facebook
*
*
*
*
*/
-(void)askForPermissionsAndPost
{
    // Request publish_actions
    __block BOOL result = NO;
    dispatch_async(dispatch_get_global_queue(0, 0), ^{

        dispatch_async(dispatch_get_main_queue(), ^{

        });
    });
    [FBSession.activeSession requestNewPublishPermissions:[NSArray arrayWithObject:@"publish_actions"]
                             defaultAudience  :FBSessionDefaultAudienceFriends
                             completionHandler:^(FBSession *session, NSError *error) {
                                __block NSString *alertText;
                                __block NSString *alertTitle;
                                if (!error) {
                                    if ([FBSession.activeSession.permissions
                                         indexOfObject:@"publish_actions"   ] == NSNotFound) {
                                        // Permission not granted, tell the user we will not publish
                                        alertTitle = @"Permission not granted";
                                        alertText  = @"Your action will not be published to Facebook.";
                                        [[[UIAlertView alloc] initWithTitle:alertTitle
                                                              message      :alertText
                                                              delegate     :self
                                                              cancelButtonTitle:@"OK!"
                                                              otherButtonTitles:nil] show];
                                    } else {
                                        // Permission granted, publish the OpenGraph story
                                        [self addPostToAFacebook];
                                        result = YES;
                                    }
                                    
                                } else {
                                    // There was an error, handle it
                                    // See https://developers.facebook.com/docs/ios/errors/
                                    result = NO;
                                }
                            }];

}

-(void)handleError:(NSError*)error
{

}

-(void)checkPermissionsAndPublishStory
{
    // Check for publish permissions
    [FBRequestConnection startWithGraphPath:@"/me/permissions"
                 completionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
                      if (!error){
                          NSDictionary *permissions= [(NSArray *)[result record] objectAtIndex:0];
                          if (![permissions objectForKey:@"publish_actions"]){
                              // Publish permissions not found, ask for publish_actions
                              [self askForPermissionsAndPost];
                          }
                          
                      } else {
                          // There was an error, handle it
                          // See https://developers.facebook.com/docs/ios/errors/
                          [self handleError:error];
                      }
                  }];
}

-(void) postCompletionHandler:(FBRequestConnection *)connection result:(id) result
                        error:(NSError*)error
{
    if (!error) {
        // Link posted successfully to Facebook
        NSLog(@"result: %@", result);
        dispatch_async(dispatch_get_main_queue(), ^{
                UIAlertView *successAlert = [[UIAlertView alloc]
                                             initWithTitle:@"FB Success!"
                                             message:@"Success"//result //@"Success"
                                             delegate:nil
                                             cancelButtonTitle:@"OK"
                                             otherButtonTitles:nil];
                [successAlert show];
        });
        
     } else {
        // An error occurred, we need to handle the error
        // See: https://developers.facebook.com/docs/ios/errors
        NSLog(@"%@", error.description);
        UIAlertView *errorAlert = [[UIAlertView alloc]
                                   initWithTitle:@"FB Error!"
                                   message:error.description
                                   delegate:nil
                                   cancelButtonTitle:@"OK"
                                   otherButtonTitles:nil];
        [errorAlert show];
    }
}

-(void)addPostToAFacebook
{
    // NOTE: pre-filling fields associated with Facebook posts,
    // unless the user manually generated the content earlier in the workflow of your app,
    // can be against the Platform policies: https://developers.facebook.com/policy
    
    // Put together the dialog parameters
    NSMutableString* description = [[NSMutableString alloc] init];
    [description appendString:(_record.name) ];
    [description appendString:(_record.second_name)];
    [description appendString:(_record.phone_number)];
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                   @"User data",
                                   @"name",
                                   @"Description",
                                   @"caption",
                                   description, @"description",
                                   @"https://developers.facebook.com/docs/graph-api/using-graph-api/v2.1",
                                   @"link",
                                   @"https://pbs.twimg.com/profile_images/489552360272691200/42tZ4z3c.png",
                                   @"picture",
                                   nil];
    

    [FBRequestConnection startWithGraphPath:@"/me/feed"
                                 parameters:params
                                 HTTPMethod:@"POST"
                          completionHandler:^(FBRequestConnection *connection, id result, NSError *error)
    {
         [self postCompletionHandler:connection result:result error:error];
    }];


}

- (IBAction)touchDownFBButton:(id)sender {
    [self checkPermissionsAndPublishStory];
}
@end
