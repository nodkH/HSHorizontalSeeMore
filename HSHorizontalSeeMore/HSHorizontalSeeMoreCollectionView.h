//
//  HSHorizontalSeeMoreCollectionView.h
//  HSHorizontalSeeMore
//
//  Created by 孔祥刚 on 2019/6/18.
//  Copyright © 2019 ~~. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HSHorizontalSeeMoreCollectionView : UICollectionView

@property (nonatomic , assign) CGFloat contentSizeWidth;

- (void)scrollViewDidScroll:(UIScrollView *)scrollView;
@end

NS_ASSUME_NONNULL_END
