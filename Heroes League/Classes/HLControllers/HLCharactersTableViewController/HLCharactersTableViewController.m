//
//  HLCharactersTableViewController.m
//  Heroes League
//
//  Created by Ilkhom Khodjaev on 7/3/16.
//  Copyright © 2016 HL. All rights reserved.
//

#import "HLCharactersTableViewController.h"

@interface HLCharactersTableViewController ()

@end

@implementation HLCharactersTableViewController {
    NSMutableArray *_dataProvider;
    NSArray *_cellIds;
    
    int _currOffset;
    BOOL _isLoading;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _cellIds = @[@"HLCharacterLightTableViewCell", @"HLCharacterDarkTableViewCell"];
    
    _currOffset = 0;
    _dataProvider = [[HLCharacter MR_findAllSortedBy:@"name" ascending:YES] mutableCopy];
    
    if (_dataProvider.count == 0) {
        [self showProgress];
        [self loadNextCharacters];
    } else
        _currOffset = (int)[_dataProvider count];
    
    __weak __typeof(self)weakSelf = self;
    [self.tableView addPullToRefreshWithActionHandler:^{
        __strong __typeof(self)strongSelf = weakSelf;
        [strongSelf loadNextCharacters];
    } position:SVPullToRefreshPositionBottom];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadNextCharacters {
    if (!_isLoading) {
        _isLoading = YES;
        [self.tableView.pullToRefreshView startAnimating];
        [HLClientAPI getCharactersWithOffset:_currOffset delegate:self];
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:kCharacterDetailsSegue]) {
        HLCharacterDetailsViewController *vc = segue.destinationViewController;
        vc.charID = [(HLCharacter *)[_dataProvider objectAtIndex:[self.tableView indexPathForSelectedRow].row] serverID];
    }
}

#pragma mark - HLConnectionManagerDelegate
- (void)connectionDidFinishWithOperation:(RKObjectRequestOperation *)operation mappingResult:(RKMappingResult *)mappingResult userParams:(NSDictionary *)userParams error:(NSError *)error {
    NSString *requestField = [userParams objForKey:REQUEST_FIELD];
    if (!error) {
        if ([requestField isEqualToString:REQUEST_FIELD_GET_CHARACTERS]) {
            _dataProvider = [[HLCharacter MR_findAllSortedBy:@"name" ascending:YES] mutableCopy];
            _currOffset = (int)[HLCharacter MR_countOfEntities];
            [self.tableView reloadData];
            [self.tableView.pullToRefreshView stopAnimating];
            _isLoading = NO;
        }
    } else {
        if ([requestField isEqualToString:REQUEST_FIELD_GET_CHARACTERS]) {
            [self.tableView.pullToRefreshView stopAnimating];
            _isLoading = NO;
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Server error"
                                                                           message:operation.error.localizedDescription
                                                                    preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *action = [UIAlertAction actionWithTitle:@"Cancel"
                                                             style:UIAlertActionStyleCancel
                                                           handler:^(UIAlertAction * _Nonnull action) {
                                                               [alert dismissViewControllerAnimated:YES completion:nil];
                                                           }];
            [alert addAction:action];
            action = [UIAlertAction actionWithTitle:@"Retry"
                                              style:UIAlertActionStyleDefault
                                            handler:^(UIAlertAction * _Nonnull action) {
                                                [self.tableView triggerPullToRefresh];
                                            }];
            [alert addAction:action];
            [self presentViewController:alert animated:YES completion:nil];
        }
    }
    [self hideProgress];
}

#pragma mark - UITableView methods
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataProvider.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger row = indexPath.row;
    NSString *reuseID = [_cellIds objectAtIndex:row % 2];
    HLCharacterTableViewCell *cell = (HLCharacterTableViewCell *)[tableView dequeueReusableCellWithIdentifier:reuseID forIndexPath:indexPath];
    
    HLCharacter *chtr = [_dataProvider objectAtIndex:row];
    cell.nameLbl.text = chtr.name;
    cell.descLbl.text = chtr.info;
    [cell.thumbView sd_setImageWithURL:[NSURL URLWithString:chtr.thumbnailURL] placeholderImage:[UIImage randomColoredImageWithText:[chtr.name firstLettersWithWordNum:2] size:cell.frame.size]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [cell setSelected:NO animated:YES];
    
    [self performSegueWithIdentifier:kCharacterDetailsSegue sender:self];
}


@end
