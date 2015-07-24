//
//  CustomTabBar.h
//  LeqiClient
//
//  Created by ui on 11-5-25.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface CustomTabBar : UITabBarController {
	NSMutableArray *buttons;
	int currentSelectedIndex;
	UIImageView *slideBg;
}
@property (nonatomic, assign) int	currentSelectedIndex;
@property (nonatomic,retain) NSMutableArray *buttons;
@property (nonatomic,retain)UIView * zqTabBar;
- (void)hideRealTabBar;
- (void)customTabBar;
- (void)selectedTab:(UIButton *)button;


@end

