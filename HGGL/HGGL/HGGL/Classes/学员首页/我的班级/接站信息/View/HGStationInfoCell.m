//
//  HGStationInfoCell.m
//  HGGL
//
//  Created by taikang on 2018/5/2.
//  Copyright © 2018年 HGGL. All rights reserved.
//

#import "HGStationInfoCell.h"
#import "HcdDateTimePickerView.h"
#import "TKSelectView.h"

@interface HGStationInfoCell ()<UITextFieldDelegate,TKSelectViewDelegate>

@property (nonatomic,strong) UIView *btnView;

@property (nonatomic,strong) anyButton *nanBtn;
@property (nonatomic,strong) anyButton *nvBtn;

@property (nonatomic,strong) NSArray *dataAry;

@end

@implementation HGStationInfoCell

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
    label.font = [UIFont systemFontOfSize:FONT_PT(15)];
    label.text = @"是否接送站：";
    [label sizeToFit];
    self.titleLab = label;
    [self.contentView addSubview:label];
    
    UITextField *textF = [[UITextField alloc]initWithFrame:CGRectMake(label.maxX+WIDTH_PT(10), HEIGHT_PT(2), HGScreenWidth-label.maxX-WIDTH_PT(25), HEIGHT_PT(16)+label.height)];
    textF.font = [UIFont systemFontOfSize:FONT_PT(15)];
    textF.borderStyle = UITextBorderStyleRoundedRect;
    textF.clearButtonMode = UITextFieldViewModeWhileEditing;
    textF.delegate = self;
    self.textF = textF;
    [self.contentView addSubview:textF];
    
    anyButton *btn = [anyButton buttonWithType:UIButtonTypeCustom];
    btn.frame = textF.frame;
    btn.layer.masksToBounds = YES;
    btn.layer.cornerRadius = 5;
    btn.layer.borderColor = [UIColor lightGrayColor].CGColor;
    btn.layer.borderWidth = 1;
    [btn setTitle:@"接站" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:FONT_PT(14)];
    btn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [btn setImage:[UIImage imageNamed:@"icon_btn_down"] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:@"icon_btn_up"] forState:UIControlStateSelected];
    [btn changeTitleFrame:CGRectMake(0, 0, btn.width*0.9, btn.height)];
    [btn changeImageFrame:CGRectMake(btn.width-WIDTH_PT(20), (btn.height-HEIGHT_PT(8))/2, WIDTH_PT(13), HEIGHT_PT(8))];
    [btn addTarget:self action:@selector(selectMenu:) forControlEvents:UIControlEventTouchUpInside];
    self.selectBtn = btn;
    [self.contentView addSubview:btn];

    
    UIView *btnView = [[UIView alloc]initWithFrame:CGRectMake(label.maxX + WIDTH_PT(10), textF.y, WIDTH_PT(110), textF.height)];
    btnView.backgroundColor = [UIColor whiteColor];
    self.btnView = btnView;
    [self.contentView addSubview:btnView];
    
    anyButton *nanBtn = [anyButton buttonWithType:UIButtonTypeCustom];
    nanBtn.frame = CGRectMake(WIDTH_PT(2), 0, btnView.width/2, btnView.height);
    [nanBtn setImage:[UIImage imageNamed:@"icon_xuanze"] forState:UIControlStateNormal];
    [nanBtn setImage:[UIImage imageNamed:@"icon_xuanze_check"] forState:UIControlStateSelected];
    [nanBtn setTitle:@"是" forState:UIControlStateNormal];
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
    [nvBtn setTitle:@"否" forState:UIControlStateNormal];
    [nvBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [nvBtn.titleLabel setFont:[UIFont systemFontOfSize:FONT_PT(15)]];
    [nvBtn changeImageFrame:CGRectMake(0, (btnView.height-HEIGHT_PT(18))/2, WIDTH_PT(18), HEIGHT_PT(18))];
    [nvBtn changeTitleFrame:CGRectMake(WIDTH_PT(22), (btnView.height-HEIGHT_PT(18))/2, WIDTH_PT(20), HEIGHT_PT(18))];
    nvBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [nvBtn addTarget:self action:@selector(nanClick:) forControlEvents:UIControlEventTouchUpInside];
    self.nvBtn = nvBtn;
    [btnView addSubview:nvBtn];
}

-(void)setMark:(NSInteger)mark{
    _mark = mark;
    self.selectBtn.tag = mark;
    if (mark==1) {
        [self.selectBtn setTitle:@"接站" forState:UIControlStateNormal];
        if (self.block) {
            self.block(self.titleLab.text, self.selectBtn.titleLabel.text);
        }
    }else if (mark==5){
        NSString *url = [HGURL stringByAppendingString:@"Reception/getVehList.do"];
        [HGHttpTool POSTWithURL:url parameters:@{} success:^(id responseObject) {
            NSLog(@"%@",responseObject);
            if ([responseObject[@"status"] isEqualToString:@"1"]) {
                NSMutableArray *tempAry = [NSMutableArray array];
                NSArray *ary = responseObject[@"data"];
                for (NSDictionary *dict in ary) {
                    [tempAry addObject:dict[@"addressName"]];
                }
                self.dataAry = tempAry;
                [self.selectBtn setTitle:tempAry.firstObject forState:UIControlStateNormal];
                if (self.block) {
                    self.block(self.titleLab.text, self.selectBtn.titleLabel.text);
                }
            }else{
            }
        } failure:^(NSError *error) {
            NSLog(@"%@",error);
        }];
    }else if (mark==6){
        NSDate *date = [NSDate date];
        NSDateFormatter *dateFor = [[NSDateFormatter alloc]init];
        dateFor.dateFormat = @"yyyy-MM-dd";
        NSString *dateStr = [dateFor stringFromDate:date];
        [self.selectBtn setTitle:dateStr forState:UIControlStateNormal];
        if (self.block) {
            self.block(self.titleLab.text, self.selectBtn.titleLabel.text);
        }
    }else if (mark==7){
        NSDate *date = [NSDate date];
        NSDateFormatter *dateFor = [[NSDateFormatter alloc]init];
        dateFor.dateFormat = @"HH:mm";
        NSString *dateStr = [dateFor stringFromDate:date];
        [self.selectBtn setTitle:dateStr forState:UIControlStateNormal];
        if (self.block) {
            self.block(self.titleLab.text, self.selectBtn.titleLabel.text);
        }
    }
}
-(void)setType:(NSInteger)type{
    
    //用来判断cell的类型.1.label 2.textfield 3.单选按钮 4.下拉按钮
    
    _type = type;
    if (type==1) {
        self.textF.hidden = NO;
        self.textF.borderStyle = UITextBorderStyleNone;
        self.textF.clearButtonMode = UITextFieldViewModeNever;
        self.textF.enabled = NO;
        self.btnView.hidden = YES;
        self.selectBtn.hidden = YES;
    }else if (type==2){
        self.textF.hidden = NO;
        self.textF.borderStyle = UITextBorderStyleRoundedRect;
        self.textF.clearButtonMode = UITextFieldViewModeWhileEditing;
        self.textF.enabled = YES;
        self.btnView.hidden = YES;
        self.selectBtn.hidden = YES;
    }else if(type==3){
        self.textF.hidden = YES;
        self.btnView.hidden = NO;
        self.selectBtn.hidden = YES;
    }else{
        self.textF.hidden = YES;
        self.btnView.hidden = YES;
        self.selectBtn.hidden = NO;
    }
}

- (void)nanClick:(UIButton *)sender{
    //    sender.selected = !sender.isSelected;
    [HGKeywindow endEditing:YES];
    if (sender==self.nanBtn) { //选择是
        self.nanBtn.selected = YES;
        self.nvBtn.selected = NO;
        if (self.block) {
            self.block(self.titleLab.text, @"是");
        }
    }else{
        self.nanBtn.selected = NO;
        self.nvBtn.selected = YES;
        if (self.block) {
            self.block(self.titleLab.text, @"否");
        }
    }
}
-(void)setSendStation:(BOOL)sendStation{
    _sendStation = sendStation;
    if (sendStation==YES) {
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

- (void)selectMenu:(anyButton *)sender{
    
    [HGKeywindow endEditing:YES];

    sender.selected = !sender.isSelected;
    [self showListViewWithMark:self.mark];
}

//点击每个cell的按钮的方法
- (void)showListViewWithMark:(NSInteger)mark{

    if (mark == 1) {
        NSArray *ary = @[@"接站",@"送站"];
        self.dataAry = ary;
        [self showListViewWithAry:ary];
    }else if (mark == 5){
        [self showListViewWithAry:self.dataAry];
    }else if (mark==6){
        
        HcdDateTimePickerView *dateTimePickerView = [[HcdDateTimePickerView alloc] initWithDatePickerMode:DatePickerDateMode defaultDateTime:[[NSDate alloc]initWithTimeIntervalSinceNow:0]];
        dateTimePickerView.clickedOkBtn = ^(NSString * datetimeStr){
            NSDateFormatter *dateFor = [[NSDateFormatter alloc]init];
            dateFor.dateFormat = @"yyyy-MM-dd";
            NSDate *date = [dateFor dateFromString:datetimeStr];
            NSString *dateStr = [dateFor stringFromDate:date];
            [self.selectBtn setTitle:dateStr forState:UIControlStateNormal];
            self.selectBtn.selected = NO;
            if (self.block) {
                self.block(self.titleLab.text, self.selectBtn.titleLabel.text);
            }
        };
        [HGKeywindow addSubview:dateTimePickerView];
        [dateTimePickerView showHcdDateTimePicker];
    }else if (mark == 7){
        
        HcdDateTimePickerView *dateTimePickerView = [[HcdDateTimePickerView alloc] initWithDatePickerMode:DatePickerHourMinuteMode defaultDateTime:[[NSDate alloc]initWithTimeIntervalSinceNow:0]];
        dateTimePickerView.clickedOkBtn = ^(NSString * datetimeStr){
            [self.selectBtn setTitle:datetimeStr forState:UIControlStateNormal];
            self.selectBtn.selected = NO;
            if (self.block) {
                self.block(self.titleLab.text, self.selectBtn.titleLabel.text);
            }
        };
        [HGKeywindow addSubview:dateTimePickerView];
        [dateTimePickerView showHcdDateTimePicker];
    }
    
}

- (void)showListViewWithAry:(NSArray *)ary{
    TKSelectView *selectV = [[TKSelectView alloc]init];
    selectV.delegate = self;
    selectV.frame = HGKeywindow.bounds;
    selectV.dataAry = ary;
    [HGKeywindow addSubview:selectV];
}

-(void)didSelectTableView:(TKSelectView *)selectView row:(NSInteger)row{
    [self.selectBtn setTitle:self.dataAry[row] forState:UIControlStateNormal];
    self.selectBtn.selected = NO;
    if (self.block) {
        self.block(self.titleLab.text, self.selectBtn.titleLabel.text);
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
