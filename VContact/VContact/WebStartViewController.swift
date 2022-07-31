//
//  WebStartViewController.swift
//  VContact
//
//  Created by Wally on 15.06.2022.
//

import UIKit
import WebKit
import Alamofire

class WebStartViewController: UIViewController, WKNavigationDelegate {

    @IBOutlet weak var webView: WKWebView! {
        didSet{
            webView.navigationDelegate = self
        }
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        guard let url = navigationResponse.response.url,
              url.path == "/blank.html",
              let fragment = url.fragment
        else {
            decisionHandler(.allow)
            return
        }

        let params = fragment
            .components(separatedBy: "&")
            .map { $0.components(separatedBy: "=") }
            .reduce([String: String]()) { result, param in
                var dict = result
                let key = param[0]
                let value = param[1]
                dict[key] = value
                return dict
            }
        
            let token = params["access_token"]
        print("ТОКЕН РАВЕН: \(token)")
        Session.user.token = token!
       
            decisionHandler(.cancel)
        
//        myRequest.quertyURLSession(method: .getGroups)
//        myRequest.quertyURLSession(method: .photo)
//        myRequest.getAlamofireResponse(method: .getGroups)
        
        
        performSegue(withIdentifier: "segueAfterRegistration", sender: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configerWebView()
        
    }
    
    func configerWebView() {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "oauth.vk.com"
        urlComponents.path = "/authorize"
        urlComponents.queryItems = [
//  индентификатор приложения.
            URLQueryItem(name: "client_id", value: Session.user.userID),
//  указываем тип отображения страницы авторизации:
//            page - авторизация в отдельном окне.
//            popup - авторизация в всплывающем окне.
//            mobile - авторизация для мобильных устройств.
        URLQueryItem(name: "display", value: "mobile"),
//  адрес, на который будет переадресован пользователь после прохождения авторизаци.
        URLQueryItem(name: "redirect_uri", value:
        "https://oauth.vk.com/blank.html"),
//  битовая маска настроек доступа приложения, которые необходимо проверить при авторизации пользователя и запросить отсутствующие.
        URLQueryItem(name: "scope", value: "270342"),
//  тип ответа, который необходимо получить.
        URLQueryItem(name: "response_type", value: "token"),
        URLQueryItem(name: "v", value: "5.68")
        ]
        let request = URLRequest(url: urlComponents.url!)
        webView.load(request)
    }
    
}
