//
//  WebUIViewController.swift
//  FirstProject
//
//  Created by Fenominall on 04.08.2021.
//

import UIKit
import WebKit

class SourceCodeWebUIViewController: UIViewController, Coordinating {
    
    // MARK: - Properties
    var coordinator: Coordinator?

    private lazy var webView: WKWebView = {
        let preferences = WKWebpagePreferences()
        preferences.allowsContentJavaScript = true
        let configuration = WKWebViewConfiguration()
        configuration.defaultWebpagePreferences = preferences
        let webView = WKWebView(frame: .zero, configuration: configuration)
        webView.backgroundColor = .darkWeb
        return webView
    }()
    
    private let url: URL
    
    // MARK: - Lifecycle
    init(url: URL, title: String) {
        self.url = url
        super.init(nibName: nil, bundle: nil)
        self.title = title
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        
        webViewSetUp()
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        configureActions()
        navigationController?.navigationBar.barStyle = .black
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        webView.frame = view.bounds
    }
    
    // MARK: - Selectors
    
    private func configureActions() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(didTapDoneButton))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(didTapRefreshButton))
    }
    
    @objc private func didTapDoneButton() {
        coordinator?.eventOccurred(with: .finishedViewingSourceCode)
    }
    
    @objc private func didTapRefreshButton() {
        webView.load(URLRequest(url: url))
    }
    
    
    // MARK: - Helpers
    private func webViewSetUp() {
        view.backgroundColor = .darkWeb
        view.addSubview(webView)
        webView.load(URLRequest(url: url))
    }


}
