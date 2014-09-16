//
//  FbLoginPage.m
//  theElements
//
//  Created by Pavel on 9/12/14.
//
//

#import "FbLoginPage.h"
#import <FacebookSDK/FacebookSDK.h>
#import "FBLoginHandler.h"
#import "RecordsTableViewController.h"
#import "BookRecordCollection.h"
#import "TableDataSource.h"

@interface FbLoginPage ()

@property  FBLoginHandler                      *loginViewDelegate;
@property (weak, nonatomic) IBOutlet UIButton *openContactsButtonoutlet;

@end

@implementation FbLoginPage

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)buttonOpenContactsTouchDownAction:(id)sender {
   UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
   RecordsTableViewController *tableViewController = [storyboard instantiateViewControllerWithIdentifier:@"recordsTableView"];
   id<BookRecordDataProtocol, UITableViewDataSource> dataSource = [[TableDataSource alloc]init];
   tableViewController.dataSource = dataSource;
   [self.navigationController pushViewController:tableViewController animated:YES];
}
@end
