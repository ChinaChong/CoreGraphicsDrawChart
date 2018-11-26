//
//  ViewController.m
//  图形绘制
//
//  Created by 崇 on 2018/11/15.
//  Copyright © 2018 崇. All rights reserved.
//

#import "ViewController.h"
#import "ShowViewController.h"

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:self.tableView];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.textLabel.text = self.dataArray[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ShowViewController *vc = [[ShowViewController alloc] init];
    switch (indexPath.row) {
        case 0:{
            vc.showStyle = ShowCoordinateSystem;
        }
            break;
        case 1:{
            vc.showStyle = ShowLineChart;
        }
            break;
        case 2:{
            vc.showStyle = ShowBarChart;
        }
            break;
        case 3:{
            vc.showStyle = ShowPieChart;
        }
            break;
        case 4:{
            vc.showStyle = ShowAnnulusChart;
        }
            break;
        case 5:{
            vc.showStyle = ShowAreaChart;
        }
            break;
            
        default:
            break;
    }
    
    [self presentViewController:vc animated:YES completion:nil];
}

- (NSMutableArray *)dataArray {
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray array];
        [_dataArray addObject:@"坐标系"];
        [_dataArray addObject:@"折线图"];
        [_dataArray addObject:@"柱状图"];
        [_dataArray addObject:@"圆饼图"];
        [_dataArray addObject:@"环形图"];
        [_dataArray addObject:@"区域填充"];
    }
    return _dataArray;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    long power = 0;
    int temp = 1000;
    while (temp >= 100) {
        temp = temp / 10;
        power++;
    }
    
    NSLog(@"%f", pow(10, power));
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
