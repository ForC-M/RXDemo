// observe 观察者
// 用来监听事件，并作出响应
// 常见的观察者一共有两个 Anyobserve & binder

import UIKit
import RxSwift
import RxCocoa

class Observer: UIViewController {

    let disposeBag = DisposeBag()
    
    let target_label = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        target_label.frame = CGRect(x: 100, y: 100, width: 100, height: 100)
        target_label.backgroundColor = .black
        target_label.textColor = .white
        view.addSubview(target_label)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        testBinder()
    }
    
    func testAnyObserve() {
        let observable: Observable<Int> = Observable.create { subscribe in
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                subscribe.onNext(1)
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                subscribe.onCompleted()
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                subscribe.onNext(3) /// 不执行
            }
            return Disposables.create()
        }
        let observe: AnyObserver<Int> = AnyObserver { (event) in
            switch(event) {
            case .next(let num):
                print(num)
            case .completed:
                print("compltion")
            case .error(_):
                print("error")
            }
        }
        observable.subscribe(observe).disposed(by: disposeBag)
    }
    
    func testBinder() {
        let observable: Observable<Int> = Observable.create { subscribe in
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                subscribe.onNext(1)
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.25) {
                subscribe.onNext(2)
            }
            
//            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
//                subscribe.onError(NSError()) /// debug crash,release报错
//            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                subscribe.onCompleted()
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                subscribe.onNext(3) /// 不执行
            }
            return Disposables.create()
        }
        let observe: Binder<Int> = Binder(target_label) { (label, num) in
            label.text = "num: \(num)"
        }
        
       
        observable.bind(to: observe).disposed(by: disposeBag)
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
