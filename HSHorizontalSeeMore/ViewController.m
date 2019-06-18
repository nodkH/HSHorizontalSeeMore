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
@property (nonatomic , strong) HSMoreScrollView *scrollView;

@property (nonatomic , strong) HSHorizontalSeeMoreCollectionView *collectionView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.scrollView = [[HSMoreScrollView alloc] initWithFrame:CGRectMake(0, 100, self.view.frame.size.width, 100)];
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
    
    
    UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
    layout.itemSize = CGSizeMake(self.view.frame.size.width / 4, 100);
    layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing = 10;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    self.collectionView = [[HSHorizontalSeeMoreCollectionView alloc] initWithFrame:CGRectMake(0, self.scrollView.frame.origin.y + self.scrollView.frame.size.height + 50, self.view.frame.size.width, 100) collectionViewLayout:layout];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.view addSubview:self.collectionView];
    self.collectionView.contentSizeWidth = 5 * layout.itemSize.width + (4 * 10);
    
    [self.collectionView registerClass:[CollectionViewCell class] forCellWithReuseIdentifier:@"CollectionViewCell"];
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
