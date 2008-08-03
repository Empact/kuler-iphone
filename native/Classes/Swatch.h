//
//  Swatch.h
//  kuler-iphone
//
//  Created by Jesse Clark on 8/3/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

@interface Swatch : NSObject {
	int hexColor;
	int displaySequence;
	NSString *colorMode;
	float channel1;
	float channel2;
	float channel3;
	float channel4;
}

@property (nonatomic) int hexColor;
@property (nonatomic) int displaySequence;
@property (nonatomic, copy) NSString *colorMode;
@property (nonatomic) float channel1;
@property (nonatomic) float channel2;
@property (nonatomic) float channel3;
@property (nonatomic) float channel4;

@end
