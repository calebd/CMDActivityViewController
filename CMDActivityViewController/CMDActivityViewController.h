//
//  CMDActivityViewController.h
//  CMDActivityViewController
//
//  Created by Caleb Davenport on 3/28/14.
//  Copyright (c) 2014 Caleb Davenport. All rights reserved.
//

@protocol CMDActivityViewControllerDelegate;

@interface CMDActivityViewController : UIActivityViewController

@property (nonatomic, weak) id<CMDActivityViewControllerDelegate> delegate;

- (instancetype)initWithNumberOfItems:(NSUInteger)numberOfItems applicationActivities:(NSArray *)applicationActivities;

@end

@protocol CMDActivityViewControllerDelegate <NSObject>

@required

- (NSArray *)activityViewControllerPlaceholderItems:(CMDActivityViewController *)controller;
- (NSArray *)activityViewController:(CMDActivityViewController *)controller itemsForActivityType:(NSString *)activityType;

@optional

- (NSArray *)activityViewController:(CMDActivityViewController *)controller dataTypeIdentifiersForActivityType:(NSString *)activityType;
- (NSString *)activityViewController:(CMDActivityViewController *)controller subjectForActivityType:(NSString *)activityType;
- (UIImage *)activityViewController:(CMDActivityViewController *)controller thumbnailImageForActivityType:(NSString *)activityType suggestedSize:(CGSize)size;

@end
