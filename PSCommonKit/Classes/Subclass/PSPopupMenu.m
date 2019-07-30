//
//  PSPopupMenu.m
//  PSPopupMenu
//
//  Created by rsf on 2019/3/27.
//

#import "PSPopupMenu.h"
#import "UIView+CommonKit.h"

#define kCellReuseIdentifier   @"PSMenuCell"
#define kColorFromRGBA(hexValue, alphaValue) [UIColor \
colorWithRed:((float)((hexValue & 0xFF0000) >> 16))/255.0 \
green:((float)((hexValue & 0x00FF00) >> 8))/255.0 \
blue:((float)(hexValue & 0x0000FF))/255.0 \
alpha:alphaValue]

@interface PSMaskView : UIView

@property (nonatomic, assign) PSArrowDirection arrowDirection;
@property (nonatomic, strong) PSPopupMenuConfig *config;

@end

@interface PSPopupMenu ()<UICollectionViewDelegate,UICollectionViewDataSource> {
	CALayer *_groundLayer;
	UITableView *_tableView;
	PSMaskView *_maskView;
	UICollectionView *_collectionView;
	BOOL _isShowing;
}

@property (nonatomic, copy, readwrite) NSArray *titles;
@property (nonatomic, copy, readwrite) NSArray *images;
@property (nonatomic, assign) NSInteger itemCount;

@end

@interface PSMenuCell : UICollectionViewCell {
	UILabel *_textLabel;
	UIImageView *_imageView;
	UIView *_separateLine;
}
@property (nonatomic, strong) PSPopupMenuConfig *config;

+ (instancetype)collectionCellWithCollectioView:(UICollectionView *)collectionView forIndexPath:(NSIndexPath *)indexPath;
- (void)setTitle:(NSString *)title image:(UIImage *)image isLast:(BOOL)isLast;

@end

@implementation PSPopupMenu

+ (instancetype)new {
	return [[PSPopupMenu alloc] init];
}

- (instancetype)init {
	if (self = [super init]) {
		self.config = [PSPopupMenuConfig defaultConfig];
	}
	return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
	
	self = [super initWithFrame:frame];
	if (self) {
		self.config = [PSPopupMenuConfig defaultConfig];
	}
	return self;
}

- (void)show {
	UIWindow *window = [UIApplication sharedApplication].keyWindow;
	[self showInView:window];
}

- (void)showInView:(UIView *)view {
	
	if (_isShowing) return;
	_isShowing = YES;
	
	[self creatSubView];
	
	self.frame = view.bounds;
	self.alpha = 0.0;
	[view addSubview:self];
	
	[UIView animateWithDuration:0.25f animations:^{
		self.alpha = 1.0;
		self->_groundLayer.backgroundColor = self.config.maskBackgroundColor.CGColor;
	} completion:^(BOOL finished) {
	}];
}

- (void)dismiss {
	
	[UIView animateWithDuration:0.1 animations:^{
		self.alpha = 0.0;
	} completion:^(BOOL finished) {
		[self removeFromSuperview];
	}];
}

- (void)creatSubView {
	
	CALayer *layer = [CALayer layer];
	[self.layer addSublayer:layer];
	_groundLayer = layer;
	
	PSMaskView *maskView = [[PSMaskView alloc] initWithFrame:self.frame];
	maskView.backgroundColor = [UIColor clearColor];
	maskView.config = self.config;
	maskView.arrowDirection = self.config.arrowDirection;
	if (self.config.displayShadow) {
		maskView.layer.shadowColor = [UIColor blackColor].CGColor;
		maskView.layer.shadowOffset = CGSizeMake(0, 1);
		maskView.layer.shadowOpacity = 0.2;
		maskView.layer.shadowRadius = 4;
	}
	[self addSubview:maskView];
	_maskView = maskView;
	
	UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
	layout.minimumLineSpacing = 0;
	layout.minimumInteritemSpacing = 0;
	layout.sectionInset = UIEdgeInsetsZero;
	layout.scrollDirection = UICollectionViewScrollDirectionVertical;
	UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
	collectionView.backgroundColor =  [UIColor clearColor];
	collectionView.delegate = self;
	collectionView.dataSource = self;
	collectionView.showsHorizontalScrollIndicator = NO;

	collectionView.layer.cornerRadius = self.config.menuRadius;
	collectionView.layer.masksToBounds = YES;
	[maskView addSubview:collectionView];
	_collectionView = collectionView;
}

- (void)layoutSubviews {
	
	[super layoutSubviews];
	
	CGFloat y = self.config.arrowInternalHeight;
	if (self.config.arrowDirection == PSArrowDirectionNone) { y = 0; }
	_collectionView.frame = (CGRect) {
		.origin.y = y,
		.size = { _maskView.frame.size.width,
			_maskView.frame.size.height - y}
	};
	_groundLayer.frame = CGRectMake(0, 0, self.frame.size.width,  self.frame.size.height);
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	[self dismiss];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
	
	NSInteger itemCount = 0;
	if (self.dataSource && [self.dataSource respondsToSelector:@selector(numberOfRowsForPopupMenu:)]) {
		itemCount = [self.dataSource numberOfRowsForPopupMenu:self];
	}
	self.itemCount = itemCount;
	return itemCount;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
				  cellForItemAtIndexPath:(NSIndexPath *)indexPath {
	
	PSMenuCell *cell = (PSMenuCell *)[self contentCellWithCollectionView:collectionView forIndexPath:indexPath];
	
	if ([cell isKindOfClass:[PSMenuCell class]]) {
		cell.config = self.config;
		NSString *title = (indexPath.item <= self.titles.count-1) ? self.titles[indexPath.item] : nil;
		UIImage *image = (indexPath.item <= self.images.count-1) ? self.images[indexPath.item] : nil;
		[cell setTitle:title image:image isLast:(indexPath.item == self.itemCount -1)];
	}
	return cell;
}

#pragma mark - UICollectionViewDelegate

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
	
	CGFloat itemHeight = CGRectGetHeight(collectionView.frame) / self.itemCount;
	return CGSizeMake(CGRectGetWidth(collectionView.frame), floorf(itemHeight));
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
	
	[self dismiss];
	if (self.delegate && [self.delegate respondsToSelector:@selector(popupMenu:didSelectItemAtIndex:)]) {
		[self.delegate popupMenu:self didSelectItemAtIndex:indexPath.item];
	}
}

- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}

#pragma mark - DataSource

- (UICollectionViewCell *)contentCellWithCollectionView:(UICollectionView *)collectionView forIndexPath:(NSIndexPath *)indexPath {
	
	UICollectionViewCell *contenView = nil;
	
	if (self.dataSource && [self.dataSource respondsToSelector:@selector(contentCellWithCollectionView:cellForRowAtIndex:)]) {
		contenView = [self.dataSource contentCellWithCollectionView:collectionView cellForRowAtIndex:indexPath.item];
	} else {
		contenView = [PSMenuCell collectionCellWithCollectioView:collectionView forIndexPath:indexPath];
		contenView.backgroundColor = self.config.menuBackgroundColor;
	}
	return contenView;
}

#pragma mark - Lazy Load

- (NSArray *)titles {
	if (!_titles) {
		if (self.dataSource && [self.dataSource respondsToSelector:@selector(titlesForPopupMenu:)]) {
			_titles  = [self.dataSource titlesForPopupMenu:self];
		}
	}
	return _titles;
}

- (NSArray *)images {
	if (!_images) {
		if (self.dataSource && [self.dataSource respondsToSelector:@selector(imagesForPopupMenu:)]) {
			_images = [self.dataSource imagesForPopupMenu:self];
		}
	}
	return _images;
}

@end


@implementation PSMaskView

- (void)drawRect:(CGRect)rect {
	
	CGFloat x = 0;
	CGFloat y = 0;
	CGFloat width = rect.size.width;
	CGFloat height = rect.size.height;
	
	if (self.arrowDirection == PSArrowDirectionNone) {
		
	} else if (self.arrowDirection == PSArrowDirectionLeft) {
		x = self.config.arrowLeftMargin;
		y = self.config.arrowInternalHeight;
	} else if (self.arrowDirection == PSArrowDirectionRight) {
		x = rect.size.width - (self.config.arrowRightMargin + 2*self.config.arrowInternalCenterSpacing);
		y = self.config.arrowInternalHeight;
	} else if (self.arrowDirection == PSArrowDirectionMiddle) {
		x = rect.size.width/2 - self.config.arrowInternalCenterSpacing;
		y = self.config.arrowInternalHeight;
	}
	
	CGContextRef context = UIGraphicsGetCurrentContext();
	
	/*画三角形*/
	//只要三个点就行跟画一条线方式一样，把三点连接起来
	CGPoint sPoints[3];//坐标点
	sPoints[0] =CGPointMake(x, y);//坐标1
	sPoints[1] =CGPointMake(x + 2*self.config.arrowInternalCenterSpacing, y);//坐标2
	sPoints[2] =CGPointMake(x + self.config.arrowInternalCenterSpacing, y - self.config.arrowInternalHeight);//坐标3
	CGContextAddLines(context, sPoints, 3);//添加线
	CGContextClosePath(context);//封起来
	CGContextSetFillColorWithColor(context, self.config.menuBackgroundColor.CGColor);//填充颜色
	CGContextSetLineWidth(context, 0); // 线宽度
	CGContextDrawPath(context, kCGPathFillStroke); //根据坐标绘制路径
	
	/*画矩形*/
	CGFloat radius = self.config.menuRadius;
	// 移动到初始点
	CGContextMoveToPoint(context, x + radius, y);
	
	// 绘制第1条线和第1个1/4圆弧
	CGContextAddLineToPoint(context, x + width - radius, y);
	CGContextAddArc(context, width - radius, y + radius, radius, -0.5 * M_PI, 0.0, 0);
	
	// 绘制第2条线和第2个1/4圆弧
	CGContextAddLineToPoint(context, x + width, y + height - radius);
	CGContextAddArc(context, width - radius, height - radius, radius, 0.0, 0.5 * M_PI, 0);
	
	// 绘制第3条线和第3个1/4圆弧
	CGContextAddLineToPoint(context, radius, y + height);
	CGContextAddArc(context, radius, height - radius, radius, 0.5 * M_PI, M_PI, 0);
	
	// 绘制第4条线和第4个1/4圆弧
	CGContextAddLineToPoint(context, 0, y + radius);
	CGContextAddArc(context, radius, y + radius, radius, M_PI, 1.5 * M_PI, 0);
	
	// 闭合路径
	CGContextClosePath(context);
	// 填充半透明黑色
	CGContextSetFillColorWithColor(context, self.config.menuBackgroundColor.CGColor);//填充颜色
	CGContextDrawPath(context, kCGPathFill);
}

- (void)setArrowDirection:(PSArrowDirection)arrowDirection {
	_arrowDirection = arrowDirection;
	[self setNeedsDisplay];
}

@end

@implementation PSMenuCell

- (void)setConfig:(PSPopupMenuConfig *)config {
	_config = config;
	[_textLabel setTextColor:self.config.textLabelColor];
	[_textLabel setFont:self.config.textLabelFont];
	_imageView.contentMode = self.config.imageViewContentMode;
	_separateLine.backgroundColor = self.config.separatorColor;
}

- (void)setTitle:(NSString *)title image:(UIImage *)image isLast:(BOOL)isLast {
	
	if (title && image) {
		_textLabel.text = title;
		_imageView.image = image;
		[_textLabel sizeToFit];
		
		CGFloat imageViewX = self.config.imageLeftMargin;
		CGFloat imageViewY = (CGRectGetHeight(self.contentView.frame) - image.size.height) *0.5;
		CGFloat imageViewW = image.size.width;
		CGFloat imageViewH = image.size.height;
		_imageView.frame = (CGRect){imageViewX,imageViewY,imageViewW,imageViewH};
		
		CGFloat textLabelX = CGRectGetMaxX(_imageView.frame) +self.config.textLabelLeftMargin;
		CGFloat textLabelY = (CGRectGetHeight(self.contentView.frame) - _textLabel.ps_size.height) *0.5;
		CGFloat textLabelMaxW = CGRectGetWidth(self.contentView.frame) - textLabelX -self.config.textLabelRightMargin;
		CGFloat textLabelW = _textLabel.ps_size.width > textLabelMaxW ? textLabelMaxW:_textLabel.ps_size.width;
		CGFloat textLabelH = _textLabel.ps_size.height;
		_textLabel.frame = (CGRect){textLabelX,textLabelY,textLabelW,textLabelH};
	}else if(title) {
		_textLabel.text = [NSString stringWithFormat:@"%@", title];
		_textLabel.frame = (CGRect){0,0,CGRectGetWidth(self.contentView.frame),CGRectGetHeight(self.contentView.frame)};
	}else if (image) {
		_imageView.image = image;
		_imageView.frame = (CGRect){(CGRectGetWidth(self.contentView.frame) -image.size.width) *0.5,
			(CGRectGetHeight(self.contentView.frame) -image.size.height) *0.5,
			image.size};
	}
	_separateLine.hidden = isLast || !self.config.displaySeparat;
}

+ (instancetype)collectionCellWithCollectioView:(UICollectionView *)collectionView forIndexPath:(NSIndexPath *)indexPath {
	
	[collectionView registerClass:[PSMenuCell class] forCellWithReuseIdentifier:kCellReuseIdentifier];
	PSMenuCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCellReuseIdentifier forIndexPath:indexPath];
	return cell;
}

- (instancetype)initWithFrame:(CGRect)frame {
	self = [super initWithFrame:frame];
	if (self) {
		[self initViews];
	}
	return self;
}

- (void)initViews {

	_textLabel = [[UILabel alloc] init];;
	[_textLabel setTextAlignment:NSTextAlignmentCenter];
	[_textLabel setLineBreakMode:NSLineBreakByTruncatingTail];
	[self.contentView addSubview:_textLabel];
	
	_imageView = [[UIImageView alloc] init];
	[self.contentView addSubview:_imageView];
	
	_separateLine = [[UIView alloc] init];
	[self.contentView addSubview:_separateLine];
}

- (void)layoutSubviews {
	[super layoutSubviews];
	_separateLine.frame = CGRectMake(1,
									 CGRectGetHeight(self.contentView.frame) -self.config.separatorHeight,
									 CGRectGetWidth(self.contentView.frame) -2,
									 self.config.separatorHeight);
}

@end

@implementation PSPopupMenuConfig

+ (instancetype)defaultConfig {
	
	PSPopupMenuConfig *config = [[PSPopupMenuConfig alloc] init];
	config.arrowDirection = PSArrowDirectionRight;
	config.arrowLeftMargin = 30.0f;
	config.arrowRightMargin = 30.0f;
	config.arrowInternalHeight = 8.0f;
	config.arrowInternalCenterSpacing = 8.0f;
	config.menuRadius = 4.0f;
	config.maskBackgroundColor = [UIColor clearColor];
	config.menuBackgroundColor = [UIColor whiteColor];
	config.textLabelColor = kColorFromRGBA(0x333333, 1.0);
	config.textLabelFont = [UIFont systemFontOfSize:12.0f];
	config.textLabelLeftMargin = 24.0f;
	config.textLabelRightMargin = 22.0f;
	config.imageViewContentMode = UIViewContentModeScaleAspectFill;
	config.imageLeftMargin = 22.0f;
	config.separatorHeight = 0.5f;
	config.separatorColor = [UIColor lightGrayColor];
	config.displaySeparat = YES;
	config.displayShadow = YES;
	
	return config;
}

@end
