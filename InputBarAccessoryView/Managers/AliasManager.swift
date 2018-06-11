//
//  AliasManager.swift
//  Alamofire
//
//  Created by superadmin on 6/7/18.
//

import Foundation

open class AliasManager: NSObject, InputManager {
    // MARK: - Properties [Public]
    
    /// A protocol that passes data to the `AutocompleteManager`
    open weak var dataSource: AliasManagerDataSource?
    
    /// A protocol that more precisely defines `AutocompleteManager` logic
    open weak var delegate: AliasManagerDelegate?
    
    /// The `AutocompleteTableView` that renders available autocompletes for the `currentSession`
    open lazy var tableView: AutocompleteTableView = { [weak self] in
        let tableView = AutocompleteTableView()
        tableView.register(AutocompleteCell.self, forCellReuseIdentifier: AutocompleteCell.reuseIdentifier)
        tableView.separatorStyle = .none
        tableView.backgroundColor = .white
        tableView.rowHeight = 44
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
        }()
    /// The default text attributes
    open var defaultTextAttributes: [NSAttributedStringKey: Any] =
        [.font: UIFont.preferredFont(forTextStyle: .body), .foregroundColor: UIColor.black]
    private var currentAutocompleteOptions: [AutocompleteCompletion] = []
    public func loadAutoCompletions() {
        dataSource?.autocompleteSourceFor(self) { (autocompletions) in
            DispatchQueue.main.async {
                self.currentAutocompleteOptions = autocompletions
                self.tableView.reloadData()
                
                // Resize the table to be fit properly in an `InputStackView`
                self.tableView.invalidateIntrinsicContentSize()
                
                // Layout the table's superview
                self.tableView.superview?.layoutIfNeeded()
            }
        }
    }
    open func layoutIfNeeded() {
        loadAutoCompletions()
    }
    
}

extension AliasManager: UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - UITableViewDataSource
    
    final public func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    final public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentAutocompleteOptions.count
    }
    
    final public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = dataSource?.aliasManager(self, tableView: tableView, cellForRowAt: indexPath) ?? UITableViewCell()
        cell.textLabel?.text = currentAutocompleteOptions[indexPath.row].displayText
        return cell
    }
    
    // MARK: - UITableViewDelegate
    
    final public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let text = currentAutocompleteOptions[indexPath.row]
        self.delegate?.aliasManager(self, tableView: tableView, didSelectRowAt: indexPath)
        print(text)
        
    }
    
}
extension AliasManager {
    /// Should reload the state if the `InputManager`
    open func reloadData() {
        delegate?.aliasManager(self, shouldBecomeVisible: true)
    }
    
    /// Should remove any content that the `InputManager` is managing
    open func invalidate() {
        delegate?.aliasManager(self, shouldBecomeVisible: false)
    }
    open func handleInput(of object: AnyObject) {
        
    }
}
