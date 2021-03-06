//
//  Theme.h
//  Kuler Experiment
//
//  Created by Brian Rice on 8/2/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

@interface Theme : NSObject {

@private
    NSString *_themeID;
    NSMutableArray *_swatches;
    NSString *_authorId;
    NSString *_authorLabel;
    NSString *_title;
    NSURL *_link;
    NSInteger _downloadCount;
    NSString *_created;
    NSString *_edited;
}

@property (nonatomic, retain) NSString *themeID;
@property (nonatomic, retain) NSMutableArray *swatches;
@property (nonatomic, retain) NSString *authorId;
@property (nonatomic, retain) NSString *authorLabel;
@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) NSURL *link;
@property (nonatomic) NSInteger downloadCount;
@property (nonatomic, retain) NSString *created;
@property (nonatomic, retain) NSString  *edited;

@end
