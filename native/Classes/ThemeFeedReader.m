//
//  ThemeFeedReader.m
//  Kuler Experiment
//
//  Created by Brian Rice on 8/2/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import "ThemeFeedReader.h"


@implementation ThemeFeedReader

static NSUInteger parsedThemesCounter;

@synthesize currentThemeObject = _currentThemeObject;
@synthesize contentOfCurrentThemeProperty = _contentOfCurrentThemeProperty;

// Limit the number of parsed Themes to 50. Otherwise the application runs very slowly on the device.
#define MAX_THEMES 50

- (void)parserDidStartDocument:(NSXMLParser *)parser
{
    parsedThemesCounter = 0;
}

- (void)parseXMLFileAtURL:(NSURL *)URL parseError:(NSError **)error
{	
    NSXMLParser *parser = [[NSXMLParser alloc] initWithContentsOfURL:URL];
    // Set self as the delegate of the parser so that it will receive the parser delegate methods callbacks.
    [parser setDelegate:self];
    // Depending on the XML document you're parsing, you may want to enable these features of NSXMLParser.
    [parser setShouldProcessNamespaces:NO];
    [parser setShouldReportNamespacePrefixes:NO];
    [parser setShouldResolveExternalEntities:NO];
    
    [parser parse];
    
    NSError *parseError = [parser parserError];
    if (parseError && error) {
        *error = parseError;
    }
    
    [parser release];
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    if (qName) {
        elementName = qName;
    }
	
    // If the number of parsed themes is greater than MAX_ELEMENTS, abort the parse.
    // Otherwise the application runs very slowly on the device.
    if (parsedThemesCounter >= MAX_THEMES) {
        [parser abortParsing];
    }
    
    if ([elementName isEqualToString:@"entry"]) {
        
        parsedThemesCounter++;
        
        // An entry in the RSS feed represents an theme, so create an instance of it.
        self.currentThemeObject = [[Theme alloc] init];
        // Add the new Theme object to the application's array of themes.
        [(id)[[UIApplication sharedApplication] delegate] performSelectorOnMainThread:@selector(addToThemeList:) withObject:self.currentThemeObject waitUntilDone:YES];
        return;
    }
	
    if ([elementName isEqualToString:@"link"]) {
        NSString *relAtt = [attributeDict valueForKey:@"rel"];
        if ([relAtt isEqualToString:@"alternate"]) {
            NSString *link = [attributeDict valueForKey:@"href"];
            link = [NSString stringWithFormat:@"http://earthquake.usgs.gov/%@", link];
            self.currentThemeObject.link = link;
        }
    } else if ([elementName isEqualToString:@"title"]) {
        // Create a mutable string to hold the contents of the 'title' element.
        // The contents are collected in parser:foundCharacters:.
        self.contentOfCurrentThemeProperty = [NSMutableString string];
        
    } else if ([elementName isEqualToString:@"updated"]) {
        // Create a mutable string to hold the contents of the 'updated' element.
        // The contents are collected in parser:foundCharacters:.
        self.contentOfCurrentThemeProperty = [NSMutableString string];
        
    } else if ([elementName isEqualToString:@"georss:point"]) {
        // Create a mutable string to hold the contents of the 'georss:point' element.
        // The contents are collected in parser:foundCharacters:.
        self.contentOfCurrentThemeProperty = [NSMutableString string];
    } else {
        // The element isn't one that we care about, so set the property that holds the 
        // character content of the current element to nil. That way, in the parser:foundCharacters:
        // callback, the string that the parser reports will be ignored.
        self.contentOfCurrentThemeProperty = nil;
    }
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{     
    if (qName) {
        elementName = qName;
    }
    
    if ([elementName isEqualToString:@"title"]) {
        self.currentThemeObject.title = self.contentOfCurrentThemeProperty;
        
    } else if ([elementName isEqualToString:@"updated"]) {
        //self.currentThemeObject.eventDateString = self.contentOfCurrentThemeProperty;
        
    } else if ([elementName isEqualToString:@"georss:point"]) {
        //self.currentThemeObject.geoRSSPoint = self.contentOfCurrentThemeProperty;
    }
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    if (self.contentOfCurrentThemeProperty) {
        // If the current element is one whose content we care about, append 'string'
        // to the property that holds the content of the current element.
        [self.contentOfCurrentThemeProperty appendString:string];
    }
}

@end
