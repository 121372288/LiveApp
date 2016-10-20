//
//  MLNewView.m
//  LiveAPP
//
//  Created by 马磊 on 2016/10/11.
//  Copyright © 2016年 MLCode.com. All rights reserved.
//

#import "MLNewView.h"
#import "MLNewViewCell.h"
#import "MLLiveCellModel.h"
#import "MLAllLiveController.h"
@interface MLNewView ()

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) NSMutableArray<MLLiveCellModel *> *contentArray;

@property (nonatomic, assign) NSInteger page;

@end

static NSString *newCellId = @"newCellId";

@implementation MLNewView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.collectionView];
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}
-(void)layoutSubviews{
    [super layoutSubviews];
    self.collectionView.frame = self.bounds;
}

-(NSMutableArray<MLLiveCellModel *> *)contentArray{
    if (_contentArray == nil) {
        _contentArray = [NSMutableArray new];
    }
    return _contentArray;
}

-(UICollectionView *)collectionView{
    if (_collectionView == nil) {
        UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc] init];
        CGFloat padding = 3;
        NSInteger count = 3;
        CGFloat itemWH = (MLScreenWidth - padding * (count + 1) - padding *2) / count;
        layout.minimumLineSpacing = padding;
        layout.minimumInteritemSpacing = padding;
        layout.itemSize = CGSizeMake(itemWH, itemWH);
        UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:layout];
        collectionView.contentInset = UIEdgeInsetsMake(0, padding, 0, padding);
        collectionView.delegate = self;
        collectionView.dataSource = self;
        collectionView.backgroundColor = [UIColor whiteColor];
        [collectionView registerNib:[UINib nibWithNibName:@"MLNewViewCell" bundle:nil] forCellWithReuseIdentifier:newCellId];
        
        collectionView.mj_header =[MJRefreshGifHeader headerWithRefreshingBlock:^{
            [self requestDataPage:1];
        }];
        
        collectionView.mj_footer =[MJRefreshBackGifFooter footerWithRefreshingBlock:^{
            self.page +=1;
            [self requestDataPage:self.page];
            
        }];
        [collectionView.mj_header beginRefreshing];
        
        _collectionView = collectionView;
    }
    return _collectionView;
}

- (void)requestDataPage:(NSInteger)page {
    [MLRequestManager requestDataWithUrl:LIVENEWLISTURL(page) parametr:nil header:nil mehtod:MLRequestManagerMehtodGET compelet:^(NSData *data) {
        if (page ==1) {
            [self.contentArray removeAllObjects];
        }
        self.page = page;
        NSDictionary *dic =[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        
        if ([dic[@"code"]  isEqual:@"100"]) {
            for (NSDictionary *dict in dic[@"data"][@"list"]) {
                MLLiveCellModel *model =[[MLLiveCellModel alloc]init];
                [model setValuesForKeysWithDictionary:dict];
                [self.contentArray addObject:model];
            }
        }
    } updateUI:^{
        [self.collectionView reloadData];
        [self.collectionView.mj_header endRefreshing];
        [self.collectionView.mj_footer endRefreshing];

    } transmissionError:^(NSError *error) {
        [self.collectionView.mj_header endRefreshing];
        [self.collectionView.mj_footer endRefreshing];
    }];
}


@end

@implementation MLNewView(Extension)

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.contentArray.count;
    
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    MLNewViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:newCellId forIndexPath:indexPath];
    
    cell.backgroundColor = [UIColor purpleColor];
    
    cell.model = self.contentArray[indexPath.item];
    
    return cell;
    
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    MLAllLiveController *allLiveVC = [MLAllLiveController shareManager];
    [allLiveVC presentToNextViewControllerWithIdentifying:MLLiveScrollViewTypeHot VCInfoArray: self.contentArray clickNumber:indexPath.item];
    
}

@end
