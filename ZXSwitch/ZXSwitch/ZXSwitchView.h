//
//  ZXSwitchView.h
//  Hospital
//
//  Created by FZX on 2018/8/24.
//  Copyright © 2018年 wangbao. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol ZXSwitchViewDelegate <NSObject>

- (void)didSelect:(NSInteger)index;

@end
@interface ZXSwitchView : UIView
@property (nonatomic, strong) NSArray<id> *classes;
@property (nonatomic, copy) NSString *titleKeyPath;
@property (nonatomic, assign) id <ZXSwitchViewDelegate>delegate;
@property (nonatomic, strong) UIFont *textFont;
@property (nonatomic, strong) UIColor *textColor;
@property (nonatomic, strong) UIColor *selectedColor;
@property (nonatomic, assign) BOOL hiddenRedLine;
- (void)setCurrentView:(NSInteger)index;

@end
