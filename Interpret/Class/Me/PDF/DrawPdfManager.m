//
//  DrawPdfManager.m
//  Interpret
//
//  Created by 乔杰 on 2018/1/31.
//  Copyright © 2018年 乔杰. All rights reserved.
//

#import "DrawPdfManager.h"

@implementation DrawPdfManager
//
//// 1.创建media box
//CGFloat myPageWidth = self.view.bounds.size.width;
//CGFloat myPageHeight = self.view.bounds.size.height;
//CGRect mediaBox = CGRectMake (0, 0, myPageWidth, myPageHeight);
//
//
//// 2.设置pdf文档存储的路径
//NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//NSString *documentsDirectory = paths[0];
//NSString *filePath = [documentsDirectory stringByAppendingString:@"/test.pdf"];
//NSLog(@"%@", filePath);
//const char *cfilePath = [filePath UTF8String];
//CFStringRef pathRef = CFStringCreateWithCString(NULL, cfilePath, kCFStringEncodingUTF8);
//
//
//// 3.设置当前pdf页面的属性
//CFStringRef myKeys[3];
//CFTypeRef myValues[3];
//myKeys[0] = kCGPDFContextMediaBox;
//myValues[0] = (CFTypeRef) CFDataCreate(NULL,(const UInt8 *)&mediaBox, sizeof (CGRect));
//myKeys[1] = kCGPDFContextTitle;
//myValues[1] = CFSTR("我的PDF");
//myKeys[2] = kCGPDFContextCreator;
//myValues[2] = CFSTR("Creator Name");
//CFDictionaryRef pageDictionary = CFDictionaryCreate(NULL, (const void **) myKeys, (const void **) myValues, 3,
//                                                    &kCFTypeDictionaryKeyCallBacks, & kCFTypeDictionaryValueCallBacks);
//
//
//// 4.获取pdf绘图上下文
//CGContextRef myPDFContext = MyPDFContextCreate (&mediaBox, pathRef);
//
//
//// 5.开始描绘第一页页面
//CGPDFContextBeginPage(myPDFContext, pageDictionary);
//CGContextSetRGBFillColor (myPDFContext, 1, 0, 0, 1);
//CGContextFillRect (myPDFContext, CGRectMake (0, 0, 200, 100 ));
//CGContextSetRGBFillColor (myPDFContext, 0, 0, 1, .5);
//CGContextFillRect (myPDFContext, CGRectMake (0, 0, 100, 200 ));
//
//// 为一个矩形设置URL链接www.baidu.com
//CFURLRef baiduURL = CFURLCreateWithString(NULL, CFSTR("http://www.baidu.com"), NULL);
//CGContextSetRGBFillColor (myPDFContext, 0, 0, 0, 1);
//CGContextFillRect (myPDFContext, CGRectMake (200, 200, 100, 200 ));
//CGPDFContextSetURLForRect(myPDFContext, baiduURL, CGRectMake (200, 200, 100, 200 ));
//
//CGPDFContextEndPage(myPDFContext);
//
//
//
//// 6.开始描绘第二页页面
//// 注意要另外创建一个page dictionary
//CFDictionaryRef page2Dictionary = CFDictionaryCreate(NULL, (const void **) myKeys, (const void **) myValues, 3,
//                                                     &kCFTypeDictionaryKeyCallBacks, & kCFTypeDictionaryValueCallBacks);
//CGPDFContextBeginPage(myPDFContext, page2Dictionary);
//
//// 在左下角画两个矩形
//CGContextSetRGBFillColor (myPDFContext, 1, 0, 0, 1);
//CGContextFillRect (myPDFContext, CGRectMake (0, 0, 200, 100 ));
//CGContextSetRGBFillColor (myPDFContext, 0, 0, 1, .5);
//CGContextFillRect (myPDFContext, CGRectMake (0, 0, 100, 200 ));
//
//// 在右下角写一段文字:"Hello world"
//CGContextSelectFont(myPDFContext, "Helvetica", 5, kCGEncodingMacRoman);
//CGContextSetTextDrawingMode (myPDFContext, kCGTextFill);
//CGContextSetRGBFillColor (myPDFContext, 0, 0, 0, 1);
//const char *text = [@"Hello world" UTF8String];
//CGContextShowTextAtPoint (myPDFContext, 120, 120, text, strlen(text));
//
///*
// // 为某一个矩形设置destination，这里destination的作用还不是很明白，保留
// CGPDFContextSetDestinationForRect(myPDFContext, CFSTR("Hello world"), CGRectMake(50.0, 300.0, 100.0, 100.0));
// CGContextSetRGBFillColor(myPDFContext, 1, 0, 1, 0.5);
// CGContextFillEllipseInRect(myPDFContext, CGRectMake(50.0, 300.0, 100.0, 100.0));
// */
//
//// 为右上角的矩形设置一段file URL链接，打开本地文件
//NSURL *furl = [NSURL fileURLWithPath:@"/Users/one/Library/Application Support/iPhone Simulator/7.0/Applications/3E7CB341-693A-4FE4-8FE5-A827A5210F0A/Documents/test1.pdf"];
//CFURLRef fileURL = (__bridge CFURLRef)furl;
//CGContextSetRGBFillColor (myPDFContext, 0, 0, 0, 1);
//CGContextFillRect (myPDFContext, CGRectMake (200, 200, 100, 200 ));
//CGPDFContextSetURLForRect(myPDFContext, fileURL, CGRectMake (200, 200, 100, 200 ));
//
//CGPDFContextEndPage(myPDFContext);
//
//
//
//// 7.释放创建的对象
//CFRelease(page2Dictionary);
//CFRelease(pageDictionary);
//CFRelease(myValues[0]);
//CGContextRelease(myPDFContext);
//}
//
//
///*
// * 获取pdf绘图上下文
// * inMediaBox指定pdf页面大小
// * path指定pdf文件保存的路径
// */
//CGContextRef MyPDFContextCreate (const CGRect *inMediaBox, CFStringRef path)
//{
//    CGContextRef myOutContext = NULL;
//    CFURLRef url;
//    CGDataConsumerRef dataConsumer;
//
//    url = CFURLCreateWithFileSystemPath (NULL, path, kCFURLPOSIXPathStyle, false);
//
//    if (url != NULL)
//    {
//        dataConsumer = CGDataConsumerCreateWithURL(url);
//        if (dataConsumer != NULL)
//        {
//            myOutContext = CGPDFContextCreate (dataConsumer, inMediaBox, NULL);
//            CGDataConsumerRelease (dataConsumer);
//        }
//        CFRelease(url);
//    }
//    return myOutContext;
//
//}
//
//
//
//- (IBAction)savePDFFile:(id)sender
//{
//
//    NSString *str = @"你好";
//
//    // Prepare the text using a Core Text Framesetter.
//    CFAttributedStringRef currentText = CFAttributedStringCreate(NULL, (CFStringRef)str, NULL);
//    if (currentText) {
//        CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString(currentText);
//        if (framesetter) {
//
//            NSString *pdfFileName = @"nihao.pdf";
//            // Create the PDF context using the default page size of 612 x 792.
//            UIGraphicsBeginPDFContextToFile(pdfFileName, CGRectZero, nil);
//
//            CFRange currentRange = CFRangeMake(0, 0);
//            NSInteger currentPage = 0;
//            BOOL done = NO;
//
//            do {
//                // Mark the beginning of a new page.
//                UIGraphicsBeginPDFPageWithInfo(CGRectMake(0, 0, 612, 792), nil);
//
//                // Draw a page number at the bottom of each page.
//                currentPage++;
//                [self drawPageNumber:currentPage];
//
//                // Render the current page and update the current range to
//                // point to the beginning of the next page.
//                currentRange = [self renderPage:3 withTextRange:currentRange andFramesetter:framesetter];
//
//                // If we're at the end of the text, exit the loop.
//                if (currentRange.location == CFAttributedStringGetLength((CFAttributedStringRef)currentText))
//                    done = YES;
//            } while (!done);
//
//            // Close the PDF context and write the contents out.
//            UIGraphicsEndPDFContext();
//
//            // Release the framewetter.
//            CFRelease(framesetter);
//
//        } else {
//            NSLog(@"Could not create the framesetter needed to lay out the atrributed string.");
//        }
//        // Release the attributed string.
//        CFRelease(currentText);
//    } else {
//        NSLog(@"Could not create the attributed string for the framesetter");
//    }
//}
//
//
//// Use Core Text to draw the text in a frame on the page.
//- (CFRange)renderPage:(NSInteger)pageNum withTextRange:(CFRange)currentRange
//       andFramesetter:(CTFramesetterRef)framesetter
//{
//    // Get the graphics context.
//    CGContextRef    currentContext = UIGraphicsGetCurrentContext();
//
//    // Put the text matrix into a known state. This ensures
//    // that no old scaling factors are left in place.
//    CGContextSetTextMatrix(currentContext, CGAffineTransformIdentity);
//
//    // Create a path object to enclose the text. Use 72 point
//    // margins all around the text.
//    CGRect    frameRect = CGRectMake(72, 72, 468, 648);
//    CGMutablePathRef framePath = CGPathCreateMutable();
//    CGPathAddRect(framePath, NULL, frameRect);
//
//    // Get the frame that will do the rendering.
//    // The currentRange variable specifies only the starting point. The framesetter
//    // lays out as much text as will fit into the frame.
//    CTFrameRef frameRef = CTFramesetterCreateFrame(framesetter, currentRange, framePath, NULL);
//    CGPathRelease(framePath);
//
//    // Core Text draws from the bottom-left corner up, so flip
//    // the current transform prior to drawing.
//    CGContextTranslateCTM(currentContext, 0, 792);
//    CGContextScaleCTM(currentContext, 1.0, -1.0);
//
//    // Draw the frame.
//    CTFrameDraw(frameRef, currentContext);
//
//    // Update the current range based on what was drawn.
//    currentRange = CTFrameGetVisibleStringRange(frameRef);
//    currentRange.location += currentRange.length;
//    currentRange.length = 0;
//    CFRelease(frameRef);
//
//    return currentRange;
//}
//
//- (void)drawPageNumber:(NSInteger)pageNum
//{
//    NSString *pageString = [NSString stringWithFormat:@"Page %ld", (long)pageNum];
//    UIFont *theFont = [UIFont systemFontOfSize:12];
//    CGSize maxSize = CGSizeMake(612, 72);
//
//    CGSize pageStringSize = [pageString sizeWithFont:theFont
//                                   constrainedToSize:maxSize
//                                       lineBreakMode:UILineBreakModeClip];
//    CGRect stringRect = CGRectMake(((612.0 - pageStringSize.width) / 2.0),
//                                   720.0 + ((72.0 - pageStringSize.height) / 2.0),
//                                   pageStringSize.width,
//                                   pageStringSize.height);
//
//    [pageString drawInRect:stringRect withFont:theFont];
//}

@end
