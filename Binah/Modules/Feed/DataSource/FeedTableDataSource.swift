//
//  FeedTableDataSource.swift
//  Binah
//
//  Created by Adar Tzeiri on 19/01/2021.
//

import UIKit

class FeedTableDataSource: GenericDataSource<FeedCellViewModel> ,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: FeedTableViewCell.cellID) as? FeedTableViewCell {
            let viewModel = data.value[indexPath.row]
            cell.feedCellViewModel = viewModel
            cell.selectionStyle = .none
            return cell
        } else {
            return UITableViewCell()
        }
    }
}
