//
//  CustomTabBar.m
//  LeqiClient
//
//  Created by ui on 11-5-25.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CustomTabBar.h"

@implementation CustomTabBar
{
    NSArray *imgArr;
    NSArray *selectImgArr;
}
@synthesize currentSelectedIndex;
@synthesize buttons;

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];
    [self customTabBar];
}
-(void)loadView
{
    [super loadView];
    slideBg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bottomfocus.png"]];
    [self hideRealTabBar];
}

- (void)hideRealTabBar{
	for(UIView *view in self.view.subviews){
		if([view isKindOfClass:[UITabBar class]]){
			[view removeFromSuperview];
            break;
		}
	}
}

- (void)hideExistingTabBar
{
	for(UIView *view in self.view.subviews)
	{
		if([view isKindOfClass:[UITabBar class]])
		{
			view.hidden = YES;
			break;
		}
	}
}

- (void)customTabBar{
    
	UIImageView *imgView = [[UIImageView alloc] initWithImage: [UIImage imageNamed:@"tabbg2.png"]];
	imgView.frame = CGRectMake(0, 425, imgView.image.size.width, imgView.image.size.height);
	[self.view addSubview:imgView];
	slideBg.frame = CGRectMake(-30, self.tabBar.frame.origin.y, slideBg.image.size.width, slideBg.image.size.height);
    
	//创建按钮
	int viewCount = self.viewControllers.count > 5 ? 5 : self.viewControllers.count;
	self.buttons = [NSMutableArray arrayWithCapacity:viewCount];
	double _width = self.view.width / viewCount;
	double _height = self.tabBar.frame.size.height+10;
    imgArr = @[@"导航_11",@"导航_12",@"导航_13",@"导航_14",@"导航_15"];
    selectImgArr = @[@"导航_03",@"导航_04",@"导航_05",@"导航_06",@"导航_07"];
    self.zqTabBar = [[UIView alloc]initWithFrame:CGRectMake(0, self.view.height-61, self.view.width, _height+2)];
    
    [self.view addSubview:self.zqTabBar];
    
    UIImageView * bgimgView= [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, 1)];
    bgimgView.backgroundColor = ZQColor(164, 196, 210);
    [self.zqTabBar addSubview:bgimgView];
    [self.zqTabBar release];
    
	for (int i = 0; i < viewCount; i++) {
		UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        		btn.frame = CGRectMake(i*_width,2, _width, _height);
		[btn addTarget:self action:@selector(selectedTab:) forControlEvents:UIControlEventTouchUpInside];
		btn.tag = i;
        [btn setImage:[UIImage imageNamed:imgArr[i]] forState:0];
        [btn setImage:[UIImage imageNamed:selectImgArr[i]] forState:UIControlStateSelected];
		[self.buttons addObject:btn];
		[self.zqTabBar  addSubview:btn];
		[btn release];
	}
    
	[self.view addSubview:slideBg];
	UIImageView *imgFront = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"tabitem.png"]];
	imgFront.frame = imgView.frame;
	[self.view addSubview:imgFront];
	[imgFront release];
	[imgView release];
    static int i = 0;
    i++;
    if (i>1) {
        self.zqTabBar.hidden = YES;
        ((UIButton *)buttons[self.currentSelectedIndex]).selected = YES;
        return;
    }
    ((UIButton *)buttons[self.currentSelectedIndex]).selected = YES;
        self.zqTabBar.backgroundColor = ZQColor(255, 255, 255);
    
}

-(void)creatBtnWithTag:(int )mytag andFrame:(CGRect )frame
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = frame;
    [btn addTarget:self action:@selector(selectedTab:) forControlEvents:UIControlEventTouchUpInside];
    btn.tag = mytag;
    [btn setImage:[UIImage imageNamed:imgArr[mytag]] forState:0];
    [btn setImage:[UIImage imageNamed:selectImgArr[mytag]] forState:UIControlStateSelected];
    [self.buttons addObject:btn];
    [self.zqTabBar  addSubview:btn];
    [btn release];
}

- (void)selectedTab:(UIButton *)button{
	if (self.currentSelectedIndex == button.tag) {
       
	}
        ((UIButton *)buttons[self.currentSelectedIndex]).selected = NO;
    button.selected = YES;
	self.currentSelectedIndex = button.tag;
	self.selectedIndex = self.currentSelectedIndex;
	[self performSelector:@selector(slideTabBg:) withObject:button];
    
}

- (void)slideTabBg:(UIButton *)btn{
	[UIView beginAnimations:nil context:nil];  
	[UIView setAnimationDuration:0.20];  
	[UIView setAnimationDelegate:self];
	slideBg.frame = CGRectMake(btn.frame.origin.x - 30, btn.frame.origin.y, slideBg.image.size.width, slideBg.image.size.height);
	[UIView commitAnimations];
}

- (void) dealloc{
	[slideBg release];
	[buttons release];
	[super dealloc];
}


@end
