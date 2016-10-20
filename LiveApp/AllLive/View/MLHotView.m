//
//  MLHotView.m
//  LiveAPP
//
//  Created by 马磊 on 2016/10/11.
//  Copyright © 2016年 MLCode.com. All rights reserved.
//

#import "MLHotView.h"

#import "MLLiveTableViewCell.h"
#import "MLLiveCellModel.h"
#import "MLAllLiveController.h"
@interface MLHotView ()

@property (nonatomic, strong) NSMutableArray<MLLiveCellModel *> *contentArray;
@property (nonatomic, assign) NSInteger dataPage;
@property(nonatomic,assign)CGFloat recordY;

@end
static NSString *liveTableViewCell = @"LiveTableViewCell";
@implementation MLHotView

-(NSMutableArray *)contentArray{
    if (_contentArray == nil) {
        _contentArray = [NSMutableArray new];
    }
    return _contentArray;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    self.tableView.frame = self.bounds;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.recordY = 0;
        self.tableView = [[UITableView alloc] initWithFrame:self.bounds style:UITableViewStylePlain];
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.tableView.showsVerticalScrollIndicator = false;
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        [self.tableView registerNib:[UINib nibWithNibName:@"MLLiveTableViewCell" bundle:nil] forCellReuseIdentifier:liveTableViewCell];
        [self addSubview:self.tableView];
        
        [self requestDataPage:1];
        
        self.tableView.mj_header =[MJRefreshGifHeader headerWithRefreshingBlock:^{
            self.tableView.tag =1;
            [self requestDataPage:1];
        }];
        
        self.tableView.mj_footer =[MJRefreshBackGifFooter footerWithRefreshingBlock:^{
            self.dataPage +=1;
            [self requestDataPage:self.dataPage];
        }];
        [self.tableView.mj_header beginRefreshing];
    }
    return self;
}

- (void)requestDataPage:(NSInteger)page{
    [MLRequestManager requestDataWithUrl:LIVELISTURL(page) parametr:nil header:nil mehtod:MLRequestManagerMehtodGET compelet:^(NSData *data) {
        if (page ==1) {
            [self.contentArray removeAllObjects];
        }
        self.dataPage = page;
        NSDictionary *dic =[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        if ([dic[@"code"]  isEqual:@"100"]) {
            for (NSDictionary *dict in dic[@"data"][@"list"]) {
                MLLiveCellModel *model =[[MLLiveCellModel alloc] init];
                [model setValuesForKeysWithDictionary:dict];
                [self.contentArray addObject:model];
            }
        }
    } updateUI:^{
        [self.tableView reloadData];
        [self.tableView.mj_footer endRefreshing];
        [self.tableView.mj_header endRefreshing];
    } transmissionError:^(NSError *error) {
        
    }];
}


@end

@implementation MLHotView(Externsion)

#pragma mark tableDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.contentArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MLLiveTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:liveTableViewCell forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.model = self.contentArray[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return MLScreenHeight * 0.633f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:true];
     MLAllLiveController *allLiveVC = [MLAllLiveController shareManager];
    [allLiveVC presentToNextViewControllerWithIdentifying:MLLiveScrollViewTypeHot VCInfoArray: self.contentArray clickNumber:indexPath.row];
    
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    if (scrollView.isDragging) {
        if (scrollView.contentOffset.y>0 ) {
            MLAllLiveController *allLiveVC = [MLAllLiveController shareManager];
            if (scrollView.contentOffset.y>self.recordY) {
                    [allLiveVC hiddenNCAndTC];
            }else if(scrollView.contentOffset.y <self.recordY){
                if (scrollView.contentOffset.y <  self.tableView.contentSize.height- MLScreenHeight  ) {
                        [allLiveVC appearNCAndTC];
                }
            }
            self.recordY =scrollView.contentOffset.y;
        }
    }
}

@end


