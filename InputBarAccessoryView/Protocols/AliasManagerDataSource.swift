//
//  AliasManagerDataSource.swift
//  Alamofire
//
//  Created by superadmin on 6/7/18.
//

import Foundation

public protocol AliasManagerDataSource: class {
    
    func autocompleteSourceFor(_ manager: AliasManager, completion: @escaping AutoCompletionHandler)
    
    func aliasManager(_ manager: AliasManager, tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell

}
public extension AutocompleteManagerDataSource {
    
    func aliasManager(_ manager: AliasManager, tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AutocompleteCell.reuseIdentifier, for: indexPath) as? AutocompleteCell else {
            fatalError("AutocompleteCell is not registered")
        }
        cell.backgroundColor = .white
        cell.separatorLine.isHidden = tableView.numberOfRows(inSection: indexPath.section) - 1 == indexPath.row
        return cell
        
    }
    
}
