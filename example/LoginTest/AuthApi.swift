//
//  AuthApi.swift
//  Spaggiari AuthApi4 for Swift v0.1
//
//  Created by Vittorio Grasso on 23/09/17.
//  Copyright © 2017 Vittorio Grasso. All rights reserved.
//

import Foundation

class AuthApi {
    private let apiURL = "https://web.spaggiari.eu/auth/app/default/AuthApi4.php"
    
    public var username: String?
    public var password: String?
    public var userInfo: SpaggiariAnswer?
    
    // TODO: switch to private
    public var returnStringAsync: String?
    
    private enum AuthApiActions: String {
        case Login = "aLoginPwd"
    }
    
    public struct SpaggiariAnswer: Codable {
        let time: String
        struct data: Codable {  
            struct auth: Codable {
                let verified: Bool
                let loggedIn: Bool
                let actionRequested: Bool
                struct hints: Codable {
                    
                }
                struct errors: Codable {
                    
                }
                struct accountInfo: Codable {
                    let type: String
                    let id: Int
                    let cognome: String
                    let nome: String
                }
                struct redirects: Codable {
                    
                }
                let aMode: String
                let mMode: String
                struct errCode {
                    
                }
            }
            let pfolio: Bool
        }
        struct error: Codable {
            
        }
        struct api: Codable {
            let env: String
            struct AuthSpa {
                let version: String
            }
        }
    }
    
    public func loadUserInfo() {
        DispatchQueue.global(qos: .userInitiated).async {
            self.apiRequest(action: AuthApiActions.Login, postDataString: ("uid="+self.username!+"&pwd="+self.password!))
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
                //let jsonDecoder = JSONDecoder()
                //self.userInfo = try! jsonDecoder.decode(SpaggiariAnswer.self, from: (self.returnStringAsync?.data(using: .utf8))!)
            }
        }
    }
    
    private func apiRequest(action: AuthApiActions, postDataString: String) {
        httpPostRequestAsync(url: URL(string: apiURL + "?a=" + action.rawValue)!, postDataString: postDataString)
    }
    
    private func httpPostRequestAsync(url: URL, postDataString: String) {
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = postDataString.data(using: .utf8)
        let task = URLSession.shared.dataTask(with: request) { data, responde, error in
            self.returnStringAsync = String(data: data!, encoding: .utf8)!
        }
        task.resume();
    }
}
