
#import <UIKit/UIKit.h>
#import "Theme.h"

@interface TableViewCell : UITableViewCell {
	
@private	
	Theme *_theme;
    UILabel *_themeNameLabel;
    UIImageView *_themeImageView;
}

@property (nonatomic, retain) UILabel *themeNameLabel;
@property (nonatomic, retain) UIImageView *themeImageView;


- (Theme *)theme;
- (void)setTheme:(Theme *)newTheme;

@end
