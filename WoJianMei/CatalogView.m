//
//  CatalogView.m
//  MBook
//
//  Created by  on 12-7-9.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "CatalogView.h"
#import "Catalog.h"

@implementation CatalogView
@synthesize catalogList = _catalogList;
@synthesize catalogViewDelegate = _catalogViewDelegate;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.delegate = self;
        self.dataSource = self;
    }
    return self;
}
- (void)dealloc
{
    [_catalogList release];
    [super dealloc];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_catalogList count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"目录";
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *indetifier = @"CatalogCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:indetifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:indetifier] autorelease];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    Catalog *catalog = [_catalogList objectAtIndex:indexPath.row];
    [cell.textLabel setText:catalog.chapter];
    [cell.textLabel setFont:[UIFont boldSystemFontOfSize:15]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Catalog *catalog = [_catalogList objectAtIndex:indexPath.row];
//    NSLog(@"index = %d, chapter = %@",catalog.index,catalog.chapter);
    if (_catalogViewDelegate && [_catalogViewDelegate respondsToSelector:@selector(catalogView:didSelectCatalog:)]) {
        [_catalogViewDelegate catalogView:self didSelectCatalog:catalog];
    }
}


@end
