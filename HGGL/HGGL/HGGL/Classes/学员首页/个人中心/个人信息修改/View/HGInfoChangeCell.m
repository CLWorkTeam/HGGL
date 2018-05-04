//
//  HGInfoChangeCell.m
//  HGGL
//
//  Created by taikang on 2018/5/2.
//  Copyright © 2018年 HGGL. All rights reserved.
//

#import "HGInfoChangeCell.h"

@interface HGInfoChangeCell ()<UITextFieldDelegate>

@property (nonatomic,strong) UIView *btnView;

@property (nonatomic,strong) anyButton *nanBtn;
@property (nonatomic,strong) anyButton *nvBtn;


@end

@implementation HGInfoChangeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupSubviews];
    }
    return self;
}

- (void)setupSubviews{
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(WIDTH_PT(15),HEIGHT_PT(10), HGScreenWidth, HEIGHT_PT(15))];
    label.textColor = [UIColor colorWithHexString:@"#333333"];
    label.font = [UIFont systemFontOfSize:FONT_PT(14)];
    label.text = @"真实姓名：";
    [label sizeToFit];
    self.titleLab = label;
    [self.contentView addSubview:label];

    UITextField *textF = [[UITextField alloc]initWithFrame:CGRectMake(label.maxX+WIDTH_PT(10), HEIGHT_PT(2), HGScreenWidth-label.maxX-WIDTH_PT(20), HEIGHT_PT(16)+label.height)];
    textF.font = [UIFont systemFontOfSize:FONT_PT(14)];
    textF.borderStyle = UITextBorderStyleRoundedRect;
    textF.clearButtonMode = UITextFieldViewModeWhileEditing;
    textF.delegate = self;
    self.textF = textF;
    [self.contentView addSubview:textF];
    
    UIView *btnView = [[UIView alloc]initWithFrame:CGRectMake(label.maxX + WIDTH_PT(10), textF.y, WIDTH_PT(110), textF.height)];
    btnView.backgroundColor = [UIColor whiteColor];
    self.btnView = btnView;
    [self.contentView addSubview:btnView];

    anyButton *nanBtn = [anyButton buttonWithType:UIButtonTypeCustom];
    nanBtn.frame = CGRectMake(WIDTH_PT(2), 0, btnView.width/2, btnView.height);
    [nanBtn setImage:[UIImage imageNamed:@"icon_xuanze"] forState:UIControlStateNormal];
    [nanBtn setImage:[UIImage imageNamed:@"icon_xuanze_check"] forState:UIControlStateSelected];
    [nanBtn setTitle:@"男" forState:UIControlStateNormal];
    [nanBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [nanBtn.titleLabel setFont:[UIFont systemFontOfSize:FONT_PT(15)]];
    [nanBtn changeImageFrame:CGRectMake(0, (btnView.height-HEIGHT_PT(18))/2, WIDTH_PT(18), HEIGHT_PT(18))];
    [nanBtn changeTitleFrame:CGRectMake(WIDTH_PT(22), (btnView.height-HEIGHT_PT(18))/2, WIDTH_PT(20), HEIGHT_PT(18))];
    nanBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [nanBtn addTarget:self action:@selector(nanClick:) forControlEvents:UIControlEventTouchUpInside];
    self.nanBtn = nanBtn;
    [btnView addSubview:nanBtn];
    
    anyButton *nvBtn = [anyButton buttonWithType:UIButtonTypeCustom];
    nvBtn.frame = CGRectMake(nanBtn.maxX+WIDTH_PT(5), nanBtn.y, btnView.width/2, btnView.height);
    [nvBtn setImage:[UIImage imageNamed:@"icon_xuanze"] forState:UIControlStateNormal];
    [nvBtn setImage:[UIImage imageNamed:@"icon_xuanze_check"] forState:UIControlStateSelected];
    [nvBtn setTitle:@"女" forState:UIControlStateNormal];
    [nvBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [nvBtn.titleLabel setFont:[UIFont systemFontOfSize:FONT_PT(15)]];
    [nvBtn changeImageFrame:CGRectMake(0, (btnView.height-HEIGHT_PT(18))/2, WIDTH_PT(18), HEIGHT_PT(18))];
    [nvBtn changeTitleFrame:CGRectMake(WIDTH_PT(22), (btnView.height-HEIGHT_PT(18))/2, WIDTH_PT(20), HEIGHT_PT(18))];
    nvBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [nvBtn addTarget:self action:@selector(nanClick:) forControlEvents:UIControlEventTouchUpInside];
    self.nvBtn = nvBtn;
    [btnView addSubview:nvBtn];

}

-(void)setType:(NSInteger)type{
    _type = type;
    if (type==1) {
        self.textF.hidden = NO;
        self.textF.borderStyle = UITextBorderStyleNone;
        self.textF.clearButtonMode = UITextFieldViewModeNever;
        self.textF.enabled = NO;
        self.btnView.hidden = YES;
    }else if (type==2){
        self.textF.hidden = NO;
        self.textF.borderStyle = UITextBorderStyleRoundedRect;
        self.textF.clearButtonMode = UITextFieldViewModeWhileEditing;
        self.textF.enabled = YES;
        self.btnView.hidden = YES;
    }else{
        self.textF.hidden = YES;
        self.btnView.hidden = NO;
    }
}

- (void)nanClick:(UIButton *)sender{
//    sender.selected = !sender.isSelected;
    if (sender==self.nanBtn) {
        self.nanBtn.selected = YES;
        self.nvBtn.selected = NO;
        if (self.block) {
            self.block(self.titleLab.text, @"男");
        }
    }else{
        self.nanBtn.selected = NO;
        self.nvBtn.selected = YES;
        if (self.block) {
            self.block(self.titleLab.text, @"女");
        }
    }
}

-(void)setSex:(NSString *)sex{
    _sex = sex;
    if ([sex isEqualToString:@"男"]) {
        self.nanBtn.selected = YES;
        self.nvBtn.selected = NO;
    }else{
        self.nanBtn.selected = NO;
        self.nvBtn.selected = YES;
    }
    
}

-(void)textFieldDidEndEditing:(UITextField *)textField{
    if (self.block) {
        self.block(self.titleLab.text, textField.text);
    }
}

//-(void)setSex:(BOOL)sex{
//    _sex = sex;
//    self.nanBtn.selected = !sex;
//    self.nvBtn.selected = sex;
//}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
