/*
     File: TheElementsAppDelegate.m
 Abstract: Application delegate that sets up the application.
  Version: 1.12
 
 Disclaimer: IMPORTANT:  This Apple software is supplied to you by Apple
 Inc. ("Apple") in consideration of your agreement to the following
 terms, and your use, installation, modification or redistribution of
 this Apple software constitutes acceptance of these terms.  If you do
 not agree with these terms, please do not use, install, modify or
 redistribute this Apple software.
 
 In consideration of your agreement to abide by the following terms, and
 subject to these terms, Apple grants you a personal, non-exclusive
 license, under Apple's copyrights in this original Apple software (the
 "Apple Software"), to use, reproduce, modify and redistribute the Apple
 Software, with or without modifications, in source and/or binary forms;
 provided that if you redistribute the Apple Software in its entirety and
 without modifications, you must retain this notice and the following
 text and disclaimers in all such redistributions of the Apple Software.
 Neither the name, trademarks, service marks or logos of Apple Inc. may
 be used to endorse or promote products derived from the Apple Software
 without specific prior written permission from Apple.  Except as
 expressly stated in this notice, no other rights or licenses, express or
 implied, are granted by Apple herein, including but not limited to any
 patent rights that may be infringed by your derivative works or by other
 works in which the Apple Software may be incorporated.
 
 The Apple Software is provided by Apple on an "AS IS" basis.  APPLE
 MAKES NO WARRANTIES, EXPRESS OR IMPLIED, INCLUDING WITHOUT LIMITATION
 THE IMPLIED WARRANTIES OF NON-INFRINGEMENT, MERCHANTABILITY AND FITNESS
 FOR A PARTICULAR PURPOSE, REGARDING THE APPLE SOFTWARE OR ITS USE AND
 OPERATION ALONE OR IN COMBINATION WITH YOUR PRODUCTS.
 
 IN NO EVENT SHALL APPLE BE LIABLE FOR ANY SPECIAL, INDIRECT, INCIDENTAL
 OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
 SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
 INTERRUPTION) ARISING IN ANY WAY OUT OF THE USE, REPRODUCTION,
 MODIFICATION AND/OR DISTRIBUTION OF THE APPLE SOFTWARE, HOWEVER CAUSED
 AND WHETHER UNDER THEORY OF CONTRACT, TORT (INCLUDING NEGLIGENCE),
 STRICT LIABILITY OR OTHERWISE, EVEN IF APPLE HAS BEEN ADVISED OF THE
 POSSIBILITY OF SUCH DAMAGE.
 
 Copyright (C) 2013 Apple Inc. All Rights Reserved.
 
 */

#import "TheElementsAppDelegate.h"
// each data source responsible for backing our 4 varying table view controllers
#import "TableDataSource.h"
#import "BookRecordDataProtocol.h"
#import "RecordsTableViewController.h"
#import <FacebookSDK/FacebookSDK.h>

@implementation TheElementsAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
	
    // for each tableview 'screen' we need to create a datasource instance
    // (the class that is passed in) we then need to create an instance of
    // ElementsTableViewController with that datasource instance finally we need to return
    // a UINaviationController for each screen, with the ElementsTableViewController as the
    // root view controller.
    //
    // Override point for customization after application launch.
    [FBLoginView class];
    
    // *tabBarController = (UITabBarController *)self.window.rootViewController;

    // the class type for the datasource is not crucial, but that it implements the
	// ElementsDataSource protocol and the UITableViewDataSource Protocol
    //
    //id<BookRecordDataProtocol, UITableViewDataSource> dataSource;
    
    
    //NSMutableArray *viewControllers = [NSMutableArray arrayWithCapacity:1];
    
    // create our tabbar view controllers, since we already have one defined in our storyboard
    // we will create 3 more instances of it, and assign each it's own kind data source
    
    // by name
    //UINavigationController *navController = (UINavigationController*)self.window.rootViewController;
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];

    UINavigationController *navController = [storyboard instantiateViewControllerWithIdentifier:@"navForTableView"];
    
    self.window.rootViewController = navController;
    
    UIViewController* loginPage = [storyboard instantiateViewControllerWithIdentifier:@"fbLoginPage"];
    
    //RecordsTableViewController *tableViewController = [storyboard instantiateViewControllerWithIdentifier:@"recordsTableView"];
    
    [navController pushViewController:loginPage animated:YES];
    //    (RecordsTableViewController *)[navController topViewController];

    //dataSource = [[RecordsSortedByNameDataSource alloc] init];
    
//    tableViewController.dataSource = dataSource;
    
    //[viewControllers addObject:navController];
    
    //tabBarController.viewControllers = viewControllers;
    
    return YES;
}

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation {
    
    // Call FBAppCall's handleOpenURL:sourceApplication to handle Facebook app responses
    BOOL wasHandled = [FBAppCall handleOpenURL:url sourceApplication:sourceApplication];
    
    // You can add your app-specific url handling code here if needed
    
    return wasHandled;
}

@end

