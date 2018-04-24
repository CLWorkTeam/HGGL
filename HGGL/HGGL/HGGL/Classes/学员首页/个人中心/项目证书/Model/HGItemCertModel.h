//
//  HGItemCertModel.h
//  HGGL
//
//  Created by taikang on 2018/4/23.
//  Copyright © 2018年 HGGL. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HGItemCertModel : NSObject

@property (nonatomic,copy) NSString *project_id;
@property (nonatomic,copy) NSString *project_name;
@property (nonatomic,copy) NSString *credential_name;
@property (nonatomic,copy) NSString *credential_id;
@property (nonatomic,copy) NSString *credential_url;
@property (nonatomic,copy) NSString *credential_date;

@end
