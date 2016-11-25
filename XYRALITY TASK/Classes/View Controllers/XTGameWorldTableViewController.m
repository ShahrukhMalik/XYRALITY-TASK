//
//  XTGameWorldTableViewController.m
//  XYRALITY TASK
//
//  Created by Shahrukh on 24/11/2016.
//  Copyright © 2016 Home. All rights reserved.
//

#import "XTGameWorldTableViewController.h"

#import "XTGameWorldTableViewCell.h"

#import "XTSession.h"
#import "XTGameWorld.h"

static NSString *kXTGameWorldCellIdentifier = @"XTGameWorldCellIdentifier";


#pragma mark -

@interface XTGameWorldTableViewController ()

@end


#pragma mark -

@implementation XTGameWorldTableViewController


#pragma mark -
#pragma mark UIViewController methods

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Game Worlds";
    
    // Register custom nib for cell
    [self.tableView registerNib:[UINib nibWithNibName:@"XTGameWorldTableViewCell" bundle:nil] forCellReuseIdentifier:kXTGameWorldCellIdentifier];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    // For full width separators of UITableView
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.tableView setLayoutMargins:UIEdgeInsetsZero];
    }
}


#pragma mark -
#pragma mark UITableViewDataSource methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[XTSession sharedSession].gameWorlds count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    XTGameWorldTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kXTGameWorldCellIdentifier];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    XTGameWorld *gameWorld = [[XTSession sharedSession].gameWorlds objectAtIndex:indexPath.row];
    
    // Configure the cell...
    cell.nameLabel.text = gameWorld.name;
    cell.countryLabel.text = gameWorld.country;
    cell.languageLabel.text = gameWorld.language;
    
    // Alternate background colors for cell to improve readability
    if (indexPath.row % 2 == 0) {
        cell.backgroundColor = [UIColor whiteColor];
        
    } else {
        cell.backgroundColor = [UIColor colorWithRed:0.9f green:0.9f blue:0.9f alpha:1.0f];
    }
    
    return cell;
}


#pragma mark -
#pragma mark UITableViewDelegate methods

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // For full width separator of UITableViewCell
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 95.0f;
}

@end
