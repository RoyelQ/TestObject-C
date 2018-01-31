//
//  CalendarPickerView.m
//  TestNetworkApi
//
//  Created by 乔杰 on 2017/12/28.
//  Copyright © 2017年 乔杰. All rights reserved.
//

#import "CalendarPickerView.h"

static NSString *calendarCollectionViewCell = @"calendarCollectionViewCell";

@interface CalendarPickerView () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UIView *topBackView;

@property (nonatomic, strong) UIButton *lastMonthButton;

@property (nonatomic, strong) UILabel *currentDateLabel;

@property (nonatomic, strong) UIButton *nextMonthButton;


@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, assign) NSInteger lineNumbers;

@property (nonatomic, assign) CGFloat lineHeight;

@property (nonatomic, strong) NSDate *currentDate;

@end

@implementation CalendarPickerView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame: frame];
    
    if (self) {
        
        self.currentDate = [NSDate date];
        self.lineNumbers = [self lineNumbersOfCollectionView: self.currentDate];
        self.lineHeight = ScreenWidth/7.0 + 15;
        [self setTopView];
        [self setUpCollectionView];

        [self getChineseCalendarWithDate: self.currentDate];
        
    }
    return self;
}


- (CGFloat)viewHeight {
    
    return self.lineNumbers * self.lineHeight + AdaptX(60) + 20;
}


- (NSInteger)lineNumbersOfCollectionView:(NSDate *)date {
    
    return ([self firstWeekdayInThisMonth: date] + [self totaldaysInThisMonth: date] + 6)/7;
}



#pragma mark - 数据处理
- (NSInteger)day:(NSDate *)date{
    NSDateComponents *components = [[NSCalendar currentCalendar] components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:date];
    return [components day];
}

- (NSInteger)month:(NSDate *)date{
    NSDateComponents *components = [[NSCalendar currentCalendar] components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:date];
    return [components month];
}

- (NSInteger)year:(NSDate *)date{
    NSDateComponents *components = [[NSCalendar currentCalendar] components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:date];
    return [components year];
}


- (NSString*)getChineseCalendarWithDate:(NSDate *)date{
    
    NSArray *chineseYears = [NSArray arrayWithObjects:
                             @"甲子", @"乙丑", @"丙寅", @"丁卯",  @"戊辰",  @"己巳",  @"庚午",  @"辛未",  @"壬申",  @"癸酉",
                             @"甲戌",   @"乙亥",  @"丙子",  @"丁丑", @"戊寅",   @"己卯",  @"庚辰",  @"辛己",  @"壬午",  @"癸未",
                             @"甲申",   @"乙酉",  @"丙戌",  @"丁亥",  @"戊子",  @"己丑",  @"庚寅",  @"辛卯",  @"壬辰",  @"癸巳",
                             @"甲午",   @"乙未",  @"丙申",  @"丁酉",  @"戊戌",  @"己亥",  @"庚子",  @"辛丑",  @"壬寅",  @"癸丑",
                             @"甲辰",   @"乙巳",  @"丙午",  @"丁未",  @"戊申",  @"己酉",  @"庚戌",  @"辛亥",  @"壬子",  @"癸丑",
                             @"甲寅",   @"乙卯",  @"丙辰",  @"丁巳",  @"戊午",  @"己未",  @"庚申",  @"辛酉",  @"壬戌",  @"癸亥", nil];
    
    NSArray *chineseMonths=[NSArray arrayWithObjects:
                            @"正月", @"二月", @"三月", @"四月", @"五月", @"六月", @"七月", @"八月",
                            @"九月", @"十月", @"冬月", @"腊月", nil];
    
    NSArray *chineseDays=[NSArray arrayWithObjects:
                          @"初一", @"初二", @"初三", @"初四", @"初五", @"初六", @"初七", @"初八", @"初九", @"初十",
                          @"十一", @"十二", @"十三", @"十四", @"十五", @"十六", @"十七", @"十八", @"十九", @"二十",
                          @"廿一", @"廿二", @"廿三", @"廿四", @"廿五", @"廿六", @"廿七", @"廿八", @"廿九", @"三十",  nil];
    
    
    NSCalendar *localeCalendar = [[NSCalendar alloc] initWithCalendarIdentifier: NSCalendarIdentifierChinese];
    
    unsigned unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth |  NSCalendarUnitDay;
    
    NSDateComponents *localeComp = [localeCalendar components:unitFlags fromDate: date];
    
    
    NSString *y_str = [chineseYears objectAtIndex:localeComp.year-1];
    NSString *m_str = [chineseMonths objectAtIndex:localeComp.month-1];
    NSString *d_str = [chineseDays objectAtIndex:localeComp.day-1];
    
    NSString *chineseCal_str =[NSString stringWithFormat: @"%@_%@_%@",y_str,m_str,d_str];
    
    return d_str;
}


////当前日期星期几
//- (NSString*)weekdayStringFromDate:(NSDate*)inputDate {
//
//    NSArray *weekdays = [NSArray arrayWithObjects: [NSNull null], @"Sunday", @"周一", @"周二", @"周三", @"周四", @"周五", @"周六", nil];
//
//    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier: NSCalendarIdentifierGregorian];
//
//    NSTimeZone *timeZone = [[NSTimeZone alloc] initWithName:@"Asia/Shanghai"];
//
//    [calendar setTimeZone: timeZone];
//
//    NSCalendarUnit calendarUnit = NSCalendarUnitWeekday;
//
//    NSDateComponents *theComponents = [calendar components:calendarUnit fromDate:inputDate];
//
//    return [weekdays objectAtIndex:theComponents.weekday];
//
//}
//当月第一天星期几
- (NSInteger)firstWeekdayInThisMonth:(NSDate *)date{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    [calendar setFirstWeekday:1];//1.Sun. 2.Mon. 3.Thes. 4.Wed. 5.Thur. 6.Fri. 7.Sat.
    NSDateComponents *comp = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate: date];
    [comp setDay:1];
    NSDate *firstDayOfMonthDate = [calendar dateFromComponents:comp];
    
    NSUInteger firstWeekday = [calendar ordinalityOfUnit:NSCalendarUnitWeekday inUnit:NSCalendarUnitWeekOfMonth forDate:firstDayOfMonthDate];
    return firstWeekday - 1;
}


- (NSInteger)totaldaysInThisMonth:(NSDate *)date{
    NSRange totaldaysInMonth = [[NSCalendar currentCalendar] rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:date];
    return totaldaysInMonth.length;
}


- (NSDate *)lastMonth:(NSDate *)date{
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    dateComponents.month = -1;
    NSDate *newDate = [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:date options:0];
    return newDate;
}

- (NSDate*)nextMonth:(NSDate *)date{
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    dateComponents.month = +1;
    NSDate *newDate = [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:date options:0];
    return newDate;
}



#pragma mark - UICollectionViewDelegateFlowLayout
- (void)setUpCollectionView {
    //布局collectionView
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.minimumLineSpacing = 0;
    //初始化collectionView
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout: flowLayout];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    //滚动条设置为不显示
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    //代理
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self addSubview:self.collectionView];
    self.collectionView.scrollEnabled = NO;
    //给当前collectionView添加约束
    [self.collectionView setFrame: CGRectMake(0, AdaptX(60) + 20, ScreenWidth, self.lineNumbers * self.lineHeight)];
    //注册单元格
    [self.collectionView registerClass: [QJCalendarCollectionViewCell class] forCellWithReuseIdentifier: calendarCollectionViewCell];
}


#pragma mark - UICollectionViewDelegateFlowLayout
//缩进collectionViewCell
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0, 0, 0, 0);
}
//item大小设置
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {

    return CGSizeMake(ScreenWidth/7.0, self.lineHeight);
}

#pragma mark - UICollectionViewDataSource
//collectionView区数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}
//collectionView行数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return [self firstWeekdayInThisMonth: self.currentDate] + [self totaldaysInThisMonth: self.currentDate];
}

//单元格
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    QJCalendarCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier: calendarCollectionViewCell forIndexPath:indexPath];
    if (!cell) {
        cell = [[QJCalendarCollectionViewCell alloc] init];
    }
    
    cell.currentDate = indexPath.item == [self firstWeekdayInThisMonth: self.currentDate] + [self day: self.currentDate] - 1;

    if (indexPath.item >= [self firstWeekdayInThisMonth: self.currentDate] && indexPath.item <= [self firstWeekdayInThisMonth: self.currentDate] + [self totaldaysInThisMonth: self.currentDate]) {

        cell.gregorianDateLabel.text = [NSString stringWithFormat: @"%ld", (long)indexPath.item + 1 - [self firstWeekdayInThisMonth: self.currentDate]];
        cell.lunarDateLabel.text = [self getChineseCalendarWithDate: [self date: (indexPath.item + 1 - [self firstWeekdayInThisMonth: self.currentDate])]];
        cell.affairsButton.hidden = NO;
    }else {
        cell.gregorianDateLabel.text = @"";
        cell.lunarDateLabel.text = @"";
        cell.affairsButton.hidden = YES;
    }
    return cell;
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    NSDate *selectedDate = [self date: (indexPath.item + 1 - [self firstWeekdayInThisMonth: self.currentDate])];
    
    
}


- (NSDate *)date:(NSInteger)day {
 
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateFormat: @"yyyy-MM"];
    
    NSString *dayStr = [NSString stringWithFormat: @"%@-%02ld", [dateFormatter stringFromDate: self.currentDate], day];
    
    NSDateFormatter *dateFormatter1 = [[NSDateFormatter alloc] init];
    
    [dateFormatter1 setDateFormat: @"yyyy-MM-dd"];
    
    return [dateFormatter1 dateFromString: dayStr];
}


#pragma mark - 顶部视图
- (void)setTopView {
    
    self.topBackView = [[UIView alloc] initWithFrame: CGRectMake(0, 0, ScreenWidth, AdaptX(60) + 20)];
    self.topBackView.backgroundColor = [UIColor whiteColor];
    [self addSubview: self.topBackView];
    
    //上一月
    self.lastMonthButton = [UIButton buttonWithType: UIButtonTypeCustom];
    self.lastMonthButton.titleLabel.font = [UIFont systemFontOfSize:16];
    [self.lastMonthButton setTitle:@"上一月" forState:UIControlStateNormal];
    [self.topBackView addSubview: self.lastMonthButton];
    [self.lastMonthButton setTitleColor: ColorFromHex(0x404040) forState: UIControlStateNormal];
    [self.lastMonthButton setFrame: CGRectMake(10, 10, 60, AdaptX(30))];
    [self.lastMonthButton addTarget:self action:@selector(lastMonthButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    //下一月
    self.nextMonthButton = [UIButton buttonWithType: UIButtonTypeCustom];
    self.nextMonthButton.titleLabel.font = [UIFont systemFontOfSize:16];
    [self.nextMonthButton setTitle:@"下一月" forState:UIControlStateNormal];
    [self.topBackView addSubview:self.nextMonthButton];
    [self.nextMonthButton setTitleColor: ColorFromHex(0x404040) forState: UIControlStateNormal];
    [self.nextMonthButton setFrame: CGRectMake(ScreenWidth - 70, 10, 60, AdaptX(30))];
    [self.nextMonthButton addTarget:self action:@selector(nextMonthButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    self.currentDateLabel = [[UILabel alloc] init];
    self.currentDateLabel.center = CGPointMake(ScreenWidth/2.0, 25.0);
    self.currentDateLabel.bounds = CGRectMake(0, 0, 120, AdaptX(30));
    self.currentDateLabel.textColor = ColorFromHex(0x404040);
    [self.topBackView addSubview: self.currentDateLabel];
    self.currentDateLabel.text = [self dateStrFromDate: self.currentDate];
    self.currentDateLabel.textAlignment = NSTextAlignmentCenter;

    for (int i = 0; i < 2; i ++) {
        UIView *lineView = [[UIView alloc] initWithFrame: CGRectMake(0, AdaptX(30) + 20 + (AdaptX(30) - 0.5)*i, ScreenWidth, 0.5)];
        lineView.backgroundColor = ColorFromHex(0xDCDCDC);
        [self.topBackView addSubview: lineView];
    }
    NSArray *array = @[@"日",@"一",@"二",@"三",@"四",@"五",@"六"];
    for (NSInteger i = 0; i < 7; i ++) {
        CGFloat space = ScreenWidth / array.count;
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(space * i, AdaptX(30) + 20, space, AdaptX(30))];
        label.font = [UIFont systemFontOfSize:14];
        [self.topBackView addSubview:label];
        label.textColor = ColorFromHex(0x808080);
        label.text = array[i];
        label.textAlignment = NSTextAlignmentCenter;
    }
}

- (void)lastMonthButtonClick:(UIButton *)sender {
    
    self.currentDate = [self lastMonth: self.currentDate];
    
    self.lineNumbers = [self lineNumbersOfCollectionView: self.currentDate];

    [self.collectionView reloadData];
    
    self.currentDateLabel.text = [self dateStrFromDate: self.currentDate];

}
- (void)nextMonthButtonClick:(UIButton *)sender {
    
    self.currentDate = [self nextMonth: self.currentDate];
    
    self.lineNumbers = [self lineNumbersOfCollectionView: self.currentDate];
    
    [self.collectionView reloadData];
    
    self.currentDateLabel.text = [self dateStrFromDate: self.currentDate];
}


#pragma 获取当前日期串
- (NSString *)dateStrFromDate:(NSDate *)date {
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateFormat: @"yyyy-MM-dd"];
    
    return [dateFormatter stringFromDate: date ? date : [NSDate date]];
}

@end

@interface QJCalendarCollectionViewCell ()

@property (nonatomic, strong) UIView *topDateView;

@property (nonatomic, strong) UIView *backView;

@end

@implementation QJCalendarCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame: frame];
    if (self) {
        
        self.backgroundColor = ColorFromHex(0xF5F5F5);
        [self setUpSubViews];
    }
    return self;
}


- (void)setCurrentDate:(BOOL)currentDate {
    
    if (currentDate) {
        self.topDateView.backgroundColor = [UIColor redColor];
        self.topDateView.layer.cornerRadius = 20;
        self.topDateView.layer.masksToBounds = YES;
        self.gregorianDateLabel.textColor = [UIColor whiteColor];
        self.lunarDateLabel.textColor = [UIColor whiteColor];
    }else {
        self.topDateView.backgroundColor = [UIColor whiteColor];
        self.gregorianDateLabel.textColor = ColorFromHex(0x404040);
        self.lunarDateLabel.textColor = ColorFromHex(0x808080);
    }
}

- (void)setUpSubViews {
    
    self.backView = [[UIView alloc] initWithFrame: CGRectMake(0.5, 0.5, self.frame.size.width - 0.5, ScreenWidth/7.0 + 14)];
    self.backView.backgroundColor = [UIColor whiteColor];
    [self addSubview: self.backView];
    
 
    self.topDateView = [[UIView alloc] initWithFrame: CGRectMake((ScreenWidth/7.0 - 40)/2.0, (ScreenWidth/7.0 - 40)/2.0, 40, 40)];
    self.topDateView.backgroundColor = [UIColor whiteColor];
    [self.backView addSubview: self.topDateView];
    
    self.gregorianDateLabel = [[UILabel alloc] initWithFrame: CGRectMake(0, (ScreenWidth/7.0 - 35)/2.0, ScreenWidth/7.0 - 0.5, 20)];
    self.gregorianDateLabel.textColor = ColorFromHex(0x404040);
    self.lunarDateLabel.font = [UIFont systemFontOfSize: 16];
    self.gregorianDateLabel.textAlignment = NSTextAlignmentCenter;
    [self.backView addSubview: self.gregorianDateLabel];
    
    self.lunarDateLabel = [[UILabel alloc]  initWithFrame: CGRectMake(0, (ScreenWidth/7.0 - 35)/2.0 + 20, ScreenWidth/7.0 - 0.5, 15)];
    self.lunarDateLabel.textColor = ColorFromHex(0x808080);
    self.lunarDateLabel.font = [UIFont systemFontOfSize: 12];
    self.lunarDateLabel.textAlignment = NSTextAlignmentCenter;
    [self.backView addSubview: self.lunarDateLabel];
 
 
    self.affairsButton = [UIButton buttonWithType: UIButtonTypeCustom];
    [self.affairsButton setBackgroundImage: [self imageWithColor: ColorFromHex(0xF5F5F5)] forState: UIControlStateNormal];
    [self.affairsButton setBackgroundImage: [self imageWithColor: [UIColor redColor]] forState: UIControlStateSelected];
    self.affairsButton.layer.cornerRadius = 4;
    self.affairsButton.layer.masksToBounds = YES;
    self.affairsButton.userInteractionEnabled = NO;
    [self.affairsButton setFrame: CGRectMake((self.frame.size.width - 1 - 8)/2.0, 3 + ScreenWidth/7.0, 8, 8)];
    [self.backView addSubview: self.affairsButton];

}

- (UIImage*) imageWithColor:(UIColor*)color
{
    //根据size绘制图片
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}


@end
