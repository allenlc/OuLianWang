//
//  MyTextView.m
//  OuLianWang
//
//  Created by 皇室美家 on 15/7/17.
//  Copyright (c) 2015年 皇室美家. All rights reserved.
//

#import "MyTextView.h"
@interface MyTextView() <UITextViewDelegate>
@property (nonatomic, weak) UILabel *placehoderLabel;
@end
@implementation MyTextView

-(id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        // 添加一个显示提醒文字的label（显示占位文字的label）
        UILabel * label = [[UILabel alloc]init];
        [self addSubview:label];
        label.backgroundColor = [UIColor clearColor];
        label.numberOfLines = 0;
        self.placehoderLabel = label;
        
        // 设置默认的占位文字颜色
        self.placehoderColor = [UIColor lightGrayColor];
        
        // 设置默认的字体
        self.font = [UIFont systemFontOfSize:17];
        
        //不要设置自己的代理为自己本身 监听内部文字的变化
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:self];
    }
    return self;
}
#pragma mark -监听文字变化-
-(void)setAttributedText:(NSAttributedString *)attributedText
{
    [super setAttributedText:attributedText];
    [self textDidChange];
}
-(void)textDidChange
{
    self.placehoderLabel.hidden = self.hasText;//是否有文字
    
}
-(void)setText:(NSString *)text
{
    
    [super setText:text];
    [self textDidChange];
}
-(void)setPlacehoder:(NSString *)placehoder
{
    //    #warning 如果是copy策略，setter最好这么写
    _placehoder = [placehoder copy];
    
    //设置文字
    self.placehoderLabel.text = placehoder;
    //重新设置self的子控件的frame
    [self setNeedsLayout];
    
}
-(void)setPlacehoderColor:(UIColor *)placehoderColor
{
    _placehoderColor = placehoderColor;
    self.placehoderLabel.textColor = placehoderColor;
    
}
-(void)setFont:(UIFont *)font
{
    [super setFont:font];
    self.placehoderLabel.font = font;
    //
    [self setNeedsLayout];
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    self.placehoderLabel.frame = CGRectMake(5, 8, self.width-10, 0);
    // 根据文字计算label的高度
    self.placehoderLabel.height = [self calculateHeightOfText:self.placehoder FontOfSize:15];
}
//计算文本高度
-(CGFloat)calculateHeightOfText:(NSString *)text FontOfSize:(int)FontSize
{
    UIFont *textFont = [UIFont systemFontOfSize:FontSize];
    NSDictionary * dic = @{NSFontAttributeName:textFont};
    CGSize s = CGSizeMake(260, 10000);
    CGRect rect = [text boundingRectWithSize:s options:(NSStringDrawingUsesLineFragmentOrigin) attributes:dic context:nil];
    CGFloat H = rect.size.height;
    return H;
}


@end
