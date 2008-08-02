//
//  Theme.h
//  Kuler Experiment
//
//  Created by Brian Rice on 8/2/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface Theme : NSObject {
}

@property (nonatomic, retain) NSString *themeID;
@property (nonatomic, retain) NSString *swatches;
@property (nonatomic, retain) NSString *author;
@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) NSString *link;
@property (nonatomic, retain) NSString *downloadCount;
@property (nonatomic, retain) NSString *created;
@property (nonatomic, readonly) NSString  *edited;

@end
