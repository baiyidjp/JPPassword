# Password-6-    
###**仿支付宝微信支付6位密码输入**

- 一句代码调用(先引用代理为了实现密码输入之后将密码传出)

```
//一句代码即可调用显示/隐藏 建议写在点击方法内
[PassWordView passWordView].delegate = self;
```
- 代理方法

```
- (void)passWordViewInputDone:(PassWordView *)passWordView WithPassWord:(NSString *)passWordStr {
    
    self.showPassWord.text = [NSString stringWithFormat:@"密码是---%@",passWordStr];
}

```
![图片](https://github.com/baiyidjp/Password-6-/blob/master/Password/Image/%E5%AF%86%E7%A0%81%E8%BE%93%E5%85%A5.gif?raw=true)
