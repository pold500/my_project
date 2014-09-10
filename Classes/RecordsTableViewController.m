//
//  RecordsTableViewController.m
//  TheElements
//
//  Created by Developer on 08/09/14.
//
//

#import "RecordsTableViewController.h"
#import "BookRecordDetailedViewController.h"

@interface RecordsTableViewController ()

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

//- (void)viewDidLoad
//{
//    [super viewDidLoad];
//    
//    // Uncomment the following line to preserve selection between presentations.
//    // self.clearsSelectionOnViewWillAppear = NO;
//    
//    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
//    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
//}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{
////#warning Potentially incomplete method implementation.
//    // Return the number of sections.
//    return 0;
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
//{
////#warning Incomplete method implementation.
//    // Return the number of rows in the section.
//    return 0;
//}

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



//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BookRecordTableViewCell" forIndexPath:indexPath];
//    
//    // Configure the cell...
//    
//    return cell;
//}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


@end

