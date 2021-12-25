//
//  Hot_Cold.swift
//  rxDemo
//
//  Created by ForC on 2021/12/22.
//

import UIKit
import RxSwift
import RxCocoa

class Hot_Cold: UIViewController {

    let displose = DisposeBag()
    lazy var cold: Maybe<String> = {
        let mb = Maybe<String>.create { observale in
            print("maybe input")
            observale(.success("1"))
            observale(.completed)/// 失效
            return Disposables.create()
        }
        return mb
    }()
    
    lazy var hot: Driver<String> = {
        let hot = Observable<String>.create { observale in
            print("Driver input")
            observale.onNext("2")
            return Disposables.create()
        }
        return hot.asDriver(onErrorDriveWith: .empty())
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        cold.subscribe { xx in
            switch xx {
            case .success(let value):
                print("cold subscribe \(value)")
            case .error(_):
                print("error")
            case .completed:
                print("completed")
            }
        }.disposed(by: displose)

        hot.drive { xx in
            print("hot subscribe \(xx)")
        } onCompleted: {
            print("completed")
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
