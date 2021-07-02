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
    [self.showLabel mas_makeConstraints: ^(MASConstraintMaker* make) {
        make.centerX.equalTo(self.view.mas_centerX).with.offset(0);
        make.centerY.equalTo(self.view.mas_centerY).with.offset(0);
        make.width.mas_equalTo(400);
        make.height.mas_equalTo(70);
    }];
    self.showLabel.font = [UIFont systemFontOfSize:48];
    self.showLabel.textColor = [UIColor redColor];
    self.showLabel.textAlignment = UIListContentTextAlignmentCenter;
    self.showLabel.text = [self.dictionary valueForKey: @"text"];
    self.showLabel.numberOfLines = 0;
}

@end
