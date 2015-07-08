//
//  TracksViewController.m
//  Trails-iOS
//
//  Created by Georgi Christov on 19/06/2015.
//  Copyright (c) 2015 Callender Bell Development. All rights reserved.
//

#import "TracksViewController.h"

@interface TracksViewController () {
    
    NSMutableArray *items;
    BOOL isDownloading;
}

@end

@implementation TracksViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    isDownloading = NO;
    items = [NSMutableArray new];
    
    [self setupLoadingIndicator];
    [self setupTableView];
    
    [self loadItems:YES withOffset:_offset];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Loading

- (void)refresh {
    _offset = 0;
    _canLoadMore = YES;
    
    [self loadItems:NO withOffset:_offset];
}

- (void)loadItems:(BOOL)isStart withOffset:(int)o {
    if (items.count <= 0 && !_isDownloading) {
        if (isStart)
            [loadingIndicator startAnimating];
        
        _theTable.tableHeaderView = nil;
    }
    
    [self showLoadingIndicator];
    
    _isDownloading = YES;
    
    [GTNotificationManager getNotificationsWithStart:o numberOfItems:MAX_ITEMS useCache:isStart successBlock:^(GTResponseObject *response) {
        HomeViewController *vc = [SlideNavigationController sharedInstance].viewControllers[0];
        vc.unseenNotificationsCount = 0;
        [vc updateUnseenNotificationsBadge];
        
        if (o == 0)
            [items removeAllObjects];
        
        [items addObjectsFromArray:response.object];
        
        if ([response.object count] <= 0 || [response.object count] < MAX_ITEMS)
            _canLoadMore = NO;
        
        [self finalizeLoad];
    } cacheBlock:^(GTResponseObject *response) {
        [items removeAllObjects];
        [items addObjectsFromArray:response.object];
        
        [self finalizeCacheLoad];
    } failureBlock:^(GTResponseObject *response) {
        _canLoadMore = NO;
        
        [self finalizeLoad];
        
        if (response.reason == AUTHORIZATION_NEEDED) {
            [Utils logoutUserAndShowLoginController];
            [Utils showMessage:APP_NAME message:@"Your session has timed out. Please login again."];
        }
        else
            [Utils showMessage:APP_NAME message:response.message];
    }];
}

- (void)finalizeCacheLoad {
    [loadingIndicator stopAnimating];
    
    [_theTable reloadData];
}

- (void)finalizeLoad {
    [_theTable ins_endPullToRefresh];
    [self removeLoadingIndicator];
    [loadingIndicator stopAnimating];
    
    _isDownloading = NO;
    [_theTable ins_endInfinityScroll];
    [_theTable ins_setInfinityScrollEnabled:_canLoadMore];
    
    [_theTable reloadData];
    
    [self checkNoItemsHeader];
}

- (void)showLoadingIndicator {
    UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    indicator.hidesWhenStopped = YES;
    [indicator startAnimating];
    
    [self.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc] initWithCustomView:indicator] animated:YES];
}

- (void)removeLoadingIndicator {
    UIBarButtonItem *reload = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(refresh)];
    
    [self.navigationItem setRightBarButtonItem:reload animated:YES];
}

- (void)checkNoItemsHeader {
    if (items.count <= 0) {
        UILabel *l = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, _theTable.frame.size.width, 70)];
        l.textAlignment = NSTextAlignmentCenter;
        l.text = @"No items found";
        l.textColor = [UIColor lightGrayColor];
        l.font = [UIFont systemFontOfSize:15];
        _theTable.tableHeaderView = l;
    }
    else
        _theTable.tableHeaderView = nil;
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}

@end
