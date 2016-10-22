//
//  MLInformationHeadView.m
//  LiveAPP
//
//  Created by 马磊 on 2016/10/22.
//  Copyright © 2016年 MLCode.com. All rights reserved.
//

#import "MLInformationHeadView.h"

@interface MLInformationHeadView ()

@property (weak, nonatomic) IBOutlet UIImageView *livePic;

@property (weak, nonatomic) IBOutlet UILabel *liveName;

@property (weak, nonatomic) IBOutlet UILabel *numberOfPeople;

@property (weak, nonatomic) IBOutlet UIButton *catFoodNumber;


@end

@implementation MLInformationHeadView

-(void)awakeFromNib{
    [super awakeFromNib];
    
   
    
    self.livePic.layer.cornerRadius = self.livePic.frame.size.height/2;
    self.livePic.layer.masksToBounds=YES;
    self.livePic.layer.borderWidth = 1;
    self.livePic.layer.borderColor =[[UIColor whiteColor] CGColor];
    
    self.catFoodNumber.layer.masksToBounds=YES;
}

-(void)setLiveID:(NSInteger)liveID{
    _liveID = liveID;
    
    [MLRequestManager requestDataWithUrl:LIVE_DATA_REQUEST_URL(self.liveID) parametr:nil header:nil mehtod:MLRequestManagerMehtodGET compelet:^(NSData *data) {
        NSDictionary *dic =[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        self.liveName.text =dic[@"data"][@"baseInfo"][@"myname"];
        [self.catFoodNumber setTitle:[NSString stringWithFormat:@"猫粮:%@",dic[@"data"][@"otherInfo"][@"catfood"]] forState:UIControlStateNormal];
        [self.livePic loadImageForURLString:dic[@"data"][@"baseInfo"][@"smallpic"]];
    } updateUI:nil transmissionError:nil];
    
    [[RCIMClient sharedRCIMClient] joinChatRoom:[NSString stringWithFormat:@"%ld",self.liveID] messageCount:-1 success:^{
        
    } error:^(RCErrorCode status) {
        NSLog(@"加入聊天室失败");
    }];
    
}



@end
