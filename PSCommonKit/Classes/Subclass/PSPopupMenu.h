//
//  PSPopupMenu.h
//  PSPopupMenu
//
//  Created by rsf on 2019/3/27.
//

#import <UIKit/UIKit.h>

#define PSPopupMenuGetX(arrowX, menuW, arrowRightMargin, arrowInternalCenterSpacing)\
					   (arrowX -(menuW -arrowRightMargin -arrowInternalCenterSpacing))

typedef NS_ENUM(NSInteger, PSArrowDirection) {
	
	PSArrowDirectionNone = 0,
	PSArrowDirectionLeft,
	PSArrowDirectionRight,
	PSArrowDirectionMiddle
};

NS_ASSUME_NONNULL_BEGIN

@class PSPopupMenu,PSPopupMenuConfig;

@protocol PSPopupMenuDataSource <NSObject>

@required
- (NSInteger)numberOfRowsForPopupMenu:(PSPopupMenu *)popupMenu;
- (NSArray<NSString *> *)titlesForPopupMenu:(PSPopupMenu *)popupMenu;
- (NSArray<UIImage *> *)imagesForPopupMenu:(PSPopupMenu *)popupMenu;

@optional
- (UICollectionViewCell *)contentCellWithCollectionView:(UICollectionView *)collectionView
									  cellForRowAtIndex:(NSInteger)index;

@end

@protocol PSPopupMenuDelegate <NSObject>

@optional
- (void)popupMenu:(PSPopupMenu *)popupMenu didSelectItemAtIndex:(NSInteger)index;

@end

@interface PSPopupMenu : UIView

@property (nonatomic, weak) id<PSPopupMenuDataSource> dataSource;
@property (nonatomic, weak) id<PSPopupMenuDelegate> delegate;
@property (nonatomic, strong) PSPopupMenuConfig *config;

@property (nonatomic, copy, readonly) NSArray *titles;
@property (nonatomic, copy, readonly) NSArray *images;

- (instancetype)initWithFrame:(CGRect)frame;

- (void)show;
- (void)showInView:(UIView *)view;
- (void)dismiss;

@end

@interface PSPopupMenuConfig : NSObject

#pragma mark - arrow

/**
 箭头方向 default is PSArrowDirectionRight
 */
@property (nonatomic, assign) PSArrowDirection arrowDirection;

/**
 箭头左距离边缘距离 default is 30.0f
 */
@property (nonatomic, assign) CGFloat arrowLeftMargin;

/**
 箭头右距离边缘距离 default is 30.0f
 */
@property (nonatomic, assign) CGFloat arrowRightMargin;

/**
 箭头内部高度 default is 8.0f
 */
@property (nonatomic, assign) CGFloat arrowInternalHeight;

/**
 箭头内部中心间距(三角底边长度一半) default is 8.0f
 */
@property (nonatomic, assign) CGFloat arrowInternalCenterSpacing;


#pragma mark - mask

/**
 遮罩背景颜色 default is [UIColor clearColor]
 */
@property (nonatomic, strong) UIColor *maskBackgroundColor;


#pragma mark - menu

/**
 菜单圆角 default is 4.0f
 */
@property (nonatomic, assign) CGFloat menuRadius;

/**
 菜单背景颜色 default is [UIColor whiteColor]
 */
@property (nonatomic, strong) UIColor *menuBackgroundColor;


#pragma mark - textLabel

/**
 文字颜色 default is #333333;
 */
@property (nonatomic, strong) UIColor *textLabelColor;

/**
 文字大小 default is 12px
 */
@property (nonatomic, strong) UIFont *textLabelFont;

/**
 文字左侧间距 default is 24.0f
 */
@property (nonatomic, assign) CGFloat textLabelLeftMargin;

/**
 文字右侧间距 default is 22.0f
 */
@property (nonatomic, assign) CGFloat textLabelRightMargin;


#pragma mark - image

/**
 图片填充模式 default is UIViewContentModeScaleAspectFill
 */
@property (nonatomic, assign) UIViewContentMode imageViewContentMode;

/**
 图片左侧间距 default is 24.0f
 */
@property (nonatomic, assign) CGFloat imageLeftMargin;


#pragma mark - separator

/**
 分割线高度 default is 0.5f
 */
@property (nonatomic, assign) CGFloat separatorHeight;

/**
 分割线高度颜色, default is [UIColor  lightGrayColor]
 */
@property (nonatomic, strong) UIColor *separatorColor;

/**
 是否显示分割线 default is YES
 */
@property (nonatomic, assign) BOOL displaySeparat;


#pragma mark - shadow

/**
 是否显示阴影 default is YES
 */
@property (nonatomic, assign) BOOL displayShadow;


+ (instancetype)defaultConfig;

@end

NS_ASSUME_NONNULL_END
