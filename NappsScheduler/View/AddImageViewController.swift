//
//  AddImageViewController.swift
//  NappsScheduler
//
//  Created by iem on 04/06/2018.
//  Copyright © 2018 Thomas Chaboud. All rights reserved.
//

import UIKit

class AddImageViewController: UITableViewController {

    var delegate: AddImageViewControllerDelegate!
    var listIcon: Array<IconAsset> = [IconAsset.bath, IconAsset.beer, IconAsset.brush_teeth, IconAsset.eat, IconAsset.sleep, IconAsset.work, IconAsset.coconut, IconAsset.donkey, IconAsset.lovni, IconAsset.music, IconAsset.sport]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listIcon.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "iconCell", for: indexPath)
        cell.textLabel?.text = listIcon[indexPath.row].rawValue
        cell.imageView?.image = listIcon[indexPath.row].image
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var icon = listIcon[indexPath.row]
        delegate.didSelectNewIcon(newIcon:icon)
        self.navigationController?.popViewController(animated: true)
    }

}

protocol AddImageViewControllerDelegate : class{
    func didSelectNewIcon(newIcon: IconAsset)
}
