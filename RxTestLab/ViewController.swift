//
//  ViewController.swift
//  RxTestLab
//
//  Created by Behrad Kazemi on 5/12/19.
//  Copyright © 2019 Behrad Kazemi. All rights reserved.
//

import UIKit
import Starscream
import RxSwift
import RxStarscream
class ViewController: UIViewController {
    let disposeBag = DisposeBag()
    var socket: WebSocket!
    @IBOutlet weak var textField: UITextField!

    @IBOutlet weak var fname: UILabel!
    @IBOutlet weak var lname: UILabel!
    @IBOutlet weak var sname: UILabel!
    @IBOutlet weak var tname: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func emitB(_ sender: Any) {
        if socket != nil && socket.isConnected {
            let modelBJson = """
{"id": 12,"name": "salsaL"}
"""
            
            socket.write(string: modelBJson)
        }
    }
    @IBAction func emit(_ sender: Any) {
        if socket != nil && socket.isConnected {
            let modelAJson = """
{"fname": "salsaF","lname": "salsaL","sname": "salsaS","tname": "salsaT"}
"""
            socket.write(string: modelAJson)
        }
    }
    @IBAction func disconnect(_ sender: Any) {
        print("Disconnected")
        socket.disconnect()
    }
    @IBAction func actionButoon(_ sender: Any) {
        print("Connected")
        socket = WebSocket(url: URL(string: textField.text!)!)
        socket.connect()
        socket.rx.text.subscribe(onNext: { (mesage) in
            print("MESSAGE:\(mesage)")
        }).disposed(by: disposeBag)
        let mayA = socket.rx.text.flatMapLatest { (mesage) -> Maybe<ModelA> in
            
            let result = Maybe<ModelA>.create { maybe in
                do{
                    let object = try JSONDecoder().decode(ModelA.self, from: mesage.data(using: .utf8)!)
                    maybe(.success(object))
                } catch {
                    maybe(.completed)
                }
                
                
                return Disposables.create {}
            }
            return result
        }
        let mayB = socket.rx.text.flatMapLatest { (mesage) -> Maybe<ModelB> in
            
            let result = Maybe<ModelB>.create { maybe in
                do{
                    let object = try JSONDecoder().decode(ModelB.self, from: mesage.data(using: .utf8)!)
                    maybe(.success(object))
                } catch {
                    maybe(.completed)
                }
                
                maybe(.completed)
                return Disposables.create {}
            }
            return result
        }
        
        mayA.subscribe(onNext: { [unowned self](model) in
            self.setup(model: model)
        }).disposed(by: disposeBag)
        mayB.subscribe(onNext: { [unowned self](model) in
            self.setup(model: model)
        }).disposed(by: disposeBag)
        

    }
    
    func setup(model: ModelA) {
        print("ModelA")
        fname.text = model.fname
        lname.text = model.lname
        sname.text = model.sname
        tname.text = model.tname
    }
    
    func setup(model: ModelB) {
        print("ModelB")
        fname.text = model.name
        lname.text = "\(model.id)"
        sname.text = ""
        tname.text = ""
    }
}

