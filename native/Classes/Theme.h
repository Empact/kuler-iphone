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
    NSString *_author;
    NSString *_title;
    NSString *_link;
    NSString *_downloadCount;
    NSString *_created;
    NSString *_edited;
}

@property (nonatomic, retain) NSString *themeID;
@property (nonatomic, retain) NSMutableArray *swatches;
@property (nonatomic, retain) NSString *author;
@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) NSString *link;
@property (nonatomic, retain) NSString *downloadCount;
@property (nonatomic, retain) NSString *created;
@property (nonatomic, readonly) NSString  *edited;

@end
