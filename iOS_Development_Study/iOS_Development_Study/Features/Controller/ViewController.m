//
//  ViewController.m
//  iOS_Development_Study
//
//  Created by smbapp on 2021/6/24.
//

#import "ViewController.h"
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
    
    [self viewInit];
    [self.studyTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
}

#pragma mark- Public Method
#pragma mark- Delegate
#pragma mark- Event Response
//取消studyTextField第一响应
- (void)keyboardHide:(UITapGestureRecognizer*)tap {
    [_studyTextField resignFirstResponder];
}

//按钮点击事件
- (void)onButtonClicked {
    [ELYTToast showTopWithText: @"Hello World!"];
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
    self.studyLabel.frame = CGRectMake(0, 50, 350, 60);
    self.studyLabel.numberOfLines = 0;
    self.studyLabel.tag = 101;
}

//studyImageView初始化
- (void)studyImageViewInit {
    self.studyImageView.frame = CGRectMake(230, 140, 320, 180);
    self.studyImageView.tag = 102;
}

//studyButton初始化
- (void)studyButtonInit {
    self.studyButton.titleLabel.font = [UIFont systemFontOfSize:24];
    CGRect frame = self.studyButton.frame;
    frame.size.width = 120;
    frame.size.height = 60;
    self.studyButton.frame = frame;
    NSLayoutConstraint *constraintCenterX = [NSLayoutConstraint constraintWithItem: self.studyButton attribute: NSLayoutAttributeCenterX relatedBy: NSLayoutRelationEqual toItem: self.view attribute: NSLayoutAttributeCenterX multiplier: 1.0 constant: 0];
    [self.view addConstraint: constraintCenterX];
    self.studyButton.backgroundColor = [UIColor blueColor];
    [self.studyButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    //关闭高亮效果
    self.studyButton.showsTouchWhenHighlighted = NO;
    //添加点击事件，若要传参数则事件后加“:”
    [self.studyButton addTarget:self action:@selector(onButtonClicked) forControlEvents:UIControlEventTouchDown];
    self.studyButton.tag = 103;
}

//studyTextField初始化
- (void)studyTextFieldInit {
    CGRect frame = self.studyTextField.frame;
    frame.size.height = 40;
    self.studyTextField.frame = frame;
    NSLayoutConstraint *constraintToTop = [NSLayoutConstraint constraintWithItem: self.studyTextField attribute: NSLayoutAttributeTop relatedBy: NSLayoutRelationEqual toItem: self.view attribute: NSLayoutAttributeTop multiplier: 1.0 constant: 420];
    [self.view addConstraint:constraintToTop];
    self.studyTextField.placeholder = @"Please input something!";
    self.studyTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.studyTextField.tag = 104;
}

@end
