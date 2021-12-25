
/// Observable可监听序列
///  Observable是用于描述元素异步产生的序列
///

/// todo: disposeBag作用
/// todo: Disposables是个啥

import UIKit
import RxSwift

class ObservableViewController: UIViewController {

    let disposeBag = DisposeBag()
    
    lazy var obervable: Observable<Int> = {
        let ob = Observable<Int>.create { obser -> Disposable in
            if 1 != 0 {
                obser.onNext(1)
                obser.onNext(2)
                obser.onNext(3)
                obser.onCompleted()
            }
//            else {
//                obser.onError(NSError())
//            }
            return Disposables.create()
        }
        return ob
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        obervable.subscribe { number in
            print(number)
        } onCompleted: {
            print("completed")
        } onDisposed: {
            print("disposed")
        }.disposed(by: disposeBag)

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
