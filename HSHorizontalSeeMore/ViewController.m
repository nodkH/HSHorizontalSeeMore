//
//  ViewController.m
//  HSHorizontalSeeMore
//
//  Created by 孔祥刚 on 2019/6/18.
//  Copyright © 2019 ~~. All rights reserved.
//

#import "ViewController.h"
#import "HSHorizontalSeeMoreCollectionView.h"
#import "HSMoreScrollView.h"
#import "CollectionViewCell.h"

@interface ViewController () <UICollectionViewDelegate , UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

// 创建继承自 HSMoreScrollView 的 scrollView
@property (nonatomic , strong) HSMoreScrollView *scrollView;

// 创建继承自 HSHorizontalSeeMoreCollectionView 的 collectionView
@property (nonatomic , strong) HSHorizontalSeeMoreCollectionView *collectionView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UILabel *scrollLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 100, self.view.frame.size.width, 60)];
    scrollLabel.textColor = [UIColor blackColor];
    scrollLabel.text = @"scroll view";
    [self.view addSubview:scrollLabel];
    
    self.scrollView = [[HSMoreScrollView alloc] initWithFrame:CGRectMake(0, scrollLabel.frame.origin.y + scrollLabel.frame.size.height + 10, self.view.frame.size.width, 100)];
    self.scrollView.layer.borderColor = [UIColor redColor].CGColor;
    self.scrollView.layer.borderWidth = 1;
    //    self.scrollView.backgroundColor = [UIColor redColor];
    self.scrollView.scrollEnabled = YES;
    self.scrollView.showsHorizontalScrollIndicator = YES;
    [self.view addSubview:self.scrollView];
    
    CGFloat ori = 10;
    CGFloat width = self.view.frame.size.width / 4;
    CGFloat y = 0;
    CGFloat height = self.scrollView.frame.size.height;
    
    CGFloat contentSizex = 0;
    
    for (int i = 0; i < 5; i ++) {
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake((ori + width) * i, y, width, height)];
        label.text = [NSString stringWithFormat:@"%d",i];
        label.textColor = [UIColor blackColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.backgroundColor = [UIColor greenColor];
        [self.scrollView addSubview:label];
        
        if (i == 4) {
            contentSizex = label.frame.origin.x + width;
        }
    }
    self.scrollView.contentSizeWidth = contentSizex;
    
    
    UILabel *collectionLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, self.scrollView.frame.origin.y + self.scrollView.frame.size.height + 50, self.view.frame.size.width, 60)];
    collectionLabel.textColor = [UIColor blackColor];
    collectionLabel.text = @"collection view";
    [self.view addSubview:collectionLabel];
    
    UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
    layout.itemSize = CGSizeMake(self.view.frame.size.width / 4, 100);
    layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing = 10;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    self.collectionView = [[HSHorizontalSeeMoreCollectionView alloc] initWithFrame:CGRectMake(0, collectionLabel.frame.origin.y + collectionLabel.frame.size.height + 10, self.view.frame.size.width, 100) collectionViewLayout:layout];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.view addSubview:self.collectionView];
    [self.collectionView registerClass:[CollectionViewCell class] forCellWithReuseIdentifier:@"CollectionViewCell"];
    
    self.collectionView.contentSizeWidth = self.collectionView.collectionViewLayout.collectionViewContentSize.width;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 5;
}


- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CollectionViewCell" forIndexPath:indexPath];
    cell.contentView.backgroundColor = [UIColor greenColor];
    cell.label.text = [NSString stringWithFormat:@"%ld",indexPath.item];
    return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self.collectionView scrollViewDidScroll:scrollView];
}

@end
