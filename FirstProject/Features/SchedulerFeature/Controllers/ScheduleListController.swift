//
//  SchedulerViewController.swift
//  FirstProject
//
//  Created by Fenominall on 11/15/21.
//

import Foundation
import UIKit
import SnapKit

class ScheduleListController: UIViewController, Coordinating {
    
    // MARK: - Properties
    var coordinator: Coordinator?
    // data - an array of events
    var events: [Event] = []
    var filteredEvents: [Event] = []
    // if search mode is activated,
    // users array will be switched to a new filtered users array
    private var  inSearchMode: Bool {
        return searchController.isActive &&
        !searchController.searchBar.text!.isEmpty
    }
    
    private let searchController = UISearchController(searchResultsController: nil)
    
    private lazy var eventsTableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 44
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
        tableView.backgroundColor = .darkWeb
        tableView.register(ScheduleListViewCell.self, forCellReuseIdentifier: ScheduleListViewCell.cellID)
        return tableView
    }()
    
    lazy var dateFormatter:  DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, MMM d, yyyy, hh:mm a"
        formatter.timeZone = .current
        return formatter
    }()
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpEditButton()
        loadEvents()
        setupTableView()
        setupNavigation()
        configureSearchController()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadEvents()
        setUpEditButton()
    }
    // MARK: - Selectors
    @objc private func handleEventCreation() {
        // create an instance of CreateEventController
        let createEventController = CreateEventController()
        // adopting delegate as self
        createEventController.addEventDelegate = self
        navigationController?.present(createEventController, animated: true, completion: nil)
    }

    // MARK: - Helpers
    
    private func setUpEditButton() {
        let addEventBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(handleEventCreation))
        
        if !events.isEmpty || !filteredEvents.isEmpty {
            navigationItem.rightBarButtonItems = [addEventBarButtonItem, editButtonItem]
        } else {
            setEditing(false, animated: true)
            navigationItem.rightBarButtonItems = [addEventBarButtonItem]
        }
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        eventsTableView.isEditing = editing
    }
    
    // navigation bar appearance
    private func setupNavigation() {
        title = "Scheduler"
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.backgroundColor = .clear
    }
    
    private func configureSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search for an event"
        navigationItem.searchController = searchController
        definesPresentationContext = false
    }
    
    
    private func loadEvents() {
        do {
            events = try EventPersistenceHelper.loadEvents()
        } catch {
            print("DEBUG: Error loading events: \(error)")
        }
    }
    
    private func deleteEvent(at indexPath: IndexPath) {
        do {
            try EventPersistenceHelper.delete(event: indexPath.row)
        } catch {
            print("DEBUG: Error deleting event: \(error)")
        }
    }

}

// MARK: Configure auto-layout of UIElements
extension ScheduleListController {
    
    private func setupTableView() {
        view.addSubview(eventsTableView)
        eventsTableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

// MARK: - UITableViewDelegate
extension ScheduleListController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

//MARK: - UITableViewDataSource
extension ScheduleListController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return inSearchMode ? filteredEvents.count : events.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // dequeueReusableCell:
        // recycles a cell if it exists
        // if the cell does not exists a new cell is created
        let cell = tableView.dequeueReusableCell(withIdentifier: ScheduleListViewCell.cellID,
                                                 for: indexPath) as! ScheduleListViewCell
        // UISettings
        cell.configure()
        // get an object at the current indexPath from a flatArray
        let event = inSearchMode ? filteredEvents[indexPath.row] : events[indexPath.row]
        cell.eventTitleLabel.text = event.name
        cell.eventDetailTextLabel.text = dateFormatter.string(from: event.date)
        return cell
    }
    
    
    // MARK:- deleting rows in a table view
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case .insert:
            // only gets called if "insertion control" exist and gets selected
            print("inserting....")
        case .delete:
            print("deleting..")
            // 1. remove item for the data model e.g events
            events.remove(at: indexPath.row) // remove event from events array
            deleteEvent(at: indexPath)
            // 2. update the table view
            tableView.deleteRows(at: [indexPath], with: .automatic)
            DispatchQueue.main.async {
                self.eventsTableView.reloadData()
            }
        default:
            print("...")
        }
    }
    
    // MARK:- Reordering views in a tableView
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let eventToMove = events[sourceIndexPath.row] // saved an event being moved
        events.remove(at: sourceIndexPath.row)
        events.insert(eventToMove, at: destinationIndexPath.row)
        // re-save array in documents directory
        EventPersistenceHelper.reorderingEvents(events: events)
        do {
            //        EventPersistenceHelper.loadEvents()
            events = try EventPersistenceHelper.loadEvents()
            eventsTableView.reloadData()
        } catch {
            print("error loading events: \(error)")
        }
        
    }
}

extension ScheduleListController: AddEventDelegate {
    func eventCreated(didCreated event: Event) {
        
        self.dismiss(animated: true) {
            do {
                try EventPersistenceHelper.create(event: event)
            } catch {
                print("error saving event with error: \(error)")
            }
            // insert new event into our events array
            self.events.append(event)
            
            // create an indexPath to be inserted into the tableview
            let indexPath = IndexPath(row: self.events.count - 1, section: 0)
            // use indexPath to insert into table view
            self.eventsTableView.insertRows(at: [indexPath], with: .automatic)
            DispatchQueue.main.async {
                self.eventsTableView.reloadData()
            }
        }
    }
    
}

extension ScheduleListController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        // uppercasing inputed text into searchBar placeholder
        guard let searchText = searchController.searchBar.text?.uppercased() else { return }
        // filtering events by entered searchText to show all the matching results
        filteredEvents = events.filter( {$0.name.contains(searchText)} )
        eventsTableView.reloadData()
    }
}
