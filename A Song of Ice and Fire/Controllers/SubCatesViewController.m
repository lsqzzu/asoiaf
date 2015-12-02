//
//  SubCatesViewController.m
//  A Song of Ice and Fire
//
//  Created by Vicent Tsai on 15/12/2.
//  Copyright © 2015年 HeZhi Corp. All rights reserved.
//

#import "SubCatesViewController.h"
#import "WikiViewController.h"

#import "Models.h"
#import "DataManager.h"

@interface SubCatesViewController ()

@property (nonatomic, strong) NSArray *subCates;

@end

@implementation SubCatesViewController

- (void)setParentCategory:(PortalModel *)parentCategory
{
    _parentCategory = parentCategory;

    self.navigationItem.title = _parentCategory.title;

    [[DataManager sharedManager] getSubCatesWithCate:parentCategory.link completionBlock:^(NSArray *subCates) {
        if (subCates.count > 0) {
            _subCates = subCates;

            [self.tableView reloadData];
        }
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.subCates.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
    
    CategoryMemberModel *subCategory = self.subCates[indexPath.row];

    NSString *title = subCategory.title;

    if ([title rangeOfString:@":"].location != NSNotFound) {
        NSArray *temp = [title componentsSeparatedByString:@":"];
        title = temp[1];
    }

    cell.textLabel.text = title;

    return cell;
}

/*
#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here, for example:
    // Create the next view controller.
    <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:<#@"Nib name"#> bundle:nil];
    
    // Pass the selected object to the new view controller.
    
    // Push the view controller.
    [self.navigationController pushViewController:detailViewController animated:YES];
}
*/

@end