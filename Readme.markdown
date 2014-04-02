# CMDActivityViewController

Nobody likes `UIActivityViewController`. I don't like how hard it is to customize what you are sharing based on the selected activity. I usually end up making a mess of objects that conform to `UIActivityItemSource` that return different data for different activity types. Well no more.

Let's say you want to share text and a link to twitter, but only send the link to the pasteboard. Easy.

```objc
#pragma mark - Actions

- (void)share {
    CMDActivityViewController *controller = [[CMDActivityViewControllerDelegate alloc] initWithNumberOfItems:2 applicationActivities:nil];
    controller.delegate = self;
    [self presentViewController:controller animated:YES completion:nil];
}

#pragma mark - CMDActivityViewControllerDelegate

- (NSArray *)activityViewControllerPlaceholderItems:(CMDActivityViewController *)controller {
    return @[ @"", [NSURL URLWithString:@"http://apple.com"] ];
}

- (NSArray *)activityViewController:(CMDActivityViewController *)controller itemsForActivityType:(NSString *)activityType {
    if ([activityType isEqualToString:UIActivityTypeCopyToPasteboard] ||
        [activityType isEqualToString:UIActivityTypeAirDrop] ||
        [activityType isEqualToString:UIActivityTypeAddToReadingList]) {
        return @[ [NSNull null], self.shareURL ];
    }

    else {
        return @[ self.shareText, self.shareURL ];
    }
}
```

Ok, that isn't so hard anyway though. AirDrop and Reading List are pretty smart and will take just the URL. What about sharing an image, link, for different activities? No problem.

```objc
#pragma mark - Actions

- (void)share {
    CMDActivityViewController *controller = [[CMDActivityViewControllerDelegate alloc] initWithNumberOfItems:2 applicationActivities:nil];
    controller.delegate = self;
    [self presentViewController:controller animated:YES completion:nil];
}

#pragma mark - CMDActivityViewControllerDelegate

- (NSArray *)activityViewControllerPlaceholderItems:(CMDActivityViewController *)controller {
    return @[ @"", [NSURL URLWithString:@"http://apple.com"], [UIImage new] ];
}

- (NSArray *)activityViewController:(CMDActivityViewController *)controller itemsForActivityType:(NSString *)activityType {

    // Share the text and link only to Twitter
    if ([activityType isEqualToString:UIActivityTypePostToTwitter]) {
        return @[ self.shareText, self.shareURL, [NSNull null] ];
    }

    // Save the image to the photo library
    if ([activityType isEqualToString:UIActivityTypeSaveToCameraRoll]) {
        return @[ [NSNull null], [NSNull null], self.shareImage ];
    }

    // Send the text and a picture with Messages
    if ([activityType isEqualToString:UIActivityTypeMessage]) {
        return @[ self.shareText, [NSNull null], self.shareImage ];
    }

    // All others
    return @[ self.shareText, self.shareURL, self.shareImage ];
}
```

Or maybe you would like to do HTML text to Mail and plain text and a link to Twitter. You get the idea :)

## Thanks

Special thanks to Drew Wilson for letting me release this as I work on his upcomming app [Filtron](https://filtron.co).
