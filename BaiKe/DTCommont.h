


#import <Foundation/Foundation.h>


#define HC_RELEASE(__POINTER) { [__POINTER release]; __POINTER = nil; }

#define RGB(_red, _green, _blue) [UIColor colorWithRed:_red/255.0f green:_green/255.0f blue:_blue/255.0f alpha:1.0f]

#define APPSTOREID 


typedef enum {
    ERROR_REQUEST_RESPONSENULL = 10002,
} ERROR;

typedef enum _NSBubbleType
{
    BubbleTypeMine = 0,
    BubbleTypeKeFu = 1,
    BubbleTypeCustomService = 2,
    BubbleTypeSomeoneElse = 3
} NSBubbleType;


typedef enum {
    CapLeft          = 0,
    CapMiddle        = 1,
    CapRight         = 2,
    CapLeftAndRight  = 3
} CapLocation;

#ifdef DEBUG 
#   define DLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__); 
#else 
#   define DLog(...) 
#endif 
// ALog always displays output regardless of the DEBUG setting 
#define ALog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__); 

#define KeyBoard_DONE_KEY	 @"Return-Key"
#define KeyBoard_DONE_Title	 @"确定"


#define ChatFontSize  15
#define PushMessageFontSize 17.0f
#define ResultMessageFontSize 17.0f

#define MessageTimeHeadHeight  40.0f

#define ALERTVIEWTITLE @"湖北联通10010"

//消息定义
#define NONEWMESSAGE   10000


#define NUMBEROFPERREQUEST 40


#define FULLTEXTRECT CGRectMake(100, 10, 190, 30)
#define SHORTTEXTRECT CGRectMake(100, 10, 150, 30)
#define FULLLABELRECT CGRectMake(100, 1, 190, 40)
#define SHORTLABELRECT CGRectMake(100, 1, 150, 40)

#define ADDBUT_OKCANCEL	\
if (m_bfirstflag) {\
UIButton * lastbut=(UIButton * )[cell viewWithTag:300];\
if(lastbut)\
[lastbut removeFromSuperview];\
lastbut=(UIButton * )[cell viewWithTag:301];\
if(lastbut)\
[lastbut removeFromSuperview];\
UIButton * tempButton = [UIButton buttonWithType:UIButtonTypeCustom];\
[tempButton setTitle:@"提 交" forState:UIControlStateNormal];\
[tempButton setTitleColor:[UIColor blackColor]  forState:UIControlStateNormal];\
[tempButton setBackgroundImage:[UIImage imageNamed:@"queding3.png"]  forState:UIControlStateNormal];\
[tempButton setBackgroundImage:[UIImage imageNamed:@"queding4.png"]  forState:UIControlStateHighlighted];\
[tempButton addTarget:self action:@selector(doneButtonClick) forControlEvents:UIControlEventTouchDown];\
tempButton.frame = CGRectMake(myTableView.center.x-100-20, 4, 100, 39);\
tempButton.tag=300;\
[cell.contentView addSubview:tempButton];\
tempButton = [UIButton buttonWithType:UIButtonTypeCustom];\
[tempButton setTitle:@"取 消" forState:UIControlStateNormal];\
[tempButton setTitleColor:[UIColor blackColor]  forState:UIControlStateNormal];\
[tempButton setBackgroundImage:[UIImage imageNamed:@"queding3.png"]  forState:UIControlStateNormal];\
[tempButton setBackgroundImage:[UIImage imageNamed:@"queding4.png"]  forState:UIControlStateHighlighted];\
[tempButton addTarget:self action:@selector(cancelButtonClick) forControlEvents:UIControlEventTouchDown];\
tempButton.frame = CGRectMake(myTableView.center.x+20, 4, 100, 38);\
tempButton.tag=301;\
[cell.contentView addSubview:tempButton];\
}\

