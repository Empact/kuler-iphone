//
//  ThemeFeedReader.h
//  Kuler Experiment
//
//  Created by Brian Rice on 8/2/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ThemeFeedReader : NSObject {
	
@private        
    Theme *_currentThemeObject;
    NSMutableString *_contentOfCurrentThemeProperty;
}

@property (nonatomic, retain) Theme *currentThemeObject;
@property (nonatomic, retain) NSMutableString *contentOfCurrentThemeProperty;

- (void)parseXMLFileAtURL:(NSURL *)URL parseError:(NSError **)error;

@end
