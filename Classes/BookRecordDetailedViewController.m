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
#import <FacebookSDK/FacebookSDK.h>
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

-(BOOL)tryToRequestPublishPermissions
{
    // Request publish_actions
    __block BOOL result = NO;
    [FBSession.activeSession requestNewPublishPermissions:[NSArray arrayWithObject:@"publish_actions"]
                                        defaultAudience:FBSessionDefaultAudienceFriends
                                        completionHandler:^(FBSession *session, NSError *error) {
                                            //__block BOOL _result;
                                            __block NSString *alertText;
                                            __block NSString *alertTitle;
                                            if (!error) {
                                                if ([FBSession.activeSession.permissions
                                                     indexOfObject:@"publish_actions"] == NSNotFound){
                                                    // Permission not granted, tell the user we will not publish
                                                    alertTitle = @"Permission not granted";
                                                    alertText = @"Your action will not be published to Facebook.";
                                                    [[[UIAlertView alloc] initWithTitle:alertTitle
                                                                                message:alertText
                                                                               delegate:self
                                                                      cancelButtonTitle:@"OK!"
                                                                      otherButtonTitles:nil] show];
                                                } else {
                                                    // Permission granted, publish the OG story
                                                    [self addPostToAFacebook];
                                                    //result = YES;
                                                }
                                                
                                            } else {
                                                // There was an error, handle it
                                                // See https://developers.facebook.com/docs/ios/errors/
                                                result = NO;
                                            }
                                        }];
    return result;
}

-(void)handleError:(NSError*)error
{

}

-(void)checkForPublishPermissions
{
    // Check for publish permissions
    [FBRequestConnection startWithGraphPath:@"/me/permissions"
                          completionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
//                              __block NSString *alertText;
//                              __block NSString *alertTitle;
                              if (!error){
                                  NSDictionary *permissions= [(NSArray *)[result data] objectAtIndex:0];
                                  if (![permissions objectForKey:@"publish_actions"]){
                                      // Publish permissions not found, ask for publish_actions
                                      //UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"Error FB!" message:(@"No publish permissions!") delegate:(nil) cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
                                      //[alertView show];
                                      [self tryToRequestPublishPermissions];
//                                      if([self tryToRequestPublishPermissions])
//                                      {
//                                         [self addPostToAFacebook];
//                                      } else {
//                                          UIAlertView* _alertView = [[UIAlertView alloc] initWithTitle:@"Error FB!" message:(@"Can't get publish permissions!") delegate:(nil) cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
//                                          [_alertView show];
//                                      }
                                      
                                  } else {
                                      // Publish permissions found, publish the OG story
                                      //[self addPostToAFacebook];
                                  }
                                  
                              } else {
                                  // There was an error, handle it
                                  // See https://developers.facebook.com/docs/ios/errors/
                                  [self handleError:error];
                              }
                          }];
}

-(void) postCompletionHandler:(FBRequestConnection *)connection result:(id) result error:(NSError*)error
{
    if (!error) {
        // Link posted successfully to Facebook
        NSLog(@"result: %@", result);
        UIAlertView *successAlert = [[UIAlertView alloc]
                                   initWithTitle:@"FB Success!"
                                   message:result
                                   delegate:nil
                                   cancelButtonTitle:@"OK"
                                   otherButtonTitles:nil];
        [successAlert show];
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
    //    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:
    //                          @"value1", @"key1", @"value2", @"key2", nil];
    NSMutableString* description = [[NSMutableString alloc] init];
    [description appendString:(_record.name) ];
    [description appendString:(_record.second_name)];
    [description appendString:(_record.phoneNumber)];
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                   @"User data", @"name",
                                   @"Description", @"caption",
                                   description, @"description",
                                   @"https://developers.facebook.com/docs/graph-api/using-graph-api/v2.1", @"link",
                                   @"https://pbs.twimg.com/profile_images/489552360272691200/42tZ4z3c.png", @"picture",
                                   nil];
    
    // Make the request

    [FBRequestConnection startWithGraphPath:@"/me/feed"
                         parameters:params
                         HTTPMethod:@"POST"
                         completionHandler:^(FBRequestConnection *connection, id result, NSError *error)
    {
        [self postCompletionHandler:connection result:result error:error];
    }];
    
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
    UIButton* button = [[UIButton alloc] initWithFrame:CGRectMake(20,370, 180, 50)];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setTitle:@"Post contact to Facebook" forState:UIControlStateNormal];
    [button setBackgroundColor:[UIColor blackColor]];
    [button addTarget:self action:@selector(checkForPublishPermissions) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}


- (void)myTransitionDidStop:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context {
    
	// re-enable user interaction when the flip animation is completed
	self.view.userInteractionEnabled = YES;
	
}

@end
