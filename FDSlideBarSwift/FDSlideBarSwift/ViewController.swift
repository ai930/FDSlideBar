//
//  ViewController.swift
//  FDSlideBarSwift
//
//  Created by 蒋林源 on 16/3/3.
//  Copyright © 2016年 蒋林源. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate{

    var slideBar:FDSlideBar = FDSlideBar()
    var tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.view.backgroundColor = [UIColor colorWithRed:0 / 255.0 green:128 / 255.0 blue:128 / 255.0 alpha:1.0];
//        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
        self.view.backgroundColor = UIColor(red: CGFloat(0 / 255.0), green: CGFloat(128 / 255.0), blue: CGFloat(128 / 255.0), alpha: CGFloat(1.0))
        UIApplication.sharedApplication().statusBarStyle = UIStatusBarStyle.LightContent
        
        self.setupSlideBar()
        self.setupTableView()
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "返回", style: UIBarButtonItemStyle.Plain, target: self, action: "prin")
        
        self.navigationItem.title = "xxxx"
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "更多", style: UIBarButtonItemStyle.Plain, target: self, action: "prin")
        
        //MJ进行下拉刷新
        self.tableView.mj_header = MJRefreshNormalHeader(refreshingTarget: self, refreshingAction: "downRefresh")
        
        //MJ上拉加载
        self.tableView.mj_footer = MJRefreshAutoFooter(refreshingTarget: self, refreshingAction: "upRefresh")
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func prin(){
        print("你点击了我！prin")
    }
    
    /**
     Description:下拉刷新实现方法
     */
    func downRefresh(){
        self.tableView.mj_header.beginRefreshing()
        //网络请求获取数据
        self.tableView.reloadData()
        self.tableView.mj_header.endRefreshing()
    }
    /**
     Description:上拉加载实现方法
     */
    func upRefresh(){
        self.tableView.mj_footer.beginRefreshing()
        //        self.tableView.reloadData()
        self.tableView.mj_footer.endRefreshing()
        
    }
    
    func back(){
        //返回上一级视图
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func setupSlideBar(){
//        FDSlideBar *sliderBar = [[FDSlideBar alloc] init];
        let sliderBar:FDSlideBar = FDSlideBar()
//        sliderBar.backgroundColor = [UIColor colorWithRed:0 / 255.0 green:128 / 255.0 blue:128 / 255.0 alpha:1.0];
        sliderBar.backgroundColor = UIColor(red: CGFloat(0 / 255.0), green: CGFloat(128 / 255.0), blue: CGFloat(128 / 255.0), alpha: CGFloat(1.0))
        
        // Init the titles of all the item
//        sliderBar.itemsTitle = @[@"要闻", @"视频", @"上海", @"娱乐", @"体育NBA", @"财经", @"科技", @"社会", @"军事", @"时尚", @"汽车", @"游戏", @"图片", @"股票"];
        sliderBar.itemsTitle = ["要闻", "视频", "上海", "娱乐", "体育NBA", "财经", "科技", "社会", "军事", "时尚", "汽车", "游戏", "图片", "股票"]
        
    //  Set some style to the slideBar
//      sliderBar.itemColor = [UIColor whiteColor];
//      sliderBar.itemSelectedColor = [UIColor orangeColor];
//      sliderBar.sliderColor = [UIColor orangeColor];
        sliderBar.itemColor = UIColor.whiteColor()
        sliderBar.itemSelectedColor = UIColor.orangeColor()
        sliderBar.sliderColor = UIColor.orangeColor()
            
        // Add the callback with the action that any item be selected
//        [sliderBar slideBarItemSelectedCallback:^(NSUInteger idx) {
//        [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:idx inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:NO];
//        }];
//        [self.view addSubview:sliderBar];
//        _slideBar = sliderBar;
        sliderBar.slideBarItemSelectedCallback { (idx:UInt) -> Void in
            self.tableView.scrollToRowAtIndexPath(NSIndexPath(forRow: 2, inSection: 0), atScrollPosition: UITableViewScrollPosition.Top, animated: false)
        }
        self.view.addSubview(sliderBar)
        self.slideBar = sliderBar
        
    }
    
    func setupTableView(){
        // The frame of tableView, be care the width and height property
        //        CGRect frame = CGRectMake(0, 0, CGRectGetMaxY(self.view.frame) - CGRectGetMaxY(self.slideBar.frame), CGRectGetWidth(self.view.frame));
        //        self.tableView = [[UITableView alloc] initWithFrame:frame];
        //        [self.view addSubview:self.tableView];
        let frame:CGRect = CGRectMake(0, 0, CGRectGetMaxY(self.view.frame) - CGRectGetMaxY(self.slideBar.frame), CGRectGetWidth(self.view.frame))
        self.tableView = UITableView(frame:frame)
        self.view.addSubview(self.tableView)
        
        
        // Register the custom cell
        //        UINib *nib = [UINib nibWithNibName:@"TableViewCell" bundle:nil];
        //        [self.tableView registerNib:nib forCellReuseIdentifier:@"ContentCell"];
        let nib:UINib = UINib(nibName:"TableViewCell",bundle:nil)
        self.tableView.registerNib(nib, forCellReuseIdentifier: "ContentCell")
        
        // Set the tableView center in the bottom of view. so after rotating, it shows rightly
        //        self.tableView.center = CGPointMake(CGRectGetWidth(self.view.frame) * 0.5, CGRectGetHeight(self.view.frame) * 0.5 + CGRectGetMaxY(self.slideBar.frame) * 0.5);
        //        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.tableView.center = CGPointMake(CGRectGetWidth(self.view.frame) * 0.5, CGRectGetHeight(self.view.frame) * 0.5 + CGRectGetMaxY(self.slideBar.frame) * 0.5)
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        
        // Rotate the tableView 90 angle anticlockwise
        //        self.tableView.transform = CGAffineTransformMakeRotation(-M_PI_2);
        //        self.tableView.showsVerticalScrollIndicator = NO;
        //        self.tableView.pagingEnabled = YES;
        //        self.tableView.dataSource = self;
        //        self.tableView.delegate = self;
        self.tableView.transform = CGAffineTransformMakeRotation(CGFloat(-M_PI_2))
        self.tableView.showsVerticalScrollIndicator = false
        self.tableView.pagingEnabled = true
        self.tableView.dataSource = self
        self.tableView.delegate = self
    }
    
//    #pragma mark - UITableViewDelegate
//    
//    - (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    // Height retrun the width of screen
//    return CGRectGetWidth(self.view.frame);
//    }
//
    
    
    //pragma mark - UITableViewDataSource
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return self.slideBar.itemsTitle.count
    }
    
    //pragma mark - UIScrollViewDelegate
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
//    NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:scrollView.contentOffset];
      let indexPath:NSIndexPath = self.tableView.indexPathForRowAtPoint(scrollView.contentOffset)!
        
    // Select the relating item when scroll the tableView by paging.
//    [self.slideBar selectSlideBarItemAtIndex:indexPath.row];
      self.slideBar.selectSlideBarItemAtIndex(indexPath.row as! UInt)
    }
    
    //绘制渲染条目控件返回条目
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        //            let initIdentifier = "MyThemeCell"
        //            var cell = tableView.dequeueReusableCellWithIdentifier(initIdentifier) as? TableViewCell
        //            if cell == nil{
        //                tableView.registerNib(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: initIdentifier)
        //                cell = tableView.dequeueReusableCellWithIdentifier(initIdentifier) as? TableViewCell
        //            }
        //
        //            let hud = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        //            hud.labelText = "正在加载中，请稍候"
        //
        //            dispatch_async(dispatch_get_global_queue(0, 0)) { () -> Void in
        //                dispatch_async(dispatch_get_main_queue(), { () -> Void in
        //                    cell?.label.text = ""
        //                    cell?.selectionStyle = UITableViewCellSelectionStyle.None
        //                    hud.hide(true)
        //                    hud.removeFromSuperview()
        //                })
        //            }
        //            return cell!
        
        //            TableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"ContentCell"];
        let cell:TableViewCell = self.tableView.dequeueReusableCellWithIdentifier("ContentCell")! as! TableViewCell;
        
        // Rotate the cell's content 90 angle clockwise to show them rightly
        //            cell.contentView.transform = CGAffineTransformMakeRotation(M_PI_2);
        //            cell.text = self.slideBar.itemsTitle[indexPath.row];
        //            return cell;
        cell.contentView.transform = CGAffineTransformMakeRotation(CGFloat(M_PI_2));
        cell.label.text = self.slideBar.itemsTitle[indexPath.row] as? String;
        return cell;
        
    }
    
    //条目点击事件
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //        let themeDataDetailView = NewsListViewController()
        //        themeDataDetailView.id = self.item[indexPath.row].id
        //        self.navigationController?.pushViewController(themeDataDetailView, animated: true)
    }
    
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        cell.layer.transform = CATransform3DMakeRotation(60, 1, 1, 1)
        UIView.animateWithDuration(0.25, animations: {
            cell.layer.transform = CATransform3DMakeTranslation(1, 1, 1)
        })
    }


}

