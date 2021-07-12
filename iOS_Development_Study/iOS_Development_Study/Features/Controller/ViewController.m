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
@property (weak, nonatomic) IBOutlet UILabel *defaultsLabel;
@property (weak, nonatomic) IBOutlet UIButton *defaultsButton;

@end

@implementation ViewController

#pragma mark- Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:)];
    //设置成NO表示当前控件响应后会传播到其他控件上，默认为YES
    tapGestureRecognizer.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tapGestureRecognizer];
    
    
    //添加进行页面跳转的滑动手势
    UISwipeGestureRecognizer *recognizer = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(handleSwipeFrom:)];
    [recognizer setDirection:(UISwipeGestureRecognizerDirectionUp)];
    [self.view addGestureRecognizer:recognizer];
    recognizer = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(handleSwipeFrom:)];
    [recognizer setDirection:(UISwipeGestureRecognizerDirectionDown)];
    [self.view addGestureRecognizer:recognizer];
    recognizer = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(handleSwipeFrom:)];
    [recognizer setDirection:(UISwipeGestureRecognizerDirectionRight)];
    [self.view addGestureRecognizer:recognizer];
    
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
- (void)keyboardHide:(UITapGestureRecognizer*)tap {
    [_studyTextField resignFirstResponder];
}

- (void)onIMageViewClicked:(UITapGestureRecognizer*)tap {
    [ELYTToast showTopWithText: @"Hello World!"];
}

//滑动手势跳转页面
- (void)handleSwipeFrom:(UISwipeGestureRecognizer *)recognizer {
    UIStoryboard *sb = [UIStoryboard storyboardWithName: @"Main" bundle: nil];
    if (recognizer.direction == UISwipeGestureRecognizerDirectionUp) {
        TableViewController * tableViewController = [sb instantiateViewControllerWithIdentifier: @"table"];
        [self.navigationController pushViewController:tableViewController animated:YES];
    } else if (recognizer.direction == UISwipeGestureRecognizerDirectionDown) {
        PlayerViewController * playerViewController = [sb instantiateViewControllerWithIdentifier: @"player"];
        [self.navigationController pushViewController:playerViewController animated:YES];
    } else if (recognizer.direction == UISwipeGestureRecognizerDirectionRight) {
        ThreadViewController * threadViewController = [sb instantiateViewControllerWithIdentifier: @"thread"];
        [self.navigationController pushViewController:threadViewController animated:YES];
    }
}

- (void)onButtonClicked {
    UIStoryboard *sb = [UIStoryboard storyboardWithName: @"Main" bundle: nil];
    SecondViewController *showLabelViewController = [sb instantiateViewControllerWithIdentifier: @"showLabel"];
    showLabelViewController.dictionary= [[NSDictionary alloc] initWithObjectsAndKeys: @"Hello World!", @"text", nil];
    [self.navigationController pushViewController:showLabelViewController animated:YES];
}

- (void)textFieldDidChange: (UITextField *)textField {
    self.studyLabel.text = textField.text;
}

- (void)onDefaultsButtonClicked {
    NSString * storeString = self.studyTextField.text;
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    [userDefault setObject:storeString forKey:@"text"];
//    [userDefault synchronize];
    
    self.defaultsLabel.text = [userDefault objectForKey:@"text"];
}

#pragma mark- Getters and Setters
#pragma mark- Private Method
//视图初始化封装
- (void)viewInit {
    [self studyLabelInit];
    [self studyImageViewInit];
    [self studyButtonInit];
    [self studyTextFieldInit];
    [self defaultsLabelInit];
    [self defaultsButtonInit];
}

- (void)studyLabelInit {
    [self.studyLabel mas_makeConstraints: ^(MASConstraintMaker* make) {
        make.top.mas_equalTo(self.view.mas_top).with.offset(10);
        make.left.mas_equalTo(self.view.mas_left).with.offset(0);
        make.width.mas_equalTo(400);
        make.height.mas_equalTo(70);
    }];
    self.studyLabel.font = [UIFont systemFontOfSize:48];
    self.studyLabel.textColor = [UIColor redColor];
    self.studyLabel.text = @"Hello World!";
    self.studyLabel.numberOfLines = 0;
    self.studyLabel.tag = 101;
}

- (void)studyImageViewInit {
    [self.studyImageView mas_makeConstraints: ^(MASConstraintMaker* make) {
        make.top.mas_equalTo(self.view.mas_top).with.offset(250);
        make.centerX.mas_equalTo(self.view.mas_centerX).with.offset(0);
        make.width.mas_equalTo(320);
        make.height.mas_equalTo(180);
    }];
    self.studyImageView.tag = 102;
    [self setStudyImageViewEvents];
}

- (void)studyButtonInit {
    [self.studyButton mas_makeConstraints: ^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view.mas_top).with.offset(450);
        make.centerX.mas_equalTo(self.view.mas_centerX).with.offset(0);
        make.width.mas_equalTo(160);
        make.height.mas_equalTo(60);
    }];
    self.studyButton.titleLabel.font = [UIFont systemFontOfSize:24];
    self.studyButton.backgroundColor = [UIColor blueColor];
    self.studyButton.showsTouchWhenHighlighted = NO;
    self.studyButton.tag = 103;
    [self.studyButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.studyButton setTitle:@"Hello World!" forState:UIControlStateNormal];
    [self setStudyButtonEvents];
}

- (void)studyTextFieldInit {
    [self.studyTextField mas_makeConstraints: ^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view.mas_top).with.offset(550); //with is an optional semantic filler
        make.left.mas_equalTo(self.view.mas_left).with.offset(0);
        make.right.mas_equalTo(self.view.mas_right).with.offset(0);
        make.height.mas_equalTo(40);
    }];
    self.studyTextField.placeholder = @"Please input something!";
    self.studyTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.studyTextField.tag = 104;
}

- (void)defaultsLabelInit {
    [self.defaultsLabel mas_makeConstraints: ^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view).with.offset(650); //with is an optional semantic filler
        make.centerX.mas_equalTo(self.view);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(40);
    }];
    self.defaultsLabel.font = [UIFont systemFontOfSize:24];
    self.defaultsLabel.textAlignment = NSTextAlignmentCenter;
    self.defaultsLabel.text = nil;
    self.defaultsLabel.tag = 105;
}

- (void)defaultsButtonInit {
    [self.defaultsButton mas_makeConstraints: ^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view).with.offset(700); //with is an optional semantic filler
        make.centerX.mas_equalTo(self.view);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(40);
    }];
    self.defaultsButton.backgroundColor = [UIColor grayColor];
    self.defaultsButton.titleLabel.font = [UIFont systemFontOfSize:24];
    self.defaultsButton.tag = 106;
    [self.defaultsButton setTitle:@"Store" forState:UIControlStateNormal];
    [self.defaultsButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self setDefaultsButtonEvents];
}

- (void)setStudyButtonEvents {
    //添加点击事件，若要传参数则事件后加“:”
    [self.studyButton addTarget:self action:@selector(onButtonClicked) forControlEvents:UIControlEventTouchUpInside];
}

- (void)setStudyImageViewEvents {
    //打开studyImageView交互开关
    self.studyImageView.userInteractionEnabled = YES;
    //初始化studyImageView手势
    UITapGestureRecognizer *studyimageTapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onIMageViewClicked:)];
    [self.studyImageView addGestureRecognizer:studyimageTapGestureRecognizer];
    [self setStudyTextFieldEvents];
}

- (void)setStudyTextFieldEvents {
    //studyTextField编辑事件监听
    [self.studyTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
}

- (void)setDefaultsButtonEvents {
    //添加点击事件，若要传参数则事件后加“:”
    [self.defaultsButton addTarget:self action:@selector(onDefaultsButtonClicked) forControlEvents:UIControlEventTouchUpInside];
}

@end
