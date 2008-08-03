//
//  kuler_iphoneAppDelegate.h
//  kuler-iphone
//
//  Created by Jesse Clark on 8/2/08.
//  Copyright __MyCompanyName__ 2008. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface kuler_iphoneAppDelegate : NSObject <UIApplicationDelegate> {
	IBOutlet UIWindow *window;
	UINavigationController *navigationController;
	
	NSMutableArray *list;
    BOOL _isDataSourceAvailable;
}

@property (nonatomic, retain) NSMutableArray *list;
@property (nonatomic, retain) UIWindow *window;
@property (nonatomic, retain) UINavigationController *navigationController;


- (BOOL)isDataSourceAvailable;
- (NSUInteger)countOfList;
- (id)objectInListAtIndex:(NSUInteger)theIndex;
- (void)getList:(id *)objsPtr range:(NSRange)range;

@end
