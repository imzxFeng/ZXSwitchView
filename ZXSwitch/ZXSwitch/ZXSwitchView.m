//
//  ZXSwitchView.m
//  Hospital
//
//  Created by FZX on 2018/8/24.
//  Copyright © 2018年 wangbao. All rights reserved.
//

#import "ZXSwitchView.h"
#import <Masonry/Masonry.h>
@interface ZXSwitchView ()<UIScrollViewDelegate>
@property (nonatomic, strong) UIScrollView *scroller;
@property (nonatomic, strong) UIView *line;
@end
@implementation ZXSwitchView
{
    NSInteger currentIndex;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.scroller];
        currentIndex = 0;
        _textFont = [UIFont systemFontOfSize:15];
        _textColor = [UIColor blackColor];
        _selectedColor = [UIColor redColor];
    }
    return self;
}

- (void)setTextFont:(UIFont *)textFont{
    _textFont = textFont;
}

- (void)setTextColor:(UIColor *)textColor{
    _textColor = textColor;
}

- (void)setSelectedColor:(UIColor *)selectedColor{
    _selectedColor = selectedColor;
}

- (void)setHiddenRedLine:(BOOL)hiddenRedLine{
    self.line.hidden = hiddenRedLine;
}

- (UIScrollView *)scroller{
    if (!_scroller) {
        _scroller = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        [self addSubview:_scroller];
        _scroller.directionalLockEnabled = YES;
        _scroller.bounces = NO;
        _scroller.delegate = self;
        _scroller.showsHorizontalScrollIndicator = NO; // 水平方向
    }
    return _scroller;
}

- (UIView *)line{
    if (!_line) {
        _line = [UIView new];
        _line.backgroundColor = [UIColor redColor];
    }
    return _line;
}


- (void)setClasses:(NSArray<id> *)classes{
    

    
    
    
    UIButton *last = nil;
    
    for (int i = 0; i < classes.count; i++) {
        
        UIButton *titleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        titleBtn.tag = i;
        
        [titleBtn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [_scroller addSubview:titleBtn];
        
        titleBtn.titleLabel.font = _textFont;
        
        [titleBtn setTitle:[self titleWithClass:classes[i]] forState:UIControlStateNormal];
        
        __weak typeof(self)weakself = self;
        [titleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(weakself.scroller);
            if (i == 0) {
                make.left.equalTo(weakself.scroller).offset(20);
            }
            else{
                make.left.equalTo(last.mas_right).offset(20);
            }
            if (i == classes.count - 1) {
                make.right.equalTo(weakself.scroller).offset(-20);
            }
        }];
        
        last = titleBtn;
        
        if (i == 0) {
            [titleBtn setTitleColor:_selectedColor forState:UIControlStateNormal];
            [_scroller addSubview:self.line];
            _line.frame = CGRectMake(35, _scroller.frame.size.height - 3, 30, 3);
        }
        else{
            [titleBtn setTitleColor:_textColor forState:UIControlStateNormal];
        }
    }
    
}

- (void)buttonClick:(UIButton *)btn{
    if (btn.tag == currentIndex) {
        return;
    }
    
    
    for (id obj in self.scroller.subviews) {
        if ([obj isKindOfClass:[UIButton class]]) {
            UIButton *b = (UIButton *)obj;
            [b setTitleColor:_textColor forState:UIControlStateNormal];
        }
        
    }
    [UIView animateWithDuration:0.2 animations:^{
        /*
        动画
        */
    }];
    
    
    
    [btn setTitleColor:_selectedColor forState:UIControlStateNormal];
    
    if (self.delegate) {
        [self.delegate didSelect:btn.tag];
    }
    
    currentIndex = btn.tag;
}

- (void)setCurrentView:(NSInteger)index{
    if (index == currentIndex) {
        return;
    }
    
    for (id obj in _scroller.subviews) {
        if ([obj isKindOfClass:[UIButton class]]) {
            UIButton *b = (UIButton *)obj;
            if (b.tag == index) {
                [b setTitleColor:_selectedColor forState:UIControlStateNormal];
                [UIView animateWithDuration:0.2 animations:^{
                    /*
                     动画
                     */
                }];
            }
            else{
                [b setTitleColor:_textColor forState:UIControlStateNormal];
            }
            
        }
    }
    
    currentIndex = index;
    
}



- (NSString *)titleWithClass:(id)class
{
    return [class valueForKey:@"name"];
   
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
