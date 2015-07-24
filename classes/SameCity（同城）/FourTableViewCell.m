//
//  FourTableViewCell.m
//  OuLianWang
//
//  Created by allenariel on 15/7/18.
//  Copyright (c) 2015年 皇室美家. All rights reserved.
//

#import "FourTableViewCell.h"

@implementation FourTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createUI];
    }
    return self;
}
-(void)createUI
{
    UITextView *textView=[[UITextView alloc]initWithFrame:CGRectMake(5, 8, 310, 100)];
    textView.backgroundColor=ZQColor(241, 242, 244);
    
    [self.contentView addSubview:textView];
}
@end
