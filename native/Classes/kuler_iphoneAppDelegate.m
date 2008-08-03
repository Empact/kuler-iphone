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
#import <Foundation/Foundation.h>

@implementation kuler_iphoneAppDelegate

@synthesize window;

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
    [streamingParser release];        
    [pool release];
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

- (void)applicationDidFinishLaunching:(UIApplication *)application {	
	// Override point for customization after app launch
	if ([self isDataSourceAvailable] == NO) {
        return;
    };
	
    // Spawn a thread to fetch the theme data so that the UI is not blocked while the 
    // application parses the XML file.
    [NSThread detachNewThreadSelector:@selector(getThemeData) toTarget:self withObject:nil];
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
