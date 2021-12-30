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
    
    private lazy var eventsTableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 44
        tableView.tableFooterView = UIView()
        tableView.backgroundColor = .clear
        tableView.register(ScheduleListViewCell.self, forCellReuseIdentifier: ScheduleListViewCell.cellID)
        return tableView
    }()
    
    lazy var dateFormatter:  DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, MMM d, yyyy, hh:mm a"
        formatter.timeZone = .current
        return formatter
    }()
    
    var isEditingTableView = false {
        didSet {
            // property observer
            // toggle editing mode of tableview
            eventsTableView.isEditing = isEditingTableView
            // toggle bar button item`s title between "Edit" and "Done"
            navigationItem.leftBarButtonItem?.title = isEditingTableView ? "Done" : "Edit"
        }
    }
    
    // MARK: - App LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        loadEvents()
        setupTableView()
        setupNavigation(
        )
        
    }
    
    // MARK: - Selectors
    
    @objc private func handleEventCreation() {
        // create an instance of CreateEventController
        let createEventController = CreateEventController()
        // adopting delegate as self
        createEventController.addEventDelegate = self
        navigationController?.present(createEventController, animated: true, completion: nil)
    }
    
    @objc private func handleEventEditing() {
        isEditingTableView.toggle() // changes a boolean value
    }
    
    
    // MARK: - Helpers
    // navigation bar appearance
    private func setupNavigation() {
        title = "Scheduler"
        navigationItem.leftBarButtonItem?.tintColor = .white
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.backgroundColor = .clear
        // navigation bar button items
        let editEventBarButtonItem = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(handleEventEditing))
        editEventBarButtonItem.tintColor = .white
        let addEventBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(handleEventCreation))
        addEventBarButtonItem.tintColor = .white
        navigationItem.rightBarButtonItems = [addEventBarButtonItem, editEventBarButtonItem]
    }
    
    
    private func loadEvents() {
        do {
            events = try EventPersistenceHelper.loadEvents()
        } catch {
            print("error loading events: \(error)")
        }
    }
    
    private func deleteEvent(at indexPath: IndexPath) {
        do {
            try EventPersistenceHelper.delete(event: indexPath.row)
        } catch {
            print("error deleting event: \(error)")
        }
    }

}

// MARK: Configure auto-layout of UIElements
extension ScheduleListController {
    
    private func setupTableView() {
        view.backgroundColor = .black
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
        return events.count
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
        let event = events[indexPath.row]
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
            self.eventsTableView.reloadData()
        }
    }
    
}
