//
//  SceneDetailViewController.m
//  MelbourneTravel
//
//  Created by WangQionghua on 4/04/2014.
//  Copyright (c) 2014 WangQionghua. All rights reserved.
//

#import "SceneDetailViewController.h"
#import "DataParser.h"
#import <objc/message.h>
@interface SceneDetailViewController ()<UIScrollViewDelegate>
@property (strong, nonatomic) UIImage *image;
@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) IBOutlet UITextView *textView;
//@property (weak, nonatomic) IBOutlet UIButton *checkPhotoButton; //segue to browse images
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *indicator;
@end

@implementation SceneDetailViewController
#pragma mark - Properties
//properties' set and get methods.
- (void)setScene:(NSDictionary *)scene
{
    if(scene.count)
    {
        _scene = scene;
        NSURL *imageURL =[NSURL URLWithString:[scene objectForKey:SCENE_LINK]];
        [self startDownloadingImage:imageURL];
        //[self updateUI];
    }
}
- (UIImageView *)imageView
{
    if (!_imageView) _imageView = [[UIImageView alloc] init];
    return _imageView;
}
- (UITextView *)textView
{
    if (!_textView) _textView = [[UITextView alloc] init];
    return _textView;
}
- (UIImage *)image
{
    return self.imageView.image;
}
- (void)setImage:(UIImage *)image
{

    self.imageView.image = image;
    if(image)
    {
        [self.indicator stopAnimating];
        
    }
}
#pragma mark - UI
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(userFontsChanged:)
                                                 name:UIContentSizeCategoryDidChangeNotification
                                               object:nil];
    
}
-(void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    objc_msgSend([UIDevice currentDevice], @selector(setOrientation:), UIInterfaceOrientationPortrait );
    [self updateTextUI];

}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIContentSizeCategoryDidChangeNotification
                                                  object:nil];
    }
- (void)updateTextUI
{
    
    NSAttributedString *attributedText = [self attributedTextViewString];
    [self.textView setAttributedText:attributedText];
    [self setAttributedTextWithUserFonts];
}

#pragma mark - Set the textView
//Generate attributedString from "Scene" dictionary
- (NSAttributedString *)attributedTextViewString
{
    //also can storage the list and dictionary at DataParser or configuation file
    NSArray *displayList = @[SCENE_OPEN_HOUR,SCENE_TICKET,SCENE_PHONE];
    NSDictionary *displayTitle = @{SCENE_TITLE:@"",SCENE_OPEN_HOUR:@"Open Hour:",SCENE_TICKET:@"Ticket:",SCENE_PHONE:@"Contact:",SCENE_DESCRIPTION:@"",SCENE_TAG:@"Tag:"};
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.alignment = NSTextAlignmentLeft;
    //attributes:@{NSParagraphStyleAttributeName:paragraphStyle}]

    NSString *displayString = [self.scene valueForKey:SCENE_TITLE];
    for (NSString *key in displayList )
    {
        NSString *head = [displayTitle valueForKey:key];
        NSString *content = [self.scene valueForKey:key];
        if(content.length)
        {
            displayString =[displayString stringByAppendingString:[NSString stringWithFormat:@"\n%@ %@",head,content]];
            //e.g. Open Hour: 8:00-17:00
        }
    }
    NSMutableAttributedString *paragraph = [[NSMutableAttributedString alloc] initWithString:displayString];
    
    if(paragraph.length)
    {
        [paragraph appendAttributedString:[[NSAttributedString alloc] initWithString:@"\n"]];
    }
    NSAttributedString* briefText = [[NSAttributedString alloc]
                                     initWithString:[self.scene valueForKey:SCENE_DESCRIPTION] attributes:@{NSForegroundColorAttributeName:[UIColor grayColor]}];

    [paragraph appendAttributedString:briefText];
   // [paragraph appendAttributedString:anotherAttributedString];
    
    return [paragraph copy];
}
- (void)userFontsChanged:(NSNotification *)notification
{
    [self setAttributedTextWithUserFonts];
}
//The "mark" button can help user to set the whole scene description that they selected or highlight/defualt the
- (IBAction)highlightSelectedText:(UIBarButtonItem *)sender
{
    NSRange range;
    range.length = self.textView.attributedText.length;
    range.location = 0;
    if(self.textView.selectedRange.length)
    {
        range = self.textView.selectedRange;
    }
    NSRange markedRange;
    //id value = [self.textView.attributedText attribute:NSStrokeWidthAttributeName atIndex:range.location effectiveRange:&markedRange];
    id value = [self.textView.attributedText attribute:NSStrokeWidthAttributeName atIndex:range.location longestEffectiveRange:&markedRange inRange:range];
    //if the selected area already been marked, then set the selected text to the default style
    if ([value isEqual:@-3] && (markedRange.length+markedRange.location>=range.length+range.location))
    {
        [self setAttributedTextDefault:range];
    }
    //otherwise, highlight the selected text
    else
    {
        [self setAttributedTextHighlight:range];
    }
    self.textView.selectedTextRange=nil;
}
//Use system default text font in UITextView
- (void)setAttributedTextWithUserFonts
{
    self.textView.font = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
}
//Highlighted text settings:outlined
- (void)setAttributedTextHighlight:(NSRange)range
{
    [self.textView.textStorage addAttributes:@{
                                               NSStrokeWidthAttributeName : @-3,
                                               NSStrokeColorAttributeName : [UIColor blackColor]}
                                       range:range];//,NSForegroundColorAttributeName:[UIColor redColor]: use it to have different highlight color
}
//Default style:black color and no outline
- (void)setAttributedTextDefault:(NSRange)range
{
    [self.textView.textStorage addAttributes:@{
                                               NSStrokeWidthAttributeName : @0}
                                       range:range];//,NSForegroundColorAttributeName:[UIColor blackColor]
}
#pragma mark - Setting the Image from the Image's URL
//Download image from URL by async way
- (void)startDownloadingImage:(NSURL *)imageURL
{
    self.image = nil;
    if (imageURL)
    {
        [self.indicator startAnimating];
        NSURLRequest *request = [NSURLRequest requestWithURL:imageURL];
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration ephemeralSessionConfiguration];        //not download when the APP is in the background
        NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];
        NSURLSessionDownloadTask *task = [session downloadTaskWithRequest:request
                                                        completionHandler:^(NSURL *localfile, NSURLResponse *response, NSError *error) {
                                                            if (!error) {
                                                                if ([request.URL isEqual:imageURL]) {
                                                                    UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:localfile]];
                                                                    dispatch_async(dispatch_get_main_queue(), ^{ self.image = image; });
                                                                }
                                                            }
                                                        }];
        [task resume]; // NSURLSession tasks start
    }
}
#pragma mark - Rotation
//Disable screen rotation for this view
//- (BOOL)shouldAutorotate
//{
//    return NO;
//}
//Garrantee portrait on this view
- (NSUInteger)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskPortrait;
}
- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return UIInterfaceOrientationPortrait;
}


@end
