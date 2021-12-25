//
//  maybe 仅可产生一个正确/完成/错误信号。多发无效

import UIKit
import RxSwift


class MaybeViewController: UIViewController {

    let disploseBag = DisposeBag()
    
    lazy var maybe: Maybe<String> = {
        let mb = Maybe<String>.create { observale in
            observale(.success("1"))
            observale(.completed)/// 失效
            return Disposables.create()
        }
        return mb
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
        maybe.subscribe { xx in
            print(xx)
        } onError: { Error in
            
        } onCompleted: {
            
        }.disposed(by: disploseBag)

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
