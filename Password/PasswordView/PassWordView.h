//
//  PassWordView.h
//  Password
//
//  Created by Keep丶Dream on 2017/5/5.
//  Copyright © 2017年 dong. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PassWordView;
@protocol PassWordViewDelegate <NSObject>

- (void)passWordViewInputDone:(PassWordView *)passWordView WithPassWord:(NSString *)passWordStr;

@end

@interface PassWordView : UIView

+ (PassWordView *)passWordView;

@property(nonatomic,weak)id<PassWordViewDelegate> delegate;

@end
