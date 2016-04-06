//
//  StatsViewController.swift
//  Shake That Catan
//
//  Created by Mindaugas Jucius on 24/02/16.
//  Copyright © 2016 mindawg. All rights reserved.
//

import UIKit

class StatsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var backgroundColor: UIColor?
    var resultsGrouped: [Int] = []
    var labelColor: UIColor?
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var statsLabel: UIButton!
    @IBOutlet weak var valueLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = backgroundColor
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = backgroundColor
        tableView.tableFooterView = UIView(frame: CGRectZero)
        statsLabel.setTitleColor(labelColor, forState: .Normal)
        statsLabel.setTitleColor(labelColor, forState: .Highlighted)
        countLabel.textColor = labelColor
        valueLabel.textColor = labelColor
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func closeButtonTouched(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return resultsGrouped.count
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("diceCell", forIndexPath: indexPath)
        cell.textLabel?.text = String(indexPath.row)
        cell.textLabel?.textColor = labelColor
        cell.detailTextLabel?.text = String(resultsGrouped[indexPath.row])
        cell.detailTextLabel?.textColor = labelColor
        cell.backgroundColor = view.backgroundColor
        return cell
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
