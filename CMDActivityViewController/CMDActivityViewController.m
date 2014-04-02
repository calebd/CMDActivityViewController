//
//  CMDActivityViewController.m
//  CMDActivityViewController
//
//  Created by Caleb Davenport on 3/28/14.
//  Copyright (c) 2014 Caleb Davenport. All rights reserved.
//

#import "CMDActivityViewController.h"
#import "CMDForwardingActivityItemSource.h"

@interface CMDActivityViewController () <CMDForwardingActivityItemSourceDelegate>

@property (nonatomic, copy) NSArray *forwardingItems;
@property (nonatomic, readonly) NSMutableDictionary *items;
@property (nonatomic, readonly) NSMutableDictionary *dataTypes;
@property (nonatomic, readonly) NSArray *placeholderItems;
@property (nonatomic, readonly) NSUInteger numberOfItems;

@end

@implementation CMDActivityViewController

@synthesize items = _items;
@synthesize dataTypes = _dataTypes;
@synthesize placeholderItems = _placeholderItems;

#pragma mark - Public

- (instancetype)initWithNumberOfItems:(NSUInteger)numberOfItems applicationActivities:(NSArray *)applicationActivities {
    
    // Build items
    NSMutableArray *forwardingItems = [[NSMutableArray alloc] initWithCapacity:numberOfItems];
    for (NSUInteger i = 0; i < numberOfItems; i++) {
        CMDForwardingActivityItemSource *source = [CMDForwardingActivityItemSource new];
        source.delegate = self;
        [forwardingItems addObject:source];
    }
    
    // Initialize self
    if ((self = [super initWithActivityItems:forwardingItems applicationActivities:applicationActivities])) {
        self.forwardingItems = forwardingItems;
    }
    
    // Return
    return self;
}


#pragma mark - Private

- (NSArray *)itemsForActivityType:(NSString *)type {
    if (!self.items[type]) {
        NSArray *items = [[self.delegate activityViewController:self itemsForActivityType:type] copy];
        NSParameterAssert([items count] == self.numberOfItems);
        self.items[type] = items;
    }
    return self.items[type];
}


- (NSArray *)dataTypesForActivityType:(NSString *)type {
    if (!self.dataTypes[type]) {
        NSArray *dataTypes = [[self.delegate activityViewController:self dataTypeIdentifiersForActivityType:type] copy];
        NSParameterAssert([dataTypes count] == self.numberOfItems);
        self.dataTypes[type] = dataTypes;
    }
    return self.dataTypes[type];
}


- (NSUInteger)indexOfFirstNonNullItemForActivityType:(NSString *)type {
    NSArray *items = [self itemsForActivityType:type];
    NSUInteger numberOfItems = [items count];
    for (NSUInteger i = 0; i < numberOfItems; i++) {
        id item = items[i];
        if (![item isKindOfClass:[NSNull class]]) {
            return i;
        }
    }
    return NSNotFound;
}


#pragma mark - Accessors

- (NSMutableDictionary *)items {
    if (!_items) {
        _items = [NSMutableDictionary new];
    }
    return _items;
}


- (NSMutableDictionary *)dataTypes {
    if (!_dataTypes) {
        _dataTypes = [NSMutableDictionary new];
    }
    return _dataTypes;
}


- (NSArray *)placeholderItems {
    if (!_placeholderItems) {
        _placeholderItems = [[self.delegate activityViewControllerPlaceholderItems:self] copy];
    }
    return _placeholderItems;
}


- (NSUInteger)numberOfItems {
    return [self.forwardingItems count];
}


#pragma mark - CMDForwardingActivityItemSourceDelegate

- (id)forwardingSourcePlaceholderItem:(CMDForwardingActivityItemSource *)source {
    NSUInteger index = [self.forwardingItems indexOfObject:source];
    id item = self.placeholderItems[index];
    
    if ([item isKindOfClass:[NSNull class]]) {
        return nil;
    }
    
    return item;
}


- (id)forwardingSource:(CMDForwardingActivityItemSource *)source itemForActivityType:(NSString *)type {
    NSUInteger index = [self.forwardingItems indexOfObject:source];
    NSArray *items = [self itemsForActivityType:type];
    id item = items[index];
    
    if ([item isKindOfClass:[NSNull class]]) {
        return nil;
    }
    
    return item;
}


- (NSString *)forwardingSource:(CMDForwardingActivityItemSource *)source subjectForActivityType:(NSString *)type {
    if (![self.delegate respondsToSelector:@selector(activityViewController:subjectForActivityType:)]) {
        return nil;
    }
    
    NSUInteger sourceIndex = [self.forwardingItems indexOfObject:source];
    NSUInteger itemIndex = [self indexOfFirstNonNullItemForActivityType:type];
    
    if (sourceIndex == itemIndex) {
        return [self.delegate activityViewController:self subjectForActivityType:type];
    }
    
    return nil;
}


- (NSString *)forwardingSource:(CMDForwardingActivityItemSource *)source dataTypeIdentifierForActivityType:(NSString *)type {
    NSUInteger index = [self.forwardingItems indexOfObject:source];
    NSArray *items = [self dataTypesForActivityType:type];
    id item = items[index];
    
    if ([item isKindOfClass:[NSNull class]]) {
        return nil;
    }
    
    return item;
}


- (UIImage *)forwardingSource:(CMDForwardingActivityItemSource *)source thumbnailImageForActivityType:(NSString *)type suggestedSize:(CGSize)size {
    if (![self.delegate respondsToSelector:@selector(activityViewController:thumbnailImageForActivityType:suggestedSize:)]) {
        return nil;
    }
    
    NSUInteger sourceIndex = [self.forwardingItems indexOfObject:source];
    NSUInteger itemIndex = [self indexOfFirstNonNullItemForActivityType:type];
    
    if (sourceIndex == itemIndex) {
        return [self.delegate activityViewController:self thumbnailImageForActivityType:type suggestedSize:size];
    }
    
    return nil;
}

@end
