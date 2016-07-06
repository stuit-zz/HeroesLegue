//
//  HLCharacterDetailsViewController.m
//  Heroes League
//
//  Created by Ilkhom Khodjaev on 7/5/16.
//  Copyright © 2016 HL. All rights reserved.
//

#import "HLCharacterDetailsViewController.h"

static int const kParallaxHeaderHeight = 300;

@implementation HLCharacterDetailsViewController {
    UIImageView *_posterView;
    UILabel *_descLbl;
    UITextView *_textView;
    HLCharacter *_hero;
    
    NSArray *_categoryNameArray;
    NSArray *_comicsArray;
    NSArray *_seriesArray;
    NSArray *_storiesArray;
    NSArray *_eventsArray;
    
    BOOL _isLoading;
}

@synthesize charID = _charID;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _categoryNameArray = @[@"Comics", @"Events", @"Series", @"Stories"];
    
    _hero = [HLCharacter MR_findFirstByAttribute:@"serverID" withValue:self.charID];
    if (!_hero) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Data error"
                                                                       message:@"Cannot find such character"
                                                                preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"OK"
                                                         style:UIAlertActionStyleCancel
                                                       handler:^(UIAlertAction * _Nonnull action) {
                                                           [alert dismissViewControllerAnimated:YES completion:nil];
                                                       }];
        [alert addAction:action];
        [self presentViewController:alert animated:YES completion:nil];
        return;
    }
    
    self.title = _hero.name;
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.allowsSelection = NO;
    self.tableView.showsVerticalScrollIndicator = NO;
    
    _posterView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, MAIN_SCREEN_WIDTH, kParallaxHeaderHeight)];
    [_posterView setBackgroundColor:[UIColor blackColor]];
    [_posterView setContentMode:UIViewContentModeScaleAspectFill];
    [_posterView setUserInteractionEnabled:YES];
    [_posterView.layer setShadowColor:[[UIColor colorWithHex:0x1F2124] CGColor]];
    [_posterView.layer setShadowOffset:CGSizeMake(0, 10)];
    [_posterView.layer setShadowOpacity:.8];
    
    [self.tableView addParallaxWithView:_posterView andHeight:kParallaxHeaderHeight];
    
    _descLbl = [[UILabel alloc] initWithFrame:CGRectZero];
    [_descLbl setFont:[UIFont systemFontOfSize:14]];
    [_descLbl setTextColor:[UIColor whiteColor]];
    [_descLbl setText:@"Bio:"];
    
    _textView = [[UITextView alloc] initWithFrame:CGRectZero];
    [_textView setShowsVerticalScrollIndicator:NO];
    [_textView setScrollEnabled:NO];
    [_textView setEditable:NO];
    [_textView setTextColor:[UIColor whiteColor]];
    [_textView setFont:[UIFont systemFontOfSize:12]];
    [_textView setBackgroundColor:[UIColor clearColor]];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"ANY characters.serverID =[cd] %@", _hero.serverID];
    _comicsArray = [HLComics MR_findAllSortedBy:@"title" ascending:YES withPredicate:predicate];
    _eventsArray = [HLEvent MR_findAllSortedBy:@"title" ascending:YES withPredicate:predicate];
    _seriesArray = [HLSerie MR_findAllSortedBy:@"title" ascending:YES withPredicate:predicate];
    _storiesArray = [HLStory MR_findAllSortedBy:@"title" ascending:YES withPredicate:predicate];
    
    if (!_comicsArray.count && !_eventsArray.count && !_seriesArray.count && !_storiesArray.count) {
        [self loadCharacterDetails];
    }
}

- (void)loadCharacterDetails {
    if (!_isLoading && _hero.serverID) {
        _isLoading = YES;
        [self loadAllCollections];
    }
}

- (void)loadAllCollections {
    [self showProgress];
    [HLClientAPI getCharacterComicsWithID:_hero.serverID delegate:self];
    [HLClientAPI getCharacterEventsWithID:_hero.serverID delegate:self];
    [HLClientAPI getCharacterSeriesWithID:_hero.serverID delegate:self];
    [HLClientAPI getCharacterStoriesWithID:_hero.serverID delegate:self];
}

#pragma mark - HLConnectionManagerDelegate
- (void)connectionDidFinishWithOperation:(RKObjectRequestOperation *)operation mappingResult:(RKMappingResult *)mappingResult userParams:(NSDictionary *)userParams error:(NSError *)error {
    NSNumber *charID = [userParams objForKey:CHARACTER_ID_FIELD];
    NSString *requestField = [userParams objForKey:REQUEST_FIELD];
    if (!error) {
        HLCharacter *character = [HLCharacter MR_findFirstByAttribute:@"serverID" withValue:charID];
        if (character) {
            NSPredicate *predicate = [NSPredicate predicateWithFormat:@"ANY characters.serverID =[cd] %@", _hero.serverID];
            if ([requestField isEqualToString:REQUEST_FIELD_GET_CHARACTER_COMICS]) {
                for (HLComics *comics in mappingResult.array) {
                    if ([comics isKindOfClass:[HLComics class]]) {
                        [comics addCharactersObject:_hero];
                        [self saveToStore];
                    }
                }
                _comicsArray = [HLComics MR_findAllSortedBy:@"title" ascending:YES withPredicate:predicate];
            } else if ([requestField isEqualToString:REQUEST_FIELD_GET_CHARACTER_EVENTS]) {
                for (HLEvent *event in mappingResult.array) {
                    if ([event isKindOfClass:[HLEvent class]]) {
                        [event addCharactersObject:_hero];
                        [self saveToStore];
                    }
                }
                _eventsArray = [HLEvent MR_findAllSortedBy:@"title" ascending:YES withPredicate:predicate];
            } else if ([requestField isEqualToString:REQUEST_FIELD_GET_CHARACTER_SERIES]) {
                for (HLSerie *serie in mappingResult.array) {
                    if ([serie isKindOfClass:[HLSerie class]]) {
                        [serie addCharactersObject:_hero];
                        [self saveToStore];
                    }
                }
                _seriesArray = [HLSerie MR_findAllSortedBy:@"title" ascending:YES withPredicate:predicate];
            } else if ([requestField isEqualToString:REQUEST_FIELD_GET_CHARACTER_STORIES]) {
                for (HLStory *story in mappingResult.array) {
                    if ([story isKindOfClass:[HLStory class]]) {
                        [story addCharactersObject:_hero];
                        [self saveToStore];
                    }
                }
                _storiesArray = [HLStory MR_findAllSortedBy:@"title" ascending:YES withPredicate:predicate];
            }
            [self.tableView reloadData];
        }
    } else {
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
                                            [self loadCharacterDetails];
                                        }];
        [alert addAction:action];
        [self presentViewController:alert animated:YES completion:nil];
    }
    [self hideProgress];
    _isLoading = NO;
}

- (void)saveToStore {
    NSManagedObjectContext *cntx = [NSManagedObjectContext MR_context];
    [cntx MR_saveToPersistentStoreAndWait];
}

#pragma mark - UITableView methods
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 6;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"detailCell"];
    cell.backgroundColor = [UIColor clearColor];
    
    if (!_hero)
        return cell;
    
    if (indexPath.row == 0) {
        if (_hero.thumbnailURL)
            [_posterView sd_setImageWithURL:[NSURL URLWithString:_hero.thumbnailURL] placeholderImage:[UIImage randomColoredImageWithText:[_hero.name firstLettersWithWordNum:2] size:CGSizeMake(kParallaxHeaderHeight, kParallaxHeaderHeight)]];
    } else if (indexPath.row == 1) {
        if (_hero.info && _hero.info.length) {
            [cell addSubview:_descLbl];
            [cell addSubview:_textView];
            [_descLbl mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(cell).with.offset(10);
                make.left.right.equalTo(cell);
                make.height.equalTo(@14);
            }];
            [_textView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(_descLbl.mas_bottom).with.offset(5);
                make.left.right.bottom.equalTo(cell);
            }];
            [_textView setText:_hero.info];
        }
    } else if (indexPath.row >= 2) {
        HLMediaTableViewCell *mCell = [tableView dequeueReusableCellWithIdentifier:@"HLMediaTableViewCell" forIndexPath:indexPath];
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        [layout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
        UICollectionView *collV = mCell.categoryCollectionView;
        collV.tag = indexPath.row;
        collV.collectionViewLayout = layout;
        collV.backgroundColor = [UIColor clearColor];
        collV.decelerationRate = UIScrollViewDecelerationRateFast;
        collV.showsHorizontalScrollIndicator = NO;
        [collV reloadData];
        
        mCell.categoryNameLbl.text = _categoryNameArray[indexPath.row - 2];
        cell = mCell;
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (!_hero)
        return 0;
    
    float height = 0;
    if (indexPath.row == 0) {
        height = 0;
    } else if (indexPath.row == 1) {
        if (_hero.info && _hero.info.length) {
            height = [_hero.info sizeWithFont:[UIFont systemFontOfSize:12] boundingRectToWidth:MAIN_SCREEN_WIDTH lineBreakMode:NSLineBreakByWordWrapping].height;
            height += 30 + _descLbl.frame.size.height;
        }
    } else if (indexPath.row == 2) {
        if (_comicsArray.count)
            height = 150;
    } else if (indexPath.row == 3) {
        if (_eventsArray.count)
            height = 150;
    } else if (indexPath.row == 4) {
        if (_seriesArray.count)
            height = 150;
    } else if (indexPath.row == 5) {
        if (_storiesArray.count)
            height = 150;
    }
    return height;
}

#pragma mark - UICollectionView methods
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    NSArray *tempArr;
    if (collectionView.tag == 2)
        tempArr = _comicsArray;
    else if (collectionView.tag == 3)
        tempArr = _eventsArray;
    else if (collectionView.tag == 4)
        tempArr = _seriesArray;
    else if (collectionView.tag == 5)
        tempArr = _storiesArray;
    return tempArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSArray *tempArr;
    if (collectionView.tag == 2)
        tempArr = _comicsArray;
    else if (collectionView.tag == 3)
        tempArr = _eventsArray;
    else if (collectionView.tag == 4)
        tempArr = _seriesArray;
    else if (collectionView.tag == 5)
        tempArr = _storiesArray;
    
    HLMediaCollectionViewCell *mCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HLMediaCollectionViewCell" forIndexPath:indexPath];
    id data = tempArr[indexPath.row];
    NSString *thumbURL = @"";
    if ([data respondsToSelector:@selector(thumbnailURL)])
        thumbURL = [data performSelector:@selector(thumbnailURL)];
    [mCell.thumbView sd_setImageWithURL:[NSURL URLWithString:thumbURL] placeholderImage:[UIImage randomColoredImageWithText:@"" size:mCell.frame.size]];
    NSString *title = @"";
    if ([data respondsToSelector:@selector(title)])
        title = [data performSelector:@selector(title)];
    [mCell.descLbl setText:title];
    
    return mCell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(100, 150);
}

@end
