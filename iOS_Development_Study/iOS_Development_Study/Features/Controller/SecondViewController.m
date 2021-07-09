//
//  SecondViewController.m
//  iOS_Development_Study
//
//  Created by smbapp on 2021/6/29.
//

#import "SecondViewController.h"

@interface SecondViewController () <AVCaptureMetadataOutputObjectsDelegate, CAAnimationDelegate>

@property (weak, nonatomic) IBOutlet UILabel *showLabel;
@property (weak, nonatomic) IBOutlet UIView *showLine;
@property (weak, nonatomic) IBOutlet UIButton *showButton;
@property (weak, nonatomic) IBOutlet UIButton *showCheckBox;

@property (strong, nonatomic) MyBoardView *showBoardView;
@property (strong, nonatomic) UIImageView *scanLineImageView;

@end

@implementation SecondViewController

#pragma mark- Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self viewInit];
}

#pragma mark- Public Method
#pragma mark- Delegate
////动画开始的时候调用
//- (void)animationDidStart:(CAAnimation *)anim{
//    self.scanLineImageView.layer.position = CGPointMake(300, 50);
//
//}
//
////动画结束的时候调用
//- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
//    self.scanLineImageView.layer.position = CGPointMake(300, 250);
//}

#pragma mark- Event Response
- (void)onCheckBoxClicked:(UIButton *)btn {
    NSData *image1 = UIImagePNGRepresentation(self.showCheckBox.imageView.image);
    NSData *image2 = UIImagePNGRepresentation([UIImage  imageNamed:@"B.png"]);
    if([image1 isEqual:image2]) {
        [self.showCheckBox setImage:[UIImage imageNamed:@"A.png"] forState:UIControlStateNormal];
    } else {
        [self.showCheckBox setImage:[UIImage imageNamed:@"B.png"] forState:UIControlStateNormal];
    }
}

#pragma mark- Getters and Setters
#pragma mark- Private Method
- (void)viewInit {
    [self showLabelInit];
    [self showLineInit];
    [self showButtonInit];
    [self showCheckBoxInit];
    [self myBoardViewInit];
    [self scanLineImageViewInit];
}

- (void)showLabelInit {
    [self.showLabel mas_makeConstraints: ^(MASConstraintMaker* make) {
        make.centerX.equalTo(self.view.mas_centerX).with.offset(0);
        make.centerY.equalTo(self.view.mas_centerY).with.offset(0);
        make.width.mas_equalTo(400);
        make.height.mas_equalTo(70);
    }];
    self.showLabel.font = [UIFont systemFontOfSize:48];
    self.showLabel.textColor = [UIColor redColor];
//    self.showLabel.textAlignment = UIListContentTextAlignmentCenter;
    self.showLabel.textAlignment = NSTextAlignmentCenter;
    self.showLabel.text = [self.dictionary valueForKey: @"text"];
    self.showLabel.numberOfLines = 0;
    self.showLabel.tag = 201;
}

- (void)showLineInit {
    [self.showLine mas_makeConstraints: ^(MASConstraintMaker* make) {
        make.top.equalTo(self.view.mas_top).with.offset(300);
        make.width.mas_equalTo(self.view.mas_width);
        make.height.mas_equalTo(1);
    }];
    self.showLine.backgroundColor = [UIColor blackColor];
    self.showLine.tag = 202;
}

- (void)showButtonInit {
    [self.showButton mas_makeConstraints: ^(MASConstraintMaker* make) {
        make.left.equalTo(self.view.mas_left).with.offset(51);
        make.bottom.equalTo(self.showLine.mas_top).with.offset(-100);
        make.width.mas_equalTo(980);
        make.height.mas_equalTo(120);
    }];
    self.showButton.titleLabel.font = [UIFont systemFontOfSize:48];
    self.showButton.backgroundColor = [UIColor colorWithRed:40/255.0 green:131/255.0 blue:248/255.0 alpha:1];
    self.showButton.layer.cornerRadius = 6;
    self.showButton.tag = 203;
    [self.showButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.showButton setTitle:@"违章上报" forState:UIControlStateNormal];
}

- (void)showCheckBoxInit {
    [self.showCheckBox mas_makeConstraints: ^(MASConstraintMaker* make) {
        make.centerX.equalTo(self.view.mas_centerX).with.offset(0);
        make.top.equalTo(self.showLine.mas_bottom).with.offset(40);
        make.width.mas_equalTo(52);
        make.height.mas_equalTo(52);
    }];
    self.showCheckBox.tag = 204;
    [self.showCheckBox setImage:[UIImage imageNamed:@"B.png"] forState:UIControlStateNormal];
    [self setShowCheckBoxEvents];
}

- (void)myBoardViewInit {
    self.showBoardView = [[MyBoardView alloc] init];
    self.showBoardView.tag = 205;
    [self.view addSubview:self.showBoardView];
    [self.showBoardView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.top.mas_equalTo(self.view).with.offset(600);
        make.width.mas_equalTo(600);
        make.height.mas_equalTo(300);
    }];
}

- (void)scanLineImageViewInit {
    self.scanLineImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"unv_scan_line.png"]];
    self.scanLineImageView.layer.anchorPoint = CGPointMake(0, 0);
    self.scanLineImageView.frame = CGRectMake(100, 50, 400, 5);
    self.scanLineImageView.tag = 206;
    [self.showBoardView.layer addSublayer:self.scanLineImageView.layer];
    [self setScanLineImageViewEvents];
}

- (void)setShowCheckBoxEvents {
    [self.showCheckBox addTarget:self action:@selector(onCheckBoxClicked:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)setScanLineImageViewEvents {
    //    [UIView animateWithDuration:0.2 animations:^{
    //
    //    }];
    //
    //    UIView animateWithDuration:0.2 animations:^{
    //        <#code#>
    //    } completion:^(BOOL finished) {
    //        <#code#>
    //    }
    
    //创建动画对象
    CABasicAnimation *basicAni = [CABasicAnimation animation];
    //设置动画属性
    basicAni.keyPath = @"position";
    //设置动画的起始位置。也就是动画从哪里到哪里
    basicAni.fromValue = [NSValue valueWithCGPoint:CGPointMake(100, 50)];
    //动画结束后，layer所在的位置
    basicAni.toValue = [NSValue valueWithCGPoint:CGPointMake(100, 250)];
    //动画持续时间
    basicAni.duration = 2;
    //动画填充模式
    basicAni.fillMode = kCAFillModeForwards;
    //动画完成不删除
    basicAni.removedOnCompletion = NO;
//    //xcode8.0之后需要遵守代理协议
//    basicAni.delegate = self;
//    //设置动画往复
//    basicAni.autoreverses = YES;
    //设置动画重复次数
    basicAni.repeatCount = FLT_MAX;
//    //设置重复动画重复时间
//    basicAni.repeatDuration = 100;
    //把动画添加到要作用的Layer上面
    [self.scanLineImageView.layer addAnimation:basicAni forKey:nil];
}

@end
