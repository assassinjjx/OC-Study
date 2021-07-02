//
//  ViewController.m
//  iOS_Development_Study
//
//  Created by smbapp on 2021/6/24.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UILabel *studyLabel;
@property (weak, nonatomic) IBOutlet UIImageView *studyImageView;
@property (weak, nonatomic) IBOutlet UIButton *studyButton;
@property (weak, nonatomic) IBOutlet UITextField *studyTextField;

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

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear: animated];
    
    [self.navigationController setNavigationBarHidden: YES animated: YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear: animated];
    [self.navigationController setNavigationBarHidden: NO animated: animated];
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
    showLabelViewController.dictionary= [[NSDictionary alloc] initWithObjectsAndKeys: @"Hello World!", @"text", nil];
    [self.navigationController pushViewController:showLabelViewController animated:YES];
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
    [self.studyLabel mas_makeConstraints: ^(MASConstraintMaker* make) {
        make.top.equalTo(self.view.mas_top).with.offset(10);
        make.left.equalTo(self.view.mas_left).with.offset(0);
        make.width.mas_equalTo(400);
        make.height.mas_equalTo(70);
    }];
    self.studyLabel.font = [UIFont systemFontOfSize:48];
    self.studyLabel.textColor = [UIColor redColor];
    self.studyLabel.text = @"Hello World!";
    self.studyLabel.numberOfLines = 0;
    self.studyLabel.tag = 101;
}

//studyImageView初始化
- (void)studyImageViewInit {
    [self.studyImageView mas_makeConstraints: ^(MASConstraintMaker* make) {
        make.top.equalTo(self.view.mas_top).with.offset(250);
        make.centerX.equalTo(self.view.mas_centerX).with.offset(0);
        make.width.mas_equalTo(320);
        make.height.mas_equalTo(180);
    }];
    self.studyImageView.tag = 102;
}

//studyButton初始化
- (void)studyButtonInit {
    [self.studyButton mas_makeConstraints: ^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).with.offset(450); //with is an optional semantic filler
        make.centerX.equalTo(self.view.mas_centerX).with.offset(0);
        make.width.mas_equalTo(120);
        make.height.mas_equalTo(60);
    }];
    self.studyButton.titleLabel.font = [UIFont systemFontOfSize:24];
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
    [self.studyTextField mas_makeConstraints: ^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).with.offset(550); //with is an optional semantic filler
        make.left.equalTo(self.view.mas_left).with.offset(0);
        make.right.equalTo(self.view.mas_right).with.offset(0);
        make.height.mas_equalTo(40);
    }];
    self.studyTextField.placeholder = @"Please input something!";
    self.studyTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.studyTextField.tag = 104;
}

@end
