//
//  CatListViewController.h
//  A Song of Ice and Fire
//
//  Created by Vicent Tsai on 15/11/23.
//  Copyright © 2015年 HeZhi Corp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PortalModel.h"

@interface CatListViewController : UITableViewController

@property (nonatomic, strong) PortalModel *parentCategory;

@end
