//
//  BookRecordAppEditDelegate.m
//  theElements
//
//  Created by Pavel on 9/15/14.
//
//

#import "TextFiledInputDelegate.h"

@implementation TextFiledInputDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}





static TextFiledInputDelegate *sharedInstance = nil;

+(TextFiledInputDelegate*)getInstance
{
    @synchronized(self) {
        static dispatch_once_t pred;
        dispatch_once(&pred, ^{ sharedInstance = [[self alloc] init]; });
    }
    return sharedInstance;
}

@end
