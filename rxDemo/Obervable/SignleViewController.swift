/// single observable另一个版本，但是他只可以产生一个onnext元素或error元素

import UIKit
import RxSwift

class SignleViewController: UIViewController {

    let disposeBag = DisposeBag()
    lazy var single: Single<UIColor> = {
        let single = Single<UIColor>.create { sg in
            
            let arc1 =  Int(arc4random()%255)
            let arc2 =  Int(arc4random()%255)
            let arc3 =  Int(arc4random()%255)
            
            sg(.success(UIColor(red: CGFloat(arc1)/255.0, green: CGFloat(arc2)/255.0, blue: CGFloat(arc3)/255.0, alpha: 1)))

            return Disposables.create {
                
            }
        }
        return single
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
        single.subscribe { color in
            self.testView.backgroundColor = color
        } onError: { error in
            
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
