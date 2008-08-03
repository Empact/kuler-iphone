//
//  KulerGetFeed.h
//  kuler-iphone
//
//  Created by Brian Rice on 8/2/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

@interface KulerGetFeed : NSObject {

@private
	NSString *_listType;
	NSUInteger _startIndex;
	NSUInteger _itemsPerPage;
	NSString *_timeSpan;
}

@property (nonatomic, retain) NSString *listType;
@property (nonatomic) NSUInteger startIndex;
@property (nonatomic) NSUInteger itemsPerPage;
@property (nonatomic, retain) NSString *timeSpan;

@end
