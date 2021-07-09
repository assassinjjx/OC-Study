//
//  TableViewController.m
//  iOS_Development_Study
//
//  Created by smbapp on 2021/7/5.
//

#import "TableViewController.h"

NSString *const ListCellId = @"cell";


@interface TableViewController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *studyTableView;
@property (strong, nonatomic) NSMutableArray *titleArray;
@property (strong, nonatomic) NSMutableArray *genderArray;
@property (strong, nonatomic) NSMutableArray *imageArray;

@property (assign, nonatomic) MySQLite *studyDatabase;

@end

@implementation TableViewController

#pragma mark- Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.studyDatabase = [MySQLite getMySQLiteInstance];
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSInteger ID = [userDefault integerForKey:@"id"];
    if (!ID) {
        [userDefault setInteger:1 forKey:@"id"];
    }
    
    UIBarButtonItem *shareItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addEvent)];
    self.navigationItem.rightBarButtonItem = shareItem;
    
    [self loadDataSource];
    [self studyTableViewInit];
}

#pragma mark- Public Method
#pragma mark- Delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.titleArray.count;
}

//创建tableView中的每一个cell，这里使用复用机制。
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    indexPath.section
//    indexPath.row

    ListCell *cell = [tableView dequeueReusableCellWithIdentifier:ListCellId forIndexPath:indexPath];
    cell.title = self.titleArray[indexPath.row];
    cell.gender = self.genderArray[indexPath.row];
    cell.image = self.imageArray[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ListCell *operateCell = (ListCell *)[tableView cellForRowAtIndexPath:indexPath];
    NSString *title = [operateCell getTitle];
    NSInteger genderNumber = 0;
    if (![[operateCell getGender] isEqual:@"Male"]) {
        genderNumber = 1;
    }
    [self.studyDatabase updateData:title gender:genderNumber];
    [self loadDataSource];
    // 取消选中状态
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

#pragma mark- Event Response
- (void)addEvent {
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSInteger ID = [userDefault integerForKey:@"id"];
    
    NSString *titleString = [NSString stringWithFormat:@"jjx%ld", ID];
    NSInteger genderNumber = ID % 2;
    NSString *genderString = genderNumber ? @"Male" : @"Female";
    [self.studyDatabase insertData:titleString gender:genderNumber];
    [self.titleArray addObject:titleString];
    [self.genderArray addObject:genderString];
    UIImage *cellImage = [UIImage imageNamed:@"Screenshot_20210629_101438.jpg"];
    [self.imageArray addObject:cellImage];
    [self.studyTableView reloadData];
    
    [userDefault setInteger:ID + 1 forKey:@"id"];
}

- (void)onHeadImageViewClicked:(UITapGestureRecognizer*)tap {
    [ELYTToast showTopWithText: @"Hello World!"];
}

// 下拉刷新触发，在此刷新数据
- (void)refreshClick:(UIRefreshControl *)refreshControl {
    [self loadDataSource];
    
    [refreshControl endRefreshing];
}

- (void)onStudyTableViewLongPressed:(UILongPressGestureRecognizer *)gestureRecognizer {
    CGPoint point = [gestureRecognizer locationInView:self.studyTableView];
    NSIndexPath *indexPath = [self.studyTableView indexPathForRowAtPoint:point];
    if(gestureRecognizer.state == UIGestureRecognizerStateEnded) {
        ListCell *operateCell = (ListCell *)[self.studyTableView cellForRowAtIndexPath:indexPath];
        [self.studyDatabase deleteData:operateCell.getTitle];
        [self loadDataSource];
    }
}

#pragma mark- Getters and Setters
#pragma mark- Private Method
- (void)studyTableViewInit{
    self.studyTableView.frame = self.view.bounds;
    self.studyTableView.delegate = self;
    self.studyTableView.dataSource = self;
    self.studyTableView.showsVerticalScrollIndicator = NO;
    self.studyTableView.showsHorizontalScrollIndicator = NO;
    self.studyTableView.tag = 301;
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 200)];
    UIImageView *headerImage = [[UIImageView alloc] init];
    [headerImage sd_setImageWithURL:[NSURL URLWithString:@"http://www.baidu.com/img/bdlogo.png"] placeholderImage:[UIImage imageNamed:@"Screenshot_20210629_101438.jpg"]];
    [headerView addSubview:headerImage];
    [headerImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(headerView);
        make.width.mas_equalTo(320);
        make.height.mas_equalTo(160);
    }];
    self.studyTableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    self.studyTableView.tableHeaderView = headerView;
    self.studyTableView.tableFooterView = [[UIView alloc] init];
    [self.view addSubview:self.studyTableView];
    
    headerImage.userInteractionEnabled = YES;
    //初始化studyImageView点击手势
    UITapGestureRecognizer *studyimageTapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onHeadImageViewClicked:)];
    [headerImage addGestureRecognizer:studyimageTapGestureRecognizer];
    
    [self setStudyTableViewEvents];
}

//加载数据
- (void)loadDataSource {
    NSDictionary *sources = [self.studyDatabase sqlData];
    if (sources != nil) {
        self.titleArray = [sources objectForKey:@"nameArray"];
        self.genderArray = [sources objectForKey:@"genderArray"];
        self.imageArray = [NSMutableArray arrayWithCapacity:0];
        //循环添加图片数据
        for (int i = 0; i < self.titleArray.count; ++i) {
            UIImage *image = [UIImage imageNamed:@"Screenshot_20210629_101438.jpg"];
            [self.imageArray addObject:image];
        }
    } else {
        self.titleArray = [NSMutableArray arrayWithCapacity:0];
        self.genderArray = [NSMutableArray arrayWithCapacity:0];
        self.imageArray = [NSMutableArray arrayWithCapacity:0];
    }
    
    [self.studyTableView reloadData];
}

- (void)setStudyTableViewEvents {
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(refreshClick:) forControlEvents:UIControlEventValueChanged];
    refreshControl.attributedTitle = [[NSAttributedString alloc]initWithString:@"正在刷新"];
    //刷新图形时的颜色
    refreshControl.tintColor = [UIColor grayColor];
    [self.studyTableView addSubview:refreshControl];
    
    UILongPressGestureRecognizer *tapGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(onStudyTableViewLongPressed:)];
    tapGesture.minimumPressDuration = 1;
    [self.studyTableView addGestureRecognizer:tapGesture];
}

@end
