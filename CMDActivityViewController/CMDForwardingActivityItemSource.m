//
//  CMDForwardingActivityItemSource.h
//  CMDActivityViewController
//
//  Created by Caleb Davenport on 3/28/14.
//  Copyright (c) 2014 Caleb Davenport. All rights reserved.
//

#import "CMDForwardingActivityItemSource.h"

@implementation CMDForwardingActivityItemSource

#pragma mark - UIActivityItemSource

- (id)activityViewControllerPlaceholderItem:(UIActivityViewController *)controller {
    return [self.delegate forwardingSourcePlaceholderItem:self];
}


- (id)activityViewController:(UIActivityViewController *)controller itemForActivityType:(NSString *)type {
    return [self.delegate forwardingSource:self itemForActivityType:type];
}


- (NSString *)activityViewController:(UIActivityViewController *)controller subjectForActivityType:(NSString *)type {
    return [self.delegate forwardingSource:self subjectForActivityType:type];
}


- (NSString *)activityViewController:(UIActivityViewController *)controller dataTypeIdentifierForActivityType:(NSString *)type {
    return [self.delegate forwardingSource:self dataTypeIdentifierForActivityType:type];
}


- (UIImage *)activityViewController:(UIActivityViewController *)controller thumbnailImageForActivityType:(NSString *)type suggestedSize:(CGSize)size {
    return [self.delegate forwardingSource:self thumbnailImageForActivityType:type suggestedSize:size];
}

@end
