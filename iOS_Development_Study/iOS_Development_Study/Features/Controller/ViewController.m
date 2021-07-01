//
//  ViewController.m
//  iOS_Development_Study
//
//  Created by smbapp on 2021/6/24.
//

#import "ViewController.h"
#import "SecondViewController.h"
#import "ELYTToast.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UILabel *studyLabel;
@property (weak, nonatomic) IBOutlet UIImageView *studyImageView;
@property (weak, nonatomic) IBOutlet UIButton *studyButton;
@property (weak, nonatomic) IBOutlet UITextField *studyTextField;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *studyTextFieldConstraintLeft;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *studyTextFieldConstraintRight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *studyButtonConstraintTop;

@end

@implementation ViewController

#pragma mark- Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //初始化手势识别
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:)];
    //设置成NO表示当前控件响应后会传播到其他控件上，默认为YES。
    tapGestureRecognizer.cancelsTouchesInView = NO;
    //将手势事件添加到当前view
    [self.view addGestureRecognizer:tapGestureRecognizer];
    //打开studyImageView交互开关
    self.studyImageView.userInteractionEnabled = YES;
    //初始化studyImageView手势
    UITapGestureRecognizer *studyimageTapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onIMageViewClicked:)];
    [self.studyImageView addGestureRecognizer:studyimageTapGestureRecognizer];
    
    [self.studyTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
    [self viewInit];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
}

#pragma mark- Public Method
#pragma mark- Delegate
#pragma mark- Event Response
//取消studyTextField第一响应
- (void)keyboardHide:(UITapGestureRecognizer*)tap {
    [_studyTextField resignFirstResponder];
}

//手势点击studyImageView的Toast响应
- (void)onIMageViewClicked:(UITapGestureRecognizer*)tap {
    [ELYTToast showTopWithText: @"Hello World!"];
}

//按钮点击事件
- (void)onButtonClicked {
    UIStoryboard *sb = [UIStoryboard storyboardWithName: @"Main" bundle: nil];
    SecondViewController *showLabelViewController = [sb instantiateViewControllerWithIdentifier: @"showLabel"];
    NSLog(@"button clicked:%@", showLabelViewController);
    [self.navigationController pushViewController:showLabelViewController animated:YES];
    NSLog(@"button clicked1:%@", self.navigationController);
}

//输入框输入响应事件
- (void)textFieldDidChange: (UITextField *)textField {
    self.studyLabel.text = textField.text;
}

#pragma mark- Getters and Setters
#pragma mark- Private Method
//控件初始化封装
- (void)viewInit {
    [self studyLabelInit];
    [self studyImageViewInit];
    [self studyButtonInit];
    [self studyTextFieldInit];
}

//studyLabel初始化
- (void)studyLabelInit {
    self.studyLabel.font = [UIFont systemFontOfSize:48];
    self.studyLabel.textColor = [UIColor redColor];
    self.studyLabel.text = @"Hello World!";
    NSLayoutConstraint *constraintToTop = [NSLayoutConstraint constraintWithItem: self.studyLabel attribute: NSLayoutAttributeTop relatedBy: NSLayoutRelationEqual toItem: self.view attribute: NSLayoutAttributeTop multiplier: 1.0 constant: 0];
    NSLayoutConstraint *constraintToLeft = [NSLayoutConstraint constraintWithItem: self.studyLabel attribute: NSLayoutAttributeLeft relatedBy: NSLayoutRelationEqual toItem: self.view attribute: NSLayoutAttributeLeft multiplier: 1.0 constant: 0];
    NSLayoutConstraint *constraintWidth = [NSLayoutConstraint constraintWithItem: self.studyLabel attribute: NSLayoutAttributeWidth relatedBy: NSLayoutRelationEqual toItem: nil attribute: NSLayoutAttributeNotAnAttribute multiplier: 1.0 constant: 350];
    NSLayoutConstraint *constraintHeight = [NSLayoutConstraint constraintWithItem: self.studyLabel attribute: NSLayoutAttributeHeight relatedBy: NSLayoutRelationEqual toItem: nil attribute: NSLayoutAttributeNotAnAttribute multiplier: 1.0 constant: 60];
    [self.view addConstraints: @[constraintToTop, constraintToLeft, constraintWidth, constraintHeight]];
    self.studyLabel.numberOfLines = 0;
    self.studyLabel.tag = 101;
}

//studyImageView初始化
- (void)studyImageViewInit {
    NSLayoutConstraint *constraintWidth = [NSLayoutConstraint constraintWithItem: self.studyImageView attribute: NSLayoutAttributeWidth relatedBy: NSLayoutRelationEqual toItem: nil attribute: NSLayoutAttributeNotAnAttribute multiplier: 1.0 constant: 320];
    NSLayoutConstraint *constraintHeight = [NSLayoutConstraint constraintWithItem: self.studyImageView attribute: NSLayoutAttributeHeight relatedBy: NSLayoutRelationEqual toItem: nil attribute: NSLayoutAttributeNotAnAttribute multiplier: 1.0 constant: 180];
    NSLayoutConstraint *constraintCenterX = [NSLayoutConstraint constraintWithItem: self.studyImageView attribute: NSLayoutAttributeCenterX relatedBy: NSLayoutRelationEqual toItem: self.view attribute: NSLayoutAttributeCenterX multiplier: 1.0 constant: 0];
    NSLayoutConstraint *constraintToTop = [NSLayoutConstraint constraintWithItem: self.studyImageView attribute: NSLayoutAttributeTop relatedBy: NSLayoutRelationEqual toItem: self.view attribute: NSLayoutAttributeTop multiplier: 1.0 constant: -100];
    [self.view addConstraints: @[constraintWidth, constraintHeight, constraintCenterX, constraintToTop]];
    self.studyImageView.tag = 102;
}

//studyButton初始化
- (void)studyButtonInit {
    self.studyButton.titleLabel.font = [UIFont systemFontOfSize:24];
    NSLayoutConstraint *constraintCenterX = [NSLayoutConstraint constraintWithItem: self.studyButton attribute: NSLayoutAttributeCenterX relatedBy: NSLayoutRelationEqual toItem: self.view attribute: NSLayoutAttributeCenterX multiplier: 1.0 constant: 0];
    NSLayoutConstraint *constraintWidth = [NSLayoutConstraint constraintWithItem: self.studyButton attribute: NSLayoutAttributeWidth relatedBy: NSLayoutRelationEqual toItem: nil attribute: NSLayoutAttributeNotAnAttribute multiplier: 1.0 constant: 120];
    NSLayoutConstraint *constraintHeight = [NSLayoutConstraint constraintWithItem: self.studyButton attribute: NSLayoutAttributeHeight relatedBy: NSLayoutRelationEqual toItem: nil attribute: NSLayoutAttributeNotAnAttribute multiplier: 1.0 constant: 60];
    [self.view addConstraints: @[constraintCenterX, constraintWidth, constraintHeight]];
    self.studyButton.backgroundColor = [UIColor blueColor];
    [self.studyButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    //关闭高亮效果
    self.studyButton.showsTouchWhenHighlighted = NO;
    //添加点击事件，若要传参数则事件后加“:”
    [self.studyButton addTarget:self action:@selector(onButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    self.studyButton.tag = 103;
}

//studyTextField初始化
- (void)studyTextFieldInit {
    NSLayoutConstraint *constraintToTop = [NSLayoutConstraint constraintWithItem: self.studyTextField attribute: NSLayoutAttributeTop relatedBy: NSLayoutRelationEqual toItem: self.view attribute: NSLayoutAttributeTop multiplier: 1.0 constant: 550];
    NSLayoutConstraint *constraintHeight = [NSLayoutConstraint constraintWithItem: self.studyTextField attribute: NSLayoutAttributeHeight relatedBy: NSLayoutRelationEqual toItem: nil attribute: NSLayoutAttributeNotAnAttribute multiplier: 1.0 constant: 40];
    [self.view addConstraints: @[constraintToTop, constraintHeight]];
    self.studyTextField.placeholder = @"Please input something!";
    self.studyTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.studyTextField.tag = 104;
}

@end
