//
//  GoToCityViewController.swift
//  Crumbs
//
//  Created by Forrest Zhao on 2/2/17.
//  Copyright © 2017 ForrestApps. All rights reserved.
//

import UIKit
import GooglePlaces

class GoToCityViewController: UIViewController {

    @IBAction func goToCityPicker(_ sender: UIButton) {
        let autocompleteController = GMSAutocompleteViewController()
        autocompleteController.autocompleteFilter = autocompleteByCityFilter()
        autocompleteController.delegate = self
        autocompleteController.title = "Enter a city name"
        present(autocompleteController, animated: true, completion: nil)
    }
    
    func autocompleteByCityFilter() -> GMSAutocompleteFilter {
        let filter = GMSAutocompleteFilter()
        filter.type = .city
        return filter
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension GoToCityViewController: GMSAutocompleteViewControllerDelegate {
    
    // Handle the user's selection.
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        print("Place name: \(place.name)")
        print("Place address: \(place.formattedAddress)")
        print("Place attributions: \(place.attributions)")
        
        dismiss(animated: true, completion: nil)
    }
    
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        // TODO: handle the error.
        print("Error: ", error.localizedDescription)
    }
    
    // User canceled the operation.
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        dismiss(animated: true, completion: nil)
    }
    
    // Turn the network activity indicator on and off again.
    func didRequestAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    func didUpdateAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
    
}
