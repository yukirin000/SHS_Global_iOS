//
//  NavBar.m
//  UBaby_iOS
//
//  Created by bhczmacmini on 14-10-20.
//  Copyright (c) 2014年 bhczmacmini. All rights reserved.
//

#import "NavBar.h"
#import "DeviceManager.h"

@interface NavBar()

@property (nonatomic, copy) LeftBlock leftBlock;
@property (nonatomic, copy) RightBlock rightBlock;

@end

@implementation NavBar


- (instancetype)init
{
    self = [super init];
    if (self) {
        //顶部背景栏
        self.frame                    = CGRectMake(0, 0, [DeviceManager getDeviceWidth], kNavBarAndStatusHeight);
        self.backgroundColor          = [UIColor colorWithHexString:ColorBlack];
        self.titleLabel               = [[CustomLabel alloc] initWithFontSize:17];
        self.titleLabel.frame         = CGRectMake(kCenterOriginX(200), 19, 200, 44);
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.textColor     = [UIColor colorWithHexString:ColorWhite];
        [self.titleLabel setFontBold];
        
        self.leftBtn = [[CustomButton alloc] initWithFontSize:16];
        [self.leftBtn addTarget:self action:@selector(leftBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        self.rightBtn = [[CustomButton alloc] initWithFontSize:16];
        [self.rightBtn addTarget:self action:@selector(rightBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.titleLabel];
        [self addSubview:self.leftBtn];
        [self addSubview:self.rightBtn];
    }
    return self;
}

//设置左边按钮
- (void)setLeftBtnWithFrame:(CGRect)rect andContent:(NSString *)content andBlock:(LeftBlock)block
{

    self.leftBtn.frame = rect;
    [self.leftBtn setTitle:content forState:UIControlStateNormal];
    self.leftBlock = block;
}

/*!设置左边按钮不变位置*/
- (void)setLeftBtnWithContent:(NSString *)content andBlock:(LeftBlock)block
{
    [self.leftBtn setTitle:content forState:UIControlStateNormal];
    self.leftBlock = block;
}

//设置右边按钮
- (void)setRightBtnWithFrame:(CGRect)rect andContent:(NSString *)content andBlock:(RightBlock)block
{
    [self setRightBtnWithContent:content andBlock:block];
    
    self.rightBtn.frame = rect;
}
/*!设置右边按钮不变位置*/
- (void)setRightBtnWithContent:(NSString *)content andBlock:(LeftBlock)block
{
    self.rightBtn.frame = CGRectMake([DeviceManager getDeviceWidth]-65, 20, 60, 44);
    [self.rightBtn setTitle:content forState:UIControlStateNormal];
    self.rightBlock = block;

}

//设置标题
- (void)setNavTitle:(NSString *)title
{
    self.titleLabel.text = title;
}

//左边点击事件
- (void)leftBtnClick:(id)sender
{
    if (self.leftBlock) {
        self.leftBlock();
    }
}

//右边点击事件
- (void)rightBtnClick:(id)sender
{
    if (self.rightBlock) {
        self.rightBlock();
    }
}

/*! 设置右上角图片*/
- (void)setRightImage:(UIImage *)image
{
    self.rightBtn.imageEdgeInsets       = UIEdgeInsetsMake(0, 0, 0, 10);
    self.rightBtn.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.rightBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
    [self.rightBtn setImage:image forState:UIControlStateNormal];
}

/*! 设置左上角图片*/
- (void)setLeftImage:(UIImage *)image
{

}

@end
