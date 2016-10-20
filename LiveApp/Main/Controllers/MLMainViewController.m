//
//  MLMainViewController.m
//  LiveAPP
//
//  Created by 马磊 on 2016/10/10.
//  Copyright © 2016年 MLCode.com. All rights reserved.
//

#import "MLMainViewController.h"
#import "MLNavigationController.h"
#import "MLAllLiveController.h"
#import "MLProfileController.h"

@interface MLMainViewController ()

@end

@implementation MLMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    MLAllLiveController *liveVC = [MLAllLiveController shareManager];
    
    MLProfileController * profileVC = [[MLProfileController alloc] init];
    
    NSArray *childVCs = @[liveVC, profileVC];
    
    NSMutableArray *childNavVCs = [[NSMutableArray alloc] initWithCapacity:childVCs.count];
    
    for (UIViewController *childVC in childVCs) {
        MLNavigationController *navigationVC = [[MLNavigationController alloc] initWithRootViewController:childVC];
        
        [childNavVCs addObject:navigationVC];
        
    }
    self.viewControllers = childNavVCs;
    
    [self setUpTabBar];
}

- (void)setUpTabBar{
    self.tabBar.backgroundImage = [[UIImage alloc] init];
    self.tabBar.backgroundColor = MLColor(26, 26, 26);
    
    NSArray *array = @[@{@"title": @"", @"image":@"tabbar_home", @"selectedImage": @"tabbar_home2"},
                       @{@"title": @"", @"image":@"tabbar_my", @"selectedImage": @"tabbar_my2"}];
    
    for (int i=0; i<self.viewControllers.count; i++) {
        UINavigationController *navigation = self.viewControllers[i];
        NSDictionary *tabDesc = array[i];
        [self setTabBarItemWithController:navigation.viewControllers.firstObject image:tabDesc[@"image"] selectedImage:tabDesc[@"selectedImage"] title:tabDesc[@"title"]];
    }

}

- (void)setTabBarItemWithController:(UIViewController *)viewController image:(NSString *)imageName selectedImage:(NSString *)selectedImageName title:(NSString *)title{
    
    UIImage *image  = [[UIImage imageNamed:imageName]              imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UIImage *imageSelect = [[UIImage imageNamed:selectedImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    viewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:title image:image selectedImage:imageSelect];
    viewController.tabBarItem.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
