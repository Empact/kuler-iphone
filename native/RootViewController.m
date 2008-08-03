//
//  RootViewController.m
//  kuler-iphone
//
//  Created by Benjamin Ortuzar on 02/08/2008.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import "RootViewController.h"
#import "kuler_iphoneAppDelegate.h"
#import "TableViewCell.h"


@implementation RootViewController

- (id)initWithStyle:(UITableViewStyle)style {
	if (self = [super initWithStyle:style]) {
		
		NSLog(@"initializing RootViewController");
		self.title = @"Themes";
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        self.tableView.rowHeight = 48.0;
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        self.tableView.sectionHeaderHeight = 0;
	}
	return self;
}





- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	kuler_iphoneAppDelegate *appDelegate = (kuler_iphoneAppDelegate *)[[UIApplication sharedApplication] delegate];
    NSUInteger count = [appDelegate countOfList];
	// If no themes were parsed because the RSS feed was not available,
    // return a count of 1 so that the data source method tableView:cellForRowAtIndexPath: is called.
    // It also calls -[kuler_iphoneAppDelegate isDataSourceAvailable] to determine what to show in the table.
    if ([appDelegate isDataSourceAvailable] == NO) {
        return 1;
    }
    return count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
	static NSString *MyIdentifier = @"MyIdentifier";
    
  	TableViewCell *cell = (TableViewCell *)[tableView dequeueReusableCellWithIdentifier:MyIdentifier];
	if (cell == nil) {
		cell = [[[TableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:MyIdentifier] autorelease];
	}
    
    // Set up the cell.
	kuler_iphoneAppDelegate *appDelegate = (kuler_iphoneAppDelegate *)[[UIApplication sharedApplication] delegate];
    
    // If the RSS feed isn't accessible (which could happen if the network isn't available), show an informative
    // message in the first row of the table.
	if ([appDelegate isDataSourceAvailable] == NO) {
        cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:@"DefaultTableViewCell"] autorelease];
        cell.text = NSLocalizedString(@"RSS Host Not Available", @"RSS Host Not Available message");
		cell.textColor = [UIColor colorWithWhite:0.5 alpha:0.5];
		cell.accessoryType = UITableViewCellAccessoryNone;
		return cell;
	}
	
	Theme *themeForRow = [appDelegate objectInListAtIndex:indexPath.row];
    [cell setTheme:themeForRow];
	return cell;
}

/*
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
}
*/
/*
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
	
	if (editingStyle == UITableViewCellEditingStyleDelete) {
	}
	if (editingStyle == UITableViewCellEditingStyleInsert) {
	}
}
*/
/*
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/
/*
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/
/*
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/


- (void)dealloc {
	[super dealloc];
}


- (void)viewDidLoad {
	[super viewDidLoad];
}


- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
	[super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
}

- (void)viewDidDisappear:(BOOL)animated {
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
}


@end

