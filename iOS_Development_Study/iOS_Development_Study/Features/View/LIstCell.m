//
//  LIstCell.m
//  iOS_Development_Study
//
//  Created by smbapp on 2021/7/5.
//

#import "ListCell.h"

@interface ListCell ()

@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *genderLabel;

@end

@implementation ListCell

#pragma mark- Life Cycle
//重写layoutSubviews方法，给视图设置位置大小
- (void)layoutSubviews{
    [super layoutSubviews];
    
    self.iconView.frame = CGRectMake(0, 0, 120, 80);
//    self.iconView.layer.masksToBounds = YES;
//    self.iconView.layer.cornerRadius = 4;
    self.titleLabel.frame = CGRectMake(130, 10, 100, 30);
    self.genderLabel.frame = CGRectMake(130, 40, 100, 30);
}

#pragma mark- Public Method
#pragma mark- Delegate
#pragma mark- Event Response
#pragma mark- Getters and Setters
- (void)setTitle:(NSString *)title {
    self.titleLabel.text = title;
}

- (void)setGender:(NSString *)gender {
    self.genderLabel.text = gender;
}

- (void)setImage:(UIImage *)image{
    self.iconView.image = image;
}

- (NSString *)getTitle {
    return self.titleLabel.text;
}

- (NSString *)getGender {
    return self.genderLabel.text;
}

#pragma mark- Private Method

@end
