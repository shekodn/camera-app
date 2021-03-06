//
//  ReportsViewController.swift
//  camera app
//
//  Created by Sergio Díaz Navarro on 2/3/17.
//  Copyright © 2017 Sergio Díaz Navarro. All rights reserved.
//

import UIKit

class ReportsViewController: UITableViewController {

    @IBOutlet var tvReports: UITableView!
    
    var reports = [Report]()
    
    func reportSeeds(){
        
        let temporal = Report()
        
        for report in 1...20{
            
            temporal.id = report
            temporal.desc = "Quisque sit amet egestas lectus. Maecenas convallis dui vitae tempus porta. Curabitur id nisi vulputate, tristique ligula non, maximus lectus. Aenean non fermentum nisi, ac mollis tellus. In hac habitasse platea dictumst. Sed sit amet elit pretium urna sollicitudin eleifend. Morbi vel lorem nunc. In eleifend urna quis est accumsan porta eu in magna. Donec sit amet quam non nisl aliquet sagittis."
            reports.append(temporal)
        }
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        
        reportSeeds()
    }
    
    // Mark: - Segue
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let indexPath = tvReports.indexPathForSelectedRow
        let viewSpecificReport = segue.destination as! SpecificReportVC
        
        print("INDEX = \(indexPath!.row)")
        
        viewSpecificReport.sReportName = ("\(reports[indexPath!.row].name!) #\((indexPath!.row))")
        viewSpecificReport.sReportDescription = reports[indexPath!.row].desc!
    }


    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return reports.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        cell.textLabel?.text = reports[indexPath.row].name!
        cell.detailTextLabel?.text = reports[indexPath.row].desc!

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
