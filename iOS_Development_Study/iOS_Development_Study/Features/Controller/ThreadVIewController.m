//
//  ThreadVIewController.m
//  iOS_Development_Study
//
//  Created by smbapp on 2021/7/8.
//

#import "ThreadViewController.h"

@interface ThreadViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *baiduImageView;
@property (weak, nonatomic) IBOutlet UIImageView *timImageView;
@property (weak, nonatomic) IBOutlet UIImageView *wangyiImageView;
@property (weak, nonatomic) IBOutlet WKWebView *studyWebPageWKWebView;
@property (weak, nonatomic) IBOutlet UIButton *nsthreadButton;
@property (weak, nonatomic) IBOutlet UIButton *gcdButton;

@end

@implementation ThreadViewController

#pragma mark- Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self viewInit];
}

#pragma mark- Public Method
#pragma mark- Delegate
#pragma mark- Event Response
- (void)onNsthreadButtonClicked {
    NSThread *getInternetImageThread1 = [[NSThread alloc] initWithTarget:self selector:@selector(loadInternetImage:) object:[NSNumber numberWithInt:1]];
    getInternetImageThread1.name = @"getBaidu";
    [getInternetImageThread1 start];
    NSThread *getInternetImageThread2 = [[NSThread alloc] initWithTarget:self selector:@selector(loadInternetImage:) object:[NSNumber numberWithInt:2]];
    getInternetImageThread2.name = @"getTim";
    [getInternetImageThread2 start];
    NSThread *getInternetImageThread3 = [[NSThread alloc] initWithTarget:self selector:@selector(loadInternetImage:) object:[NSNumber numberWithInt:3]];
    getInternetImageThread3.name = @"getWangyi";
    [getInternetImageThread3 start];
}

- (void)onGCDButtonClicked {
    dispatch_async(dispatch_get_main_queue(), ^ {
        NSURL *url = [NSURL URLWithString:@"https://www.baidu.com"];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        [self.studyWebPageWKWebView loadRequest:request];
        [ELYTToast showTopWithText:@"HTTPS request succeed!"];
    });
}

- (void)loadInternetImage:(NSNumber *)order {
    NSString *toastInfo = [NSThread currentThread].name;
    dispatch_async(dispatch_get_main_queue(), ^{
        [ELYTToast showTopWithText:toastInfo];
    });
    switch (order.intValue) {
        case 1:
            [self.baiduImageView sd_setImageWithURL:[NSURL URLWithString:@"http://www.baidu.com/img/bdlogo.png"] placeholderImage:[UIImage imageNamed:@"Screenshot_20210629_101438.jpg"]];
            break;
        case 2:
            [self.timImageView sd_setImageWithURL:[NSURL URLWithString:@"http://img.logozhan.com/d/file/logo/20200812/b4a635de6f6b0d0b0aeb8811b51b29bf.jpg"] placeholderImage:[UIImage imageNamed:@"Screenshot_20210629_101438.jpg"]];
            break;
        default:
            [self.wangyiImageView sd_setImageWithURL:[NSURL URLWithString:@"https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fx0.ifengimg.com%2Fucms%2F2021_22%2FC8520A093508F49903B78FC2384AA82AC12B1BE6_size107_w600_h338.png&refer=http%3A%2F%2Fx0.ifengimg.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1628323788&t=1aee6968153dea738ba8b8f1be462b6a"] placeholderImage:[UIImage imageNamed:@"Screenshot_20210629_101438.jpg"]];
            break;
    }
}

#pragma mark- Getters and Setters
#pragma mark- Private Method
- (void)viewInit {
    [self baiduImageViewInit];
    [self timImageViewInit];
    [self wangyiImageViewInit];
    [self studyWebPageWKWebViewInit];
    [self nsthreadButtonInit];
}

- (void)baiduImageViewInit {
    [self.baiduImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view).with.offset(100);
        make.centerX.mas_equalTo(self.view);
        make.width.mas_equalTo(200);
        make.height.mas_offset(100);
    }];
    self.baiduImageView.tag = 401;
}

- (void)timImageViewInit {
    [self.timImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view).with.offset(100);
        make.left.mas_equalTo(self.view).with.offset(50);
        make.width.mas_equalTo(200);
        make.height.mas_offset(100);
    }];
    self.timImageView.tag = 402;
}

- (void)wangyiImageViewInit {
    [self.wangyiImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view).with.offset(100);
        make.right.mas_equalTo(self.view).with.inset(50);
        make.width.mas_equalTo(200);
        make.height.mas_offset(100);
    }];
    self.wangyiImageView.tag = 403;
}

- (void)studyWebPageWKWebViewInit {
    [self.studyWebPageWKWebView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view);
        make.right.mas_equalTo(self.view);
        make.bottom.mas_equalTo(self.view);
        make.top.mas_offset(330);
    }];
    self.studyWebPageWKWebView.tag = 404;
}

- (void)nsthreadButtonInit {
    [self.nsthreadButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).with.offset(200);
        make.top.mas_equalTo(self.view).with.offset(250);
        make.width.mas_equalTo(160);
        make.height.mas_equalTo(60);
    }];
    self.nsthreadButton.titleLabel.font = [UIFont systemFontOfSize:24];
    self.nsthreadButton.backgroundColor = [UIColor blueColor];
    self.nsthreadButton.showsTouchWhenHighlighted = NO;
    self.nsthreadButton.tag = 405;
    [self.nsthreadButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.nsthreadButton setTitle:@"NSThread" forState:UIControlStateNormal];
    [self setNsthreadButtonEvents];
    
    [self.gcdButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.view).with.inset(200);
        make.top.mas_equalTo(self.view).with.offset(250);
        make.width.mas_equalTo(160);
        make.height.mas_equalTo(60);
    }];
    self.gcdButton.titleLabel.font = [UIFont systemFontOfSize:24];
    self.gcdButton.backgroundColor = [UIColor blueColor];
    self.gcdButton.showsTouchWhenHighlighted = NO;
    self.gcdButton.tag = 406;
    [self.gcdButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.gcdButton setTitle:@"GCD" forState:UIControlStateNormal];
    [self setNsthreadButtonEvents];
    [self setGCDButtonEvents];
}

- (void)setNsthreadButtonEvents {
    [self.nsthreadButton addTarget:self action:@selector(onNsthreadButtonClicked) forControlEvents:UIControlEventTouchUpInside];
}

- (void)setGCDButtonEvents {
    [self.gcdButton addTarget:self action:@selector(onGCDButtonClicked) forControlEvents:UIControlEventTouchUpInside];
}

@end
