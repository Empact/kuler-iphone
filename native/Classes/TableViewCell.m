#import "TableViewCell.h"


static UIImage *themeImage = nil;

@interface TableViewCell()
- (UILabel *)newLabelWithPrimaryColor:(UIColor *)primaryColor selectedColor:(UIColor *)selectedColor fontSize:(CGFloat)fontSize bold:(BOOL)bold;
@end

@implementation TableViewCell

@synthesize themeNameLabel = _themeNameLabel;
@synthesize themeImageView = _themeImageView;

+ (void)initialize
{
   //deleted
	themeImage = [[UIImage imageNamed:@"theme_sample.png"] retain];
}

- (id)initWithFrame:(CGRect)frame reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithFrame:frame reuseIdentifier:reuseIdentifier]) {
        UIView *myContentView = self.contentView;
        
        // Add an image view to display a waveform image of the earthquake.
		self.themeImageView = [[UIImageView alloc] initWithImage:themeImage];
		[myContentView addSubview:self.themeImageView];
        [self.themeImageView release];
        
        // A label that displays the name of the theme.
        self.themeNameLabel = [self newLabelWithPrimaryColor:[UIColor blackColor] selectedColor:[UIColor whiteColor] fontSize:14.0 bold:YES]; 
		self.themeNameLabel.textAlignment = UITextAlignmentLeft; // default
		[myContentView addSubview:self.themeNameLabel];
		[self.themeNameLabel release];
        
        
        // Position the magnitudeImageView above all of the other views so
        // it's not obscured. It's a transparent image, so any views
        // that overlap it will still be visible.
        [myContentView bringSubviewToFront:self.themeImageView];
    }
    return self;
}

- (Theme *)theme
{
    return _theme;
}

// Rather than using one of the standard UITableViewCell content properties like 'text',
// we're using a custom property called 'theme' to populate the table cell. Whenever the
// value of that property changes, we need to call [self setNeedsDisplay] to force the
// cell to be redrawn.
- (void)setTheme:(Theme *)newTheme
{
    [newTheme retain];
    [_theme release];
    _theme = newTheme;
    
    self.themeNameLabel.text = newTheme.title;
    self.themeImageView.image = themeImage;
    
    [self setNeedsDisplay];
}



- (void)layoutSubviews {
    
#define LEFT_COLUMN_OFFSET 10
#define LEFT_COLUMN_WIDTH 200
	
#define MIDDLE_COLUMN_OFFSET 180
#define MIDDLE_COLUMN_WIDTH 100
	
#define UPPER_ROW_TOP 4
#define LOWER_ROW_TOP 28
    
    [super layoutSubviews];
    CGRect contentRect = self.contentView.bounds;
	
	// In this example we will never be editing, but this illustrates the appropriate pattern
    if (!self.editing) {
		
        CGFloat boundsX = contentRect.origin.x;
		CGRect frame;
        
        // Place the location label.
		frame = CGRectMake(boundsX + LEFT_COLUMN_OFFSET, UPPER_ROW_TOP, LEFT_COLUMN_WIDTH, 20);
		self.themeNameLabel.frame = frame;
        
        // Place the waveform image.
        UIImageView *imageView = self.themeImageView;
        frame = [imageView frame];
		frame.origin.x = boundsX + MIDDLE_COLUMN_OFFSET;
		frame.origin.y = 0;
 		imageView.frame = frame;
        

    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
	/*
	 Views are drawn most efficiently when they are opaque and do not have a clear background, so in newLabelForMainText: the labels are made opaque and given a white background.  To show selection properly, however, the views need to be transparent (so that the selection color shows through).  
     */
	[super setSelected:selected animated:animated];
	
	UIColor *backgroundColor = nil;
	if (selected) {
	    backgroundColor = [UIColor clearColor];
	} else {
		backgroundColor = [UIColor whiteColor];
	}
    
	self.themeNameLabel.backgroundColor = backgroundColor;
	self.themeNameLabel.highlighted = selected;
	self.themeNameLabel.opaque = !selected;
	
}

- (UILabel *)newLabelWithPrimaryColor:(UIColor *)primaryColor selectedColor:(UIColor *)selectedColor fontSize:(CGFloat)fontSize bold:(BOOL)bold
{
	/*
	 Create and configure a label.
	 */
	
    UIFont *font;
    if (bold) {
        font = [UIFont boldSystemFontOfSize:fontSize];
    } else {
        font = [UIFont systemFontOfSize:fontSize];
    }
    
    /*
	 Views are drawn most efficiently when they are opaque and do not have a clear background, so set these defaults.  To show selection properly, however, the views need to be transparent (so that the selection color shows through).  This is handled in setSelected:animated:.
	 */
	UILabel *newLabel = [[UILabel alloc] initWithFrame:CGRectZero];
	newLabel.backgroundColor = [UIColor whiteColor];
	newLabel.opaque = YES;
	newLabel.textColor = primaryColor;
	newLabel.highlightedTextColor = selectedColor;
	newLabel.font = font;
	
	return newLabel;
}

@end
