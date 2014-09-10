//
//  BookRecordView.m
//  TheElements
//
//  Created by Developer on 08/09/14.
//
//

#import "BookRecordDetailedView.h"

@implementation BookRecordDetailedView


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

    }
    return self;
}

- (void) buttonAction
{
    
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    // Initialization code
    UIButton *but=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    but.frame= CGRectMake(200, 15, 15, 15);
    [but setTitle:@"Ok" forState:UIControlStateNormal];
    [but addTarget:self action:@selector(buttonAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:but];

}




@end
