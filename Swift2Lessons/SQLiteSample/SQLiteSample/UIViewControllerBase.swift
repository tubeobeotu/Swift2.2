//
//  UIViewControllerBase.swift
//  SQLiteSample
//
//  Created by Tuuu on 7/20/16.
//  Copyright © 2016 TuNguyen. All rights reserved.
//

import UIKit

class UIViewControllerBase: UIViewController{
    
    @IBOutlet weak var txt_Search: UITextField!
    @IBOutlet weak var btn_Title: UIButton!
    var labels = [Label]()
    var listView = ListView(frame: CGRectMake(0, 0, 200, 100), style: .Plain)
    let dataBase = DataBase.sharedInstance
    var items = [NSDictionary]()
    var type = Type.SONGS
    var nameArtists = [String]()
    var currentIndexOption = 1
    //#MARK: Override view
    override func viewDidLoad() {
        super.viewDidLoad()
        self.edgesForExtendedLayout = .None
        hiddenListViewAndSearch()
        txt_Search.placeholder = "Enter name here"
        self.btn_Title.backgroundColor = UIColor(colorLiteralRed: 39/255, green: 42/277, blue: 49/277, alpha: 1.0)
        self.view.backgroundColor = UIColor(colorLiteralRed: 24/255, green: 27/277, blue: 34/277, alpha: 1.0)
        let textAttribute = [NSForegroundColorAttributeName: UIColor.whiteColor(), NSFontAttributeName:UIFont(name: "Helvetica", size: 26)!]
        btn_Title.titleLabel?.font = UIFont(name: "Helvetica", size: 22)
        self.tabBarController!.navigationItem.title = "My Music"
        self.navigationController?.navigationBar.titleTextAttributes = textAttribute
        self.view.backgroundColor = UIColor(colorLiteralRed: 24/255, green: 27/255, blue: 34/255, alpha: 1.0)
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if (listView.frame.origin.x == 0)
        {
            addListOptions()
        }
    }
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        hiddenListViewAndSearch()
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        setActionForRightBarButton()
        selectFirstItem()
        setupListView()
        hiddenListViewAndSearch()
    }
    func setupListView()
    {
        listView.items = labels
        listView.type = Type.PLAYLIST
        loadTitle(currentIndexOption)
    }
    //#MARK: Process Interface
    func setStateForListView()
    {
        listView.hidden = !listView.hidden
    }

    func loadTitle(index: Int)
    {
        btn_Title.setTitle(getTitleWithID(index), forState: .Normal)
        self.tabBarController!.navigationItem.rightBarButtonItem!.enabled = true
    }
    func getTitleWithID(index: Int) -> String?
    {
        for label in labels
        {
            if (label.id == index)
            {
                return label.displayName
            }
        }
        return nil
    }
    func addListOptions()
    {
        listView = ListView(frame: CGRectMake(btn_Title.center.x - 100, btn_Title.frame.origin.y + btn_Title.frame.size.height, 200, 100), style: .Plain)
//        listView.delegateSelectItem = self
        self.view.addSubview(listView)
    }
    func setActionForRightBarButton()
    {
        self.tabBarController!.navigationItem.rightBarButtonItem?.target = self
        self.tabBarController!.navigationItem.rightBarButtonItem?.action = #selector(checkHiddenSearch)
    }
    func checkHiddenSearch()
    {
        swapStateSearchWithLabel(true)
        if txt_Search.hidden == true {
            UIView.transitionWithView(self.txt_Search, duration: 0.5, options: UIViewAnimationOptions.TransitionCurlDown, animations: nil, completion: nil)
            self.txt_Search.becomeFirstResponder() //Show keyboard
            self.txt_Search.hidden = false
        } else {
            UIView.transitionWithView(self.txt_Search, duration: 0.5, options: UIViewAnimationOptions.TransitionFlipFromLeft, animations: nil, completion: nil)
            self.txt_Search.resignFirstResponder() // End edit text
            self.txt_Search.hidden = true
        }
    }
    func swapStateSearchWithLabel(isSearch: Bool)
    {
        if (isSearch == true)
        {
            btn_Title.enabled = !txt_Search.hidden
            
        }
        else
        {
            self.tabBarController!.navigationItem.rightBarButtonItem!.enabled = !self.tabBarController!.navigationItem.rightBarButtonItem!.enabled
        }
    }
    func hiddenListViewAndSearch()
    {
        listView.hidden = true
        txt_Search.hidden = true
    }
    func selectFirstItem()
    {
        let indexPath = NSIndexPath(forRow: currentIndexOption-1, inSection: 0)
        listView.selectRowAtIndexPath(indexPath, animated: false, scrollPosition: .None)
//        listView.tableView(listView, didSelectRowAtIndexPath: indexPath)
    }
    //# MARK: Action
    
    @IBAction func action_Label(sender: UIButton)
    {
        listView.hidden = !listView.hidden
        swapStateSearchWithLabel(false)
    }
    
}
