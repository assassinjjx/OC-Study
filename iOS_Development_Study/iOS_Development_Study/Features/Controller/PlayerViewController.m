//
//  PlayerViewController.m
//  iOS_Development_Study
//
//  Created by smbapp on 2021/7/2.
//

#import "PlayerViewController.h"

@interface PlayerViewController ()

@property (strong, nonatomic) AVPlayerItem *studyPlayerItem;

@end

@implementation PlayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self studyPlayerInit];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([object isKindOfClass:[AVPlayerItem class]]) {
        if ([keyPath isEqualToString:@"status"]) {
            switch (self.studyPlayerItem.status) {
                case AVPlayerItemStatusReadyToPlay:
                    // 播放方法在这里，比较稳妥
                    NSLog(@"准备播放");
                    break;
                case AVPlayerItemStatusFailed:
                    NSLog(@"准备失败");
                    break;
                case AVPlayerItemStatusUnknown:
                    NSLog(@"未知");
                    break;
                default:
                    break;
            }
        }
    }
}

- (void)studyPlayerInit {
    NSURL * videoUrl = [NSURL URLWithString:@"http://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4"];
    self.studyPlayerItem = [[AVPlayerItem alloc] initWithURL:videoUrl];
    self.player = [[AVPlayer alloc] initWithPlayerItem:self.studyPlayerItem];
    [self.studyPlayerItem addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
}

@end
