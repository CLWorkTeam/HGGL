//
//  TKSelectCell.m
//  泰行销
//
//  Created by edz on 2017/5/5.
//  Copyright © 2017年 taikanglife. All rights reserved.
//

#import "TKSelectCell.h"

@implementation TKSelectCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated{
    
    if (highlighted) {
        
        self.textLabel.textColor = HGMainColor;
    }else{
        self.textLabel.textColor = [UIColor colorWithHexString:@"#333333"];
    }
}


@end
