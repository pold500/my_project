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




- (void)viewDidLoad {
    
    [super viewDidLoad];

    self.tableView.sectionIndexMinimumDisplayRowCount = 0;
    self.tableView.delegate = self;
	self.tableView.dataSource = self.dataSource;
    
    // create a custom navigation bar button and set it to always say "back"
    UIBarButtonItem *temporaryBarButtonItem = [[UIBarButtonItem alloc] init];
    temporaryBarButtonItem.title = @"Back";
    self.navigationItem.backBarButtonItem = temporaryBarButtonItem;
}

- (void)viewWillAppear:(BOOL)animated {

	[self.tableView reloadData];
    
}


#pragma mark - UITableViewDelegate

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"showDetail"]) {
        NSIndexPath *selectedIndexPath = [self.tableView indexPathForSelectedRow];
        
        //get the selected record
        BookRecord *record = [self.dataSource bookRecordForIndexPath:selectedIndexPath];
        BookRecordDetailedViewController *viewController =
        (BookRecordDetailedViewController *)segue.destinationViewController;
        
        // hide the bottom tabbar when we push this view controller
        viewController.hidesBottomBarWhenPushed = YES;
        
        //if([viewController respondsToSelector:@selector(setRecordId:)])
        {
            // pass the element to this detail view controller
            //viewController.record = record;
            [viewController setRecord:record];
            [viewController setPath:selectedIndexPath];
            
        }
    }
}

@end

