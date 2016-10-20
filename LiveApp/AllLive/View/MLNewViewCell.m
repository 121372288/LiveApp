//
//  MLNewViewCell.m
//  LiveAPP
//
//  Created by 马磊 on 2016/10/20.
//  Copyright © 2016年 MLCode.com. All rights reserved.
//

#import "MLNewViewCell.h"
#import "MLLiveCellModel.h"
@interface MLNewViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *liveAddress;

@property (weak, nonatomic) IBOutlet UIImageView *liveImage;

@property (weak, nonatomic) IBOutlet UILabel *liveName;

@end

@implementation MLNewViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setModel:(MLLiveCellModel *)model{
    _model = model;
    self.liveName.text =model.nickname;
    self.liveAddress.text = [NSString stringWithFormat:@" %@",model.position];
    [self.liveImage loadImageForURLString:model.photo];
}

@end
