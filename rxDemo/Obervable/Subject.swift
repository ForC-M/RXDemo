// subject 既可以当监听序列，也可以当作监听者
// 常用： asyncSubject, publishSubject, replaySubject, behaviorSubject

// asyncSubject 当被订阅时，仅接受最后一个元素
// BehaviorSubject 当被订阅时，可以接受后续发出的‘最新’的元素 + 所有元素， ‘最新’代表离订阅时最近的发出的元素，如果没有则是默认元素
// publishSubject 当被订阅时，才可接受发出的元素，之前发出的元素无法获得
// replaySubject 当被订阅时，接受所有发出的元素，之前发出的元素可以获得， bufferSize最近几个元素


 
import UIKit
import RxSwift
class Subject: UIViewController {

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
        testRelplay()
    }
    
    func testRelplay() {
        let subject = ReplaySubject<String>.create(bufferSize: 1) /// 可接受最近几个
        subject.onNext("🐷") // 不接受
        subject.onNext("🐢") // 接受
        subject.subscribe{ self.target_label.text = $0 }.disposed(by: disposeBag)
        
        DispatchQueue.main.asyncAfter(deadline: .now()+1) {
            subject.onNext("🐶")
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now()+2) {
            subject.onNext("🪝")
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now()+3) {
            subject.onNext("🐱") // 仅接受
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now()+4) {
            subject.onCompleted()
        }
    }

    func testPublish() {
        let subject = PublishSubject<String> ()
        subject.onNext("🐷") // 不接受
        subject.subscribe{ self.target_label.text = $0 }.disposed(by: disposeBag)
        
        DispatchQueue.main.asyncAfter(deadline: .now()+1) {
            subject.onNext("🐶")
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now()+2) {
            subject.onNext("🪝")
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now()+3) {
            subject.onNext("🐱") // 仅接受
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now()+4) {
            subject.onCompleted()
        }
    }

    func testBehavior() {
        /// 默认填充使用比较有效
        let subject = BehaviorSubject<String> (value: "🐘")
//        subject.onNext("🐢") // 取消注释，则第一个元素是🐢
        
        DispatchQueue.main.asyncAfter(deadline: .now()+1) {
            subject.onNext("🐶")
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now()+2) {
            subject.onNext("🪝")
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now()+3) {
            subject.onNext("🐱") // 仅接受
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now()+4) {
            subject.onCompleted()
        }
        subject.subscribe{ self.target_label.text = $0 }.disposed(by: disposeBag)
    }
    
    func testAsync() {
        let subject = AsyncSubject<String> ()
        subject.subscribe{ self.target_label.text = $0 }.disposed(by: disposeBag)
        
        DispatchQueue.main.asyncAfter(deadline: .now()+1) {
            subject.onNext("🐶")
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now()+2) {
            subject.onNext("🪝")
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now()+3) {
            subject.onNext("🐱") // 仅接受
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now()+4) {
            subject.onCompleted()
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now()+5) {
            subject.onNext("🐷")
        }
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
