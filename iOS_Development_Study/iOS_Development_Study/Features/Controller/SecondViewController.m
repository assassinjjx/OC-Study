//
//  SecondViewController.m
//  iOS_Development_Study
//
//  Created by smbapp on 2021/6/29.
//

#import "SecondViewController.h"


@interface SecondViewController ()
@property (weak, nonatomic) IBOutlet UILabel *showLabel;

@end

@implementation SecondViewController

#pragma mark- Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self viewInit];
}

#pragma mark- Public Method
#pragma mark- Delegate
#pragma mark- Event Response
#pragma mark- Getters and Setters
#pragma mark- Private Method
- (void)viewInit {
    [self showLabelInit];
}

//studyLabel初始化
- (void)showLabelInit {
    self.showLabel.font = [UIFont systemFontOfSize:48];
    self.showLabel.textColor = [UIColor redColor];
    self.showLabel.text = @"Hello World!";
    self.showLabel.frame = CGRectMake(0, 50, 350, 60);
    self.showLabel.numberOfLines = 0;
    self.showLabel.tag = 101;
}

@end
