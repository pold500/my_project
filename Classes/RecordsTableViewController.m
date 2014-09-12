//
//  RecordsTableViewController.m
//  TheElements
//
//  Created by Developer on 08/09/14.
//
//

#import "RecordsTableViewController.h"
#import "BookRecordDetailedViewController.h"
#import <FacebookSDK/FacebookSDK.h>
#import "FBLoginHandler.h"
@interface RecordsTableViewController () <FBLoginViewDelegate>

@property (strong) FBLoginHandler* loginViewDelegate;

@end

@implementation RecordsTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source



- (void)setDataSource:(id<BookRecordDataProtocol,UITableViewDataSource>)dataSource {
    
    // retain the data source
    _dataSource = dataSource;
    
    // set the title, and tab bar images from the dataSource
    // object. These are part of the ElementsDataSource Protocol
    self.title = [_dataSource name];
    //self.tabBarItem.image = [_dataSource tabBarImage];
    
    // set the long name shown in the navigation bar
    self.navigationItem.title = [_dataSource navigationBarName];
}
//
//-(void)postContactDataToUsersWall:(BookRecord*)contact
//{
//    NSString *textToShare = @"I just shared this from my App";
//    UIImage *imageToShare = [UIImage imageNamed:@"Image.png"];
//    NSURL *urlToShare = [NSURL URLWithString:@"http://www.bronron.com"];
//    NSArray *activityItems = @[textToShare, imageToShare, urlToShare];
//    
//    UIActivityViewController *activityVC = [[UIActivityViewController alloc]initWithActivityItems:activityItems applicationActivities:nil];
//    [self presentViewController:activityVC animated:TRUE completion:nil];
//}




- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    FBLoginView *loginView = [[FBLoginView alloc] init];//WithPublishPermissions:(@[@"basic_info",@"publish_actions"]) defaultAudience:FBSessionDefaultAudienceOnlyMe];
    
    [self.view addSubview:loginView];
    
    
    
    // Align the button in the center horizontally
    loginView.frame = CGRectOffset(loginView.frame, (self.view.center.x -
                                                     (loginView.frame.size.width / 2)), 5);
    self.loginViewDelegate = [[FBLoginHandler alloc]init];
    
    //[loginViewDelegate retain];
    
    loginView.delegate = self.loginViewDelegate;
    
    [self.view addSubview:loginView];
    

    //[[self view] addSubview:button];
    
    self.tableView.sectionIndexMinimumDisplayRowCount = 0;
    
    self.tableView.delegate = self;
	self.tableView.dataSource = self.dataSource;
    
    // create a custom navigation bar button and set it to always say "back"
    UIBarButtonItem *temporaryBarButtonItem = [[UIBarButtonItem alloc] init];
    temporaryBarButtonItem.title = @"Back";
    self.navigationItem.backBarButtonItem = temporaryBarButtonItem;
}

- (void)viewWillAppear:(BOOL)animated {
    
	// force the tableview to load
	[self.tableView reloadData];
}


#pragma mark - UITableViewDelegate

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"showDetail"]) {
        NSIndexPath *selectedIndexPath = [self.tableView indexPathForSelectedRow];
        
        // find the right view controller
        BookRecord *record = [self.dataSource bookRecordForIndexPath:selectedIndexPath];
        BookRecordDetailedViewController *viewController =
        (BookRecordDetailedViewController *)segue.destinationViewController;
        
        // hide the bottom tabbar when we push this view controller
        viewController.hidesBottomBarWhenPushed = YES;
        
        if([viewController respondsToSelector:@selector(setRecord:)])
        {
            // pass the element to this detail view controller
            viewController.record = record;
        }
    }
}


#pragma mark - FBLoginViewDelegate

// UIAlertView helper for post buttons
- (void)showAlert:(NSString *)message
           result:(id)result
            error:(NSError *)error {
    
    NSString *alertMsg;
    NSString *alertTitle;
    if (error) {
        alertTitle = @"Error";
        // Since we use FBRequestConnectionErrorBehaviorAlertUser,
        // we do not need to surface our own alert view if there is an
        // an fberrorUserMessage unless the session is closed.
        if (error.fberrorUserMessage && FBSession.activeSession.isOpen) {
            alertTitle = nil;
            
        } else {
            // Otherwise, use a general "connection problem" message.
            alertMsg = @"Operation failed due to a connection problem, retry later.";
        }
    } else {
        NSDictionary *resultDict = (NSDictionary *)result;
        alertMsg = [NSString stringWithFormat:@"Successfully posted '%@'.", message];
        NSString *postId = [resultDict valueForKey:@"id"];
        if (!postId) {
            postId = [resultDict valueForKey:@"postId"];
        }
        if (postId) {
            alertMsg = [NSString stringWithFormat:@"%@\nPost ID: %@", alertMsg, postId];
        }
        alertTitle = @"Success";
    }
    
    if (alertTitle) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:alertTitle
                                                            message:alertMsg
                                                           delegate:nil
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
        [alertView show];
    }
}

@end

