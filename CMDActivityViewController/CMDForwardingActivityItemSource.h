//
//  CMDForwardingActivityItemSource.h
//  CMDActivityViewController
//
//  Created by Caleb Davenport on 3/28/14.
//  Copyright (c) 2014 Caleb Davenport. All rights reserved.
//

@protocol CMDForwardingActivityItemSourceDelegate;

@interface CMDForwardingActivityItemSource : NSObject <UIActivityItemSource>

@property (nonatomic, weak) id<CMDForwardingActivityItemSourceDelegate> delegate;

@end

@protocol CMDForwardingActivityItemSourceDelegate <NSObject>
@required;

- (id)forwardingSourcePlaceholderItem:(CMDForwardingActivityItemSource *)source;
- (id)forwardingSource:(CMDForwardingActivityItemSource *)source itemForActivityType:(NSString *)type;
- (NSString *)forwardingSource:(CMDForwardingActivityItemSource *)source subjectForActivityType:(NSString *)type;
- (NSString *)forwardingSource:(CMDForwardingActivityItemSource *)source dataTypeIdentifierForActivityType:(NSString *)type;
- (UIImage *)forwardingSource:(CMDForwardingActivityItemSource *)source thumbnailImageForActivityType:(NSString *)type suggestedSize:(CGSize)size;

@end
