//
//  GitHubWebViewController.swift
//  FirstProject
//
//  Created by Fenominall on 13.08.2021.
//

import Foundation
import UIKit
import WebKit

class GitHubWebUIViewController: UIViewController {
    
    private lazy var gitHubWebView: WKWebView = {
        let preferences = WKWebpagePreferences()
        preferences.allowsContentJavaScript = true
        let configuration = WKWebViewConfiguration()
        configuration.defaultWebpagePreferences = preferences
        let gitHubWebView = WKWebView(frame: .zero, configuration: configuration)
        return gitHubWebView
    }()
    
    private let url: URL
    
    init(url: URL, title: String) {
        self.url = url
        super.init(nibName: nil, bundle: nil)
        self.title = title
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        gitHubWebView.frame = view.bounds
    }
    
    private func gitWebViewSEtUp() {
        view.backgroundColor = .systemBackground
        view.addSubview(gitHubWebView)
        gitHubWebView.load(URLRequest(url: url))
    }
    
    private func configureGitHubWebViewButtons() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(didTopeDoneButton))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(didTapRefreshButton))
    }
    
    @objc func didTopeDoneButton() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func didTapRefreshButton() {
        gitHubWebView.load(URLRequest(url: url))
    }
    
}
