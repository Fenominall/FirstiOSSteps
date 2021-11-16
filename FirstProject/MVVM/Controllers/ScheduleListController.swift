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
    var events = Event.getTestData()
    
    
    
    private lazy var eventsTableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 30
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "eventCell")
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
            eventsTableView.isEditing = isEditingTableView
            
            navigationItem.leftBarButtonItem?.title = isEditingTableView ? "Done" : "Edit"
        }
    }
    
    
    // MARK: - App LifeCycle
    override func loadView() {
        super.loadView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupCreateEventButton()
//        editingEventButton()
        
        title = "Scheduler"
//        navigationItem.leftBarButtonItem?.tintColor = .white
        navigationController?.navigationBar.prefersLargeTitles = true
        
    }
    
    private func setupCreateEventButton() {
        let action = #selector(handleEventCreation)
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: action)
        navigationItem.rightBarButtonItem?.tintColor = .black
        
    }
    
    @objc private func handleEventCreation() {
        coordinator?.eventOccurred(with: .createEventButtonTapped)
    }
    
//    private func editingEventButton() {
//        let action = #selector(handleEventEditing)
//        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: action)
//        navigationItem.leftBarButtonItem?.tintColor = .black
//    }
//
//    @objc private func handleEventEditing() {
//        isEditingTableView.toggle() // changes a boolean value
//    }
    
    
    
    
}

extension ScheduleListController {
    
    private func setupTableView() {
        view.backgroundColor = .darkGray
        
        view.addSubview(eventsTableView)
        eventsTableView.snp.makeConstraints {
//            $0.top.leadingMargin.trailingMargin.equalToSuperview()
            $0.edges.margins.equalToSuperview()
            $0.bottomMargin.equalToSuperview()
        }
    }
}

extension ScheduleListController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}

extension ScheduleListController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "eventCell", for: indexPath)
        cell = UITableViewCell(style: UITableViewCell.CellStyle.subtitle, reuseIdentifier: "eventCell")
        cell.contentView.backgroundColor = .clear
        cell.textLabel?.textColor
        = .black
        let event = events[indexPath.row]
        cell.detailTextLabel?.textColor = .black
        cell.textLabel?.text = event.name
        cell.detailTextLabel?.text = dateFormatter.string(from: event.date)
        return cell
    }
    
    
    // MARK: - deleting rows in a table view
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case .insert:
            // only gets called if "insertion control" exist and gets selected
            print("inserting....")
        case .delete:
            print("deleting..")
            // 1. remove item for the data model e.g events
            events.remove(at: indexPath.row) // remove event from events array
        
            tableView.deleteRows(at: [indexPath], with: .automatic)
        default:
            print("...")
        }
    }
    
    // MARK: - Reordering views in a tableView
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let eventToMove = events[sourceIndexPath.row] // saved an event being moved
        events.remove(at: sourceIndexPath.row)
        events.insert(eventToMove, at: destinationIndexPath.row)
    }
    
    
    
}
