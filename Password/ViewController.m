//
//  ViewController.m
//  Password
//
//  Created by Keep丶Dream on 2017/5/5.
//  Copyright © 2017年 dong. All rights reserved.
//

#import "ViewController.h"
#import "PassWordView.h"

@interface ViewController ()<PassWordViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *showPassWord;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)click:(id)sender {
    
    [PassWordView passWordView].delegate = self;
}

- (void)passWordViewInputDone:(PassWordView *)passWordView WithPassWord:(NSString *)passWordStr {
    
    self.showPassWord.text = [NSString stringWithFormat:@"密码是---%@",passWordStr];
}
- (IBAction)closeTouchID:(id)sender {
    
    [[NSUserDefaults standardUserDefaults] setValue:@"off" forKey:@"touchOn"];
}
@end
