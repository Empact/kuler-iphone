//
//  kuler_iphoneAppDelegate.m
//  kuler-iphone
//
//  Created by Jesse Clark on 8/2/08.
//  Copyright __MyCompanyName__ 2008. All rights reserved.
//

#import "kuler_iphoneAppDelegate.h"
#import <SystemConfiguration/SystemConfiguration.h>
#import "Theme.h"
#import "ThemeFeedReader.h"
#import "RootViewController.h"
#import <Foundation/Foundation.h>

@implementation kuler_iphoneAppDelegate

@synthesize window;
@synthesize navigationController;
@synthesize list;

static NSString *feedURLString = @"http://kuler.adobe.com/kuler/API/rss/get.cfm?listtype=rating";

// Use the SystemConfiguration framework to determine if the host that provides
// the RSS feed is available.
- (BOOL)isDataSourceAvailable
{
    static BOOL checkNetwork = YES;
    if (checkNetwork) { // Since checking the reachability of a host can be expensive, cache the result and perform the reachability check once.
        checkNetwork = NO;
        
        Boolean success;    
        const char *host_name = "kuler.adobe.com";
		
        SCNetworkReachabilityRef reachability = SCNetworkReachabilityCreateWithName(NULL, host_name);
        SCNetworkReachabilityFlags flags;
        success = SCNetworkReachabilityGetFlags(reachability, &flags);
        _isDataSourceAvailable = success && (flags & kSCNetworkFlagsReachable) && !(flags & kSCNetworkFlagsConnectionRequired);
        CFRelease(reachability);
    }
    return _isDataSourceAvailable;
}

- (void)getThemeData
{
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    
	NSError *parseError = nil;
	
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    ThemeFeedReader *streamingParser = [[ThemeFeedReader alloc] init];
    [streamingParser parseXMLFileAtURL:[NSURL URLWithString:feedURLString] parseError:&parseError];
	// TODO: I am going to change from using the SAX style parseXMLFileAt to a DOM oriented method like xmlDoc = [[NSXMLDocument alloc] initWithContentsOfURL:furl...
	// see: http://developer.apple.com/documentation/Cocoa/Conceptual/NSXML_Concepts/Articles/CreatingXMLDoc.html#//apple_ref/doc/uid/TP40001255
	
    [streamingParser release];        
    [pool release];
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

- (void)applicationDidFinishLaunching:(UIApplication *)application {	
	
	
	self.list = [NSMutableArray array];
	
	// Create the navigation and view controllers
	RootViewController *rootViewController = [[RootViewController alloc] initWithStyle:UITableViewStylePlain];
	UINavigationController *aNavigationController = [[UINavigationController alloc] initWithRootViewController:rootViewController];
	self.navigationController = aNavigationController;
	[aNavigationController release];
	[rootViewController release];
	
	// Configure and show the window
	[window addSubview:[navigationController view]];
	
	// Override point for customization after app launch
	if ([self isDataSourceAvailable] == NO) {
        return;
    };
	
    // Spawn a thread to fetch the theme data so that the UI is not blocked while the 
    // application parses the XML file.
    [NSThread detachNewThreadSelector:@selector(getThemeData) toTarget:self withObject:nil];
}

- (void)reloadTable
{
    [[(RootViewController *)[self.navigationController topViewController] tableView] reloadData];
}

- (void)addToThemeList:(Theme *)newTheme
{
	NSLog(@"new theme: %@", newTheme);
    [self.list addObject:newTheme];
    // The XML parser calls addToThemeList: each time it creates a Theme object.
    [self reloadTable];
}

- (NSUInteger)countOfList {
	NSLog(@"list count: %d", [list count]);
	return [list count];
}

- (id)objectInListAtIndex:(NSUInteger)theIndex {
	//NSLog(@"object at index %d: %@", [list objectAtIndex:theIndex]);
	return [list objectAtIndex:theIndex];
}

- (void)getList:(id *)objsPtr range:(NSRange)range {
	[list getObjects:objsPtr range:range];
}

// Need to make this a render method on an appropriate ThemeSwatchesFullView class
- (void)drawSwatchesFullScreen:(Theme *)theme {
	NSArray* swatches = [theme swatches];
	NSEnumerator* iterator = [swatches objectEnumerator];
	id swatch;
	NSMutableArray* rectangles = [NSMutableArray arrayWithCapacity: 5];
	//FIXME hardcoding view size, need to make this a method on the right view:
	float xValue = 0.0;
	float rectHeight = 92.0;//[self bounds getHeight];
	float rectWidth = 320.0;//[self bounds getWidth];
	while (swatch = [iterator nextObject]) {
		[swatch setFill];
		//NSRect rect = NSRect{};
		NSRect origin = NSMakeRect(xValue, 0.0, rectWidth, rectHeight);
		xValue += rectHeight;
		//[rectangles addObject: origin];
	}
}

- (void)dealloc {
	[window release];
	[super dealloc];
}

@end
