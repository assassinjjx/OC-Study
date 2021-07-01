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
    NSLayoutConstraint *constraintCenterX = [NSLayoutConstraint constraintWithItem: self.showLabel attribute: NSLayoutAttributeCenterX relatedBy: NSLayoutRelationEqual toItem: self.view attribute: NSLayoutAttributeCenterX multiplier: 1.0 constant: 0];
    NSLayoutConstraint *constraintCenterY = [NSLayoutConstraint constraintWithItem: self.showLabel attribute: NSLayoutAttributeCenterY relatedBy: NSLayoutRelationEqual toItem: self.view attribute: NSLayoutAttributeCenterY multiplier: 1.0 constant: 0];
    NSLayoutConstraint *constraintWidth = [NSLayoutConstraint constraintWithItem: self.showLabel attribute: NSLayoutAttributeWidth relatedBy: NSLayoutRelationEqual toItem: nil attribute: NSLayoutAttributeNotAnAttribute multiplier: 1.0 constant: 120];
    NSLayoutConstraint *constraintHeight = [NSLayoutConstraint constraintWithItem: self.showLabel attribute: NSLayoutAttributeHeight relatedBy: NSLayoutRelationEqual toItem: nil attribute: NSLayoutAttributeNotAnAttribute multiplier: 1.0 constant: 60];
    [self.view addConstraints: @[constraintWidth, constraintHeight, constraintCenterX, constraintCenterY]];
    self.showLabel.textColor = [UIColor redColor];
    self.showLabel.frame = CGRectMake(0, 0, 120, 60);
    self.showLabel.text = @"Hello World!";
    self.showLabel.numberOfLines = 0;
}

@end
