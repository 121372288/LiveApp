//
//  MLLiveTableViewCell.m
//  LiveAPP
//
//  Created by 马磊 on 2016/10/11.
//  Copyright © 2016年 MLCode.com. All rights reserved.
//

#import "MLLiveTableViewCell.h"
#import "MLLiveCellModel.h"

@interface MLLiveTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *liveName;
@property (weak, nonatomic) IBOutlet UIImageView *livePic;
@property (weak, nonatomic) IBOutlet UIImageView *liveLevel;
@property (weak, nonatomic) IBOutlet UIButton *liveAddress;
@property (weak, nonatomic) IBOutlet UILabel *liveWatchNumber;
@property (weak, nonatomic) IBOutlet UIImageView *liveImage;

@end

@implementation MLLiveTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    
}

- (void)setModel:(MLLiveCellModel *)model{
    self.liveName.text = model.myname;
    [self.liveAddress setTitle:[NSString stringWithFormat:@"  %@",model.gps] forState:UIControlStateNormal];
    [self.livePic loadImageForURLString:model.smallpic];
    
    self.livePic.layer.cornerRadius =self.livePic.frame.size.width/2;
    self.livePic.layer.masksToBounds =YES;
    self.livePic.layer.borderWidth =1;
    self.livePic.layer.borderColor =[MLColor(205, 47, 99) CGColor];
    [self.liveImage loadImageForURLString: model.bigpic];
     
    self.liveLevel.image =[UIImage imageNamed:[NSString stringWithFormat:@"girl_star%ld_40x19", model.starlevel]];
    
    // 设置当前观众数量
    NSString *fullChaoyang = [NSString stringWithFormat:@"%lu人在看", (unsigned long)model.allnum];
    NSRange range = [fullChaoyang rangeOfString:[NSString stringWithFormat:@"%lu",model.allnum]];
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:fullChaoyang];
    [attr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range: range];
    [attr addAttribute:NSForegroundColorAttributeName value:MLTintColor range:range];
    self.liveWatchNumber.attributedText = attr;
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
