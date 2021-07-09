//
//  Lilist.h
//  iOS_Development_Study
//
//  Created by smbapp on 2021/7/5.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ListCell : UITableViewCell

//声明三个属性，用于给视图赋值
@property (nonatomic, copy)NSString *title;
@property (nonatomic, copy)NSString *gender;
@property (nonatomic, copy)UIImage *image;

- (NSString *)getTitle;
- (NSString *)getGender;

@end

NS_ASSUME_NONNULL_END
