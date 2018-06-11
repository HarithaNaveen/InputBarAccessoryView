//
//  AliasManagerDelegate.swift
//  Alamofire
//
//  Created by superadmin on 6/7/18.
//

import UIKit

public protocol AliasManagerDelegate: class {
    
    func aliasManager(_ manager: AliasManager, shouldBecomeVisible: Bool)
    func aliasManager(_ manager: AliasManager, tableView: UITableView, didSelectRowAt indexPath: IndexPath)
}
