//
//  LSWMSearchBar.m
//  WithMusic
//
//  Created by Facebook on 2018/1/23.
//  Copyright © 2018年 Facebook. All rights reserved.
//

#import "LSWMSearchBar.h"
#import "LSWMTools.h"

@implementation LSWMSearchBar


- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.placeholder = @"搜索";
        self.keyboardType = UIKeyboardTypeDefault;
        self.backgroundImage = [LSWMTools getImageWithColor:[UIColor clearColor] andHeight:44.0f];
        [self setBackgroundColor:UIColorFromRGB(0xf0f0f6)];
        UITextField *searchField = [self valueForKey:@"_searchField"];
        searchField.layer.borderWidth = 0.5f;
        searchField.layer.borderColor = [UIColorFromRGB(0xdfdfdf) CGColor];
        searchField.layer.cornerRadius = 5.f;
    }
    return self;
}

@end
