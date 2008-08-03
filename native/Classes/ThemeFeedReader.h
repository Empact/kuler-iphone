//
//  ThemeFeedReader.h
//  Kuler Experiment
//
//  Created by Brian Rice on 8/2/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Theme.h"
#import "Swatch.h"

@interface ThemeFeedReader : NSObject {

@private
    Theme *_currentObject;
	NSMutableArray *_currentSwatch;
    NSMutableString *_contentOfCurrentProperty;
    NSArray *_kulerElementNames;
}

@property (nonatomic, retain) Theme *currentObject;
@property (nonatomic, retain) NSMutableArray *currentSwatch;
@property (nonatomic, retain) NSMutableString *contentOfCurrentProperty;
@property (nonatomic, retain) NSArray *kulerElementNames;

- (void)parseXMLFileAtURL:(NSURL *)URL parseError:(NSError **)error;

@end
