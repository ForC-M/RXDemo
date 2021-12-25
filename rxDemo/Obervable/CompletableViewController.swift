
/// 只可以发出完成或失败

import UIKit
import RxSwift

class CompletableViewController: UIViewController {

    let displose = DisposeBag()
    lazy var compltable: Completable = {
        let com = Completable.create { com -> Disposable in
         
            com(.completed)
//            com(.error(NSError()))
            
            return Disposables.create()
        }
        return com
    }()
    
    
    lazy var testView: UIView = {
        let view = UIView()
        view.backgroundColor = .red
        view.frame = CGRect(x: 100, y: 100, width: 100, height: 100)
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "single"
        view.backgroundColor = UIColor.white
        
    
        view.addSubview(testView)
      
            
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        compltable.subscribe {
            print("completion")
        } onError: { error in
            print("error")
        }.disposed(by: displose)

    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
