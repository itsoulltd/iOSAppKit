//
//  ViewController.swift
//  iOSAppKit
//
//  Created by Towhid Islam on 5/2/18.
//  Copyright © 2018 Towhid Islam. All rights reserved.
//

import UIKit
import NGAppKit
import FileSystemSDK

class ViewController: UIViewController {

    @IBOutlet weak var counterLabel: UILabel!
    
    fileprivate var router = CustomRouter()
    
    fileprivate var timer: Timer?
    fileprivate var counter = 0 {
        didSet{
            self.counterLabel.alpha = 0.0
            UIView.animate(withDuration: 0.30, animations: {
                self.counterLabel.alpha = 1.0
                self.counterLabel.text = "\(self.counter)"
            })
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //
        timer = Timer.scheduledTimer(withTimeInterval: 0.60, repeats: true, block: { (timer) in
            DispatchQueue.main.async {
                self.counter += 1
                if self.counter == 5 && self.timer!.isValid{
                    self.timer?.invalidate()
                    self.timer = nil
                    self.counter = 0
                    //Router
                    guard (AppStoryboard.load("MyBoard")) != nil else {return}
                    if let info = RouteTo(info: ["storyboard":"MyBoard"]){
                        info.viewControllerID = AppStoryboard.resolveClassName(TestViewController.self)
                        self.router.route(from: self, withInfo: info)
                    }
                }
            }
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    private var cryptoFile: CryptoFile?
    private func testCryptoFile(){
        let docFolder = Folder(name: "CryptoBooks", searchDirectoryType: FileManager.SearchPathDirectory.documentDirectory)
        let writePath = (docFolder.path())?.appendingPathComponent("crypto.file")
        
        let readUrl = Bundle.main.url(forResource: "books", withExtension: "pdf")
        let readFile = File(url: readUrl!)
        
        cryptoFile = CryptoFile(url: URL(fileURLWithPath: writePath!))
        cryptoFile?.encrypt(from: readFile, bufferSize: 2048, password: "123456", progress: self, completionHandler: { (done) in
            print("Successfull \(done)")
        })
    }

}

extension ViewController : IFileProgress{
    func readWriteProgress(_ progress: Double) {
        print("progress \(progress)")
    }
}

