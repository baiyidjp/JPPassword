//
//  PassWordView.m
//  Password
//
//  Created by Keep丶Dream on 2017/5/5.
//  Copyright © 2017年 dong. All rights reserved.
//

#import "PassWordView.h"

@interface PassWordView ()<UITextFieldDelegate>

/** text  view */
@property(nonatomic,strong) UIView *textBackView;
/** textfield */
@property(nonatomic,strong) UITextField *textField;
/** textBackimage */
@property(nonatomic,strong) UIImageView *textBackImageView;
/** passwordimages */
@property(nonatomic,strong) NSMutableArray *passWordImages;
/** passwordstr */
@property(nonatomic,strong) NSString *passWordStr;
/** close btn */
@property(nonatomic,strong) UIButton *closeBtn;
@end

@implementation PassWordView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.frame = frame;
        self.backgroundColor = [UIColor blackColor];
        self.alpha = 0.8;
        
        [[UIApplication sharedApplication].keyWindow addSubview:self];
        
        [self addSubview:self.textBackView];
        [self.textBackView addSubview:self.textField];
        [self.textBackView addSubview:self.textBackImageView];
        [self.textBackView addSubview:self.closeBtn];
        
        [self p_CreatPassWordImage];
        [self p_ShowView];
    }
    return self;
}

+ (PassWordView *)passWordView {
    
    return [[self alloc] initWithFrame:[UIScreen mainScreen].bounds];
}

- (UIView *)textBackView{
    
    if (!_textBackView) {
        
        _textBackView = [[UIView alloc] init];
        _textBackView.backgroundColor = [UIColor purpleColor];
        _textBackView.frame = CGRectMake(30, self.frame.size.height, self.frame.size.width-60, 200);

    }
    return _textBackView;
}

- (UITextField *)textField{
    
    if (!_textField) {
        
        _textField = [[UITextField alloc] init];
        _textField.alpha = 0;
        _textField.frame = CGRectMake(10, 80, self.frame.size.width-60-20, 40);
        _textField.keyboardType = UIKeyboardTypeNumberPad;
        _textField.delegate = self;
    }
    return _textField;
}

- (UIImageView *)textBackImageView{
    
    if (!_textBackImageView) {
        
        _textBackImageView = [[UIImageView alloc] init];
        _textBackImageView.frame = CGRectMake(10, 80, self.frame.size.width-60-20, 40);
        _textBackImageView.image = [UIImage imageNamed:@"password_in"];
    }
    return _textBackImageView;
}

- (NSMutableArray *)passWordImages{
    
    if (!_passWordImages) {
        
        _passWordImages = [NSMutableArray arrayWithCapacity:6];
    }
    return _passWordImages;
}

- (UIButton *)closeBtn{
    
    if (!_closeBtn) {
        
        _closeBtn = [[UIButton alloc] init];
        [_closeBtn setImage:[UIImage imageNamed:@"zhifu-close"] forState:UIControlStateNormal];
        _closeBtn.frame = CGRectMake(10, 10, 15, 15);
        [_closeBtn addTarget:self action:@selector(p_ClickClose) forControlEvents:UIControlEventTouchUpInside];
    }
    return _closeBtn;
}

#pragma mark -创建密码点
- (void)p_CreatPassWordImage {
    
    for (NSInteger i = 0; i < 6; i++) {
        
        UIImageView *imageV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"yuan"]];
        imageV.frame = CGRectMake(self.textBackImageView.frame.size.width/12-8+i*self.textBackImageView.frame.size.width/6, self.textBackImageView.frame.size.height/2-8, 16, 16);
        imageV.hidden = YES;
        imageV.tag = i;
        [self.textBackImageView addSubview:imageV];
        [self.passWordImages addObject:imageV];
    }
}


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    

    NSInteger count = 0;
    if (string.length) {
        count = textField.text.length+string.length;
        self.passWordStr = [NSString stringWithFormat:@"%@%@",textField.text,string];
    }else {
        count = textField.text.length -1;
        self.passWordStr = [[NSMutableString stringWithString:textField.text] substringWithRange:NSMakeRange(0, textField.text.length-1)];
    }
    

    [self p_ChangePassWordHidden:count];
    
    if (count >= 6) {
        [self p_HiddenView];
    }

    return YES;
}

#pragma mark -改变密码点的显示
- (void)p_ChangePassWordHidden:(NSInteger)count {
    
    for (NSInteger i = 0; i < 6; i++) {
        
        UIImageView *imageV = self.passWordImages[i];
        if (imageV.tag < count) {
            imageV.hidden = NO;
        }else {
            imageV.hidden = YES;
        }
    }

}

#pragma mark -弹出视图
- (void)p_ShowView {
    
    [UIView animateWithDuration:0.3 animations:^{
        _textBackView.frame = CGRectMake(30, self.frame.size.height/2-200, self.frame.size.width-60, 200);
    } completion:^(BOOL finished) {
        [_textField becomeFirstResponder];
    }];

}

#pragma mark -移除视图
- (void)p_HiddenView {
    
    if ([self.delegate respondsToSelector:@selector(passWordViewInputDone:WithPassWord:)]) {
        [self.delegate passWordViewInputDone:self WithPassWord:self.passWordStr];
    }
    
    [self p_ClickClose];
}

#pragma mark -点击关闭
- (void)p_ClickClose {
    
    [self.textField resignFirstResponder];
    [UIView animateWithDuration:0.3 animations:^{
        _textBackView.frame = CGRectMake(30, self.frame.size.height, self.frame.size.width-60, 200);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];

}


@end
