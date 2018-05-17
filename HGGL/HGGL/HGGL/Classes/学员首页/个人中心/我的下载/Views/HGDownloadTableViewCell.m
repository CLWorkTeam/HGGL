//
//  HGDownloadTableViewCell.m
//  HGGL
//
//  Created by 陈磊 on 2018/5/10.
//  Copyright © 2018年 HGGL. All rights reserved.
//

#import "HGDownloadTableViewCell.h"
#import "HGLable.h"
#import "TKDownLoadModel.h"
#import "anyButton.h"
@interface HGDownloadTableViewCell ()
@property (nonatomic,weak) UIImageView *ima;
@property (nonatomic,weak) UILabel *nameL;
@property (nonatomic,weak) UILabel *statusL;
@property (nonatomic,weak) anyButton *editButton;
/**
 判断是否已经移除KVO
 */
@property (nonatomic,assign) BOOL isRemoved;
@end
@implementation HGDownloadTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.isRemoved = YES;
        
        [self setUpAllSubviews];
        
    }
    return self;
}
-(void)setUpAllSubviews
{
    UIImageView *ima = [[UIImageView alloc]init];
    ima.contentMode = UIViewContentModeScaleAspectFit;
    [self.contentView addSubview:ima];
    self.ima = ima;
    
    
    UILabel *title = [HGLable lableWithAlignment:NSTextAlignmentLeft Font:HGFont Color:[UIColor blackColor]];
    [self.contentView  addSubview:title];
    self.nameL = title;
    
    UILabel *statusL = [HGLable lableWithAlignment:NSTextAlignmentLeft Font:HGFont Color:HGColor(193, 193, 193, 1)];
    [self.contentView addSubview:statusL];
    self.statusL = statusL;
    
    //选中按钮
    
    anyButton *editButton = [anyButton  buttonWithType:UIButtonTypeCustom];
    
    NSString *selImage  = [[NSBundle mainBundle] pathForResource:@"icon_xuanze_check" ofType:@"png"];
    
    NSString *norImage = [[NSBundle mainBundle] pathForResource:@"icon_xuanze" ofType:@"png"];
    
    [editButton setImage:[UIImage imageWithContentsOfFile:selImage] forState:UIControlStateSelected];
    
    [editButton setImage:[UIImage imageWithContentsOfFile:norImage] forState:UIControlStateNormal];
    
    [editButton  addTarget:self action:@selector(clickEdit:) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:editButton];
    
    self.editButton = editButton;
   
    
}
-(void)clickEdit:(UIButton *)but
{
    
    but.selected = !but.selected;
    if (_editBlock) {
        _editBlock(self.indexPath,but.selected);
    }
    
}

-(void)setIsEdit:(BOOL)isEdit
{
    _isEdit = isEdit;
    
    [self layoutSubviews];
}
-(void)setIsSelected:(BOOL)isSelected
{
    _isSelected = isSelected;
    
    self.editButton.selected = isSelected;
    
    [self layoutSubviews];
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat Wmar = 15;
    CGFloat mar = 5;
    CGFloat buttonH = minH+6;
    CGFloat statusW = [TextFrame frameOfText:@"下载失败" With:[UIFont systemFontOfSize:HGFont] AndHeigh:1000].width;
    
    
    if (self.isEdit) {
        
        self.editButton.frame = CGRectMake(Wmar, self.height/2-buttonH/2, buttonH, buttonH);
        
        self.editButton.hidden = NO;
        
        CGFloat imaW;
        
        if (self.ima.image) {
            imaW = (buttonH)*(self.ima.image.size.height/self.ima.image.size.width);
        }else
        {
            imaW = buttonH;
        }
        
        self.ima.frame = CGRectMake(self.editButton.maxX+mar, self.height/2-(buttonH)/2,imaW , buttonH);
        
        self.nameL.frame = CGRectMake(self.ima.maxX+mar, self.height/2-minH/2, self.width-2*Wmar-self.ima.maxX-mar-statusW, minH);
        
        self.statusL.frame = CGRectMake(self.nameL.maxX+mar, self.nameL.y, statusW, minH);
        
        
    }else
    {
        
        self.editButton.frame = CGRectZero;
        
        self.editButton.hidden = YES;
        
        CGFloat imaW;
        
        if (self.ima.image) {
            imaW = (buttonH)*(self.ima.image.size.height/self.ima.image.size.width);
        }else
        {
            imaW = buttonH;
        }
        
        self.ima.frame = CGRectMake(Wmar, self.height/2-(buttonH)/2,imaW , buttonH);
        
        self.nameL.frame = CGRectMake(self.ima.maxX+mar, self.height/2-minH/2, self.width-2*Wmar-self.ima.maxX-mar-statusW, minH);
        
        self.statusL.frame = CGRectMake(self.nameL.maxX+mar, self.nameL.y, statusW, minH);
        
        
    }
    
}
-(void)setModel:(TKDownLoadModel *)model
{
    _model = model;
    
    self.isRemoved = NO;
    
    [model addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
    NSString *holder;
    
    if ([model.liveId isEqualToString:@"0"]) {
         holder = [[NSBundle mainBundle] pathForResource:@"icon_video" ofType:@"png"];
        
    }else if ([model.liveId isEqualToString:@"1"])
    {
        holder = [[NSBundle mainBundle] pathForResource:@"icon_courseware" ofType:@"png"];
    }else
    {
        holder = [[NSBundle mainBundle] pathForResource:@"icon_small_manual" ofType:@"png"];
    }
    
    self.ima.image = [UIImage imageWithContentsOfFile:holder];

    
    
    
    self.nameL.text = model.titleStr;
    
    [self setStatus:model.status];
    
}
-(void)setStatus:(DownLoadStatus )status
{
    if (status == DownLoadStatusRunqueue) {
        self.statusL.text = @"队列中";
    }else if (status == DownLoadStatusFailed)
    {
        self.statusL.text = @"下载失败";
    }else if (status == DownLoadStatusWaiting)
    {
        self.statusL.text = @"链接中";
    }else if (status == DownLoadStatusCompleted)
    {
        self.statusL.text = @"下载完成";
    }else if (status == DownLoadStatusRunning)
    {
        self.statusL.text = @"下载中";
    }
    
}
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
//    TKDownLoadModel *dm = object;
    
    
    if ([keyPath isEqualToString:@"status"]) {
        if ([change[@"new"] boolValue]) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self setStatus:self.model.status];
            });
            
        }
    }
}
+(instancetype)cellWithTableview:(UITableView *)tableview with:(NSIndexPath *)path
{
    NSString *Id = [NSString stringWithFormat:@"downloadingCell%ld",path.section*1000+path.row];
    HGDownloadTableViewCell *cell = [tableview dequeueReusableCellWithIdentifier:Id];
    if (!cell) {
        cell = [[HGDownloadTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Id];
    }
    if (!cell.isRemoved) {
        [cell removeKVO];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
-(void)dealloc{
    if (!self.isRemoved) {
        [self removeKVO];
    }
}
-(void)removeKVO
{
    
    [self.model removeObserver:self forKeyPath:@"status"];
    self.isRemoved = YES;
}
@end
