//
//  ViewController.swift
//  App240521_BMI
//
//  Created by 박다현 on 5/21/24.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var subTitle: UILabel!
        
    @IBOutlet var backImageView: UIImageView!
    @IBOutlet var heightLabel: UILabel!
    @IBOutlet var heightTextField: UITextField!
    
    @IBOutlet var weightLabel: UILabel!
    @IBOutlet var weightTextField: UITextField!
    
    @IBOutlet var autoCalulateButton: UIButton!
    
    @IBOutlet var calculateButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        configureTextField(heightTextField)
        configureTextField(weightTextField)
        heightTextField.text = UserDefaults.standard.string(forKey: "userHeight")
        weightTextField.text = UserDefaults.standard.string(forKey: "userWeight")
    }


    func configure(){
        titleLabel.text = "BMI Calculator"
        titleLabel.font = .boldSystemFont(ofSize: 25)
        subTitle.text = "당신의 BMI 지수를 \n알려드릴게요."
        subTitle.font = .systemFont(ofSize: 15)
        subTitle.numberOfLines = 0
        
        backImageView.image = UIImage(named: "image")
        backImageView.contentMode = .scaleAspectFill
        heightLabel.text = "키가 어떻게 되시나요?"
        weightLabel.text = "몸무게는 어떻게 되시나요?"
 
        autoCalulateButton.setTitle("랜덤으로 BMI 계산하기", for: .normal)
        autoCalulateButton.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        autoCalulateButton.setTitleColor(.brown, for: .normal)
        autoCalulateButton.titleLabel?.textAlignment = .right
        
        calculateButton.setTitle("결과 확인", for: .normal)
        calculateButton.backgroundColor = .purple
        calculateButton.setTitleColor(.white, for: .normal)
        calculateButton.layer.cornerRadius = 10
    }
    
    //텍스트필드 UI 설정
    func configureTextField(_ textField:UITextField){
        textField.font = .systemFont(ofSize: 15)
        textField.layer.borderColor = UIColor.black.cgColor
        textField.layer.borderWidth = 1
        textField.layer.cornerRadius = 10
    }    
    
    
    //숫자만 입력되도록 허용
    @IBAction func textFieldChanged(_ sender: UITextField) {
        if let text = sender.text{
            if Int(text) == nil {
                presentAlert(title: "숫자만 입력", message: "숫자만 입력해주세요.")
                sender.text = ""
            }
        }
    }

    //계산하기 클릭시 액션
    @IBAction func calculateButtonClicked(_ sender: UIButton) {
        
        guard let height = heightTextField.text else { return }
        guard let weight = weightTextField.text else { return }
        //공백제거 후 텍스트필드가 비었는지 확인
        if !height.trimmingCharacters(in: .whitespaces).isEmpty && !weight.trimmingCharacters(in: .whitespaces).isEmpty {
            guard let height = Double(height) else { return }
            guard let weight = Double(weight) else { return }
            
            //키가 범위안에 있는지 확인
            if height > 1 && height < 250{
                
                //몸무게가 범위 안에 있는지 확인
                if weight > 1 && weight < 200{
                    // bmi = 몸무게(kg) / 키(m) x 키(m)
                    let bmi = weight / (height/100 * height/100 )
                    presentAlert(title: "당신의 BMI는?", message: "\(String(format: "%.1f", bmi))입니다.")
                    UserDefaults.standard.set(height, forKey: "userHeight")
                    UserDefaults.standard.set(weight, forKey: "userWeight")
    
                }else{
                    //몸무게가 범위 밖이라면
                    presentAlert(title: "키 재입력", message: "키가 범위를 벗어납니다. 재입력해주세요.")
                }
            }else{
                //키가 범위 밖이라면
                presentAlert(title: "몸무게 재입력", message: "몸무게가 범위를 벗어납니다. 재입력해주세요.")
            }


        }else{
            //키나 몸무게가 입력되지 않았다면
            presentAlert(title: "입력하세요.", message: "키와 몸무게를 입력하세요.")
        }
     
    }
    
    //렌덤 BMI 계산
    @IBAction func randomCalculateButtonTapped(_ sender: UIButton) {
        let randomHeight = Int.random(in: 100...180)
        let randomWeight = Int.random(in: 30...90)
        
        let bmi = Double(randomWeight) / (Double(randomHeight)/100 * Double(randomHeight)/100 )
        
        presentAlert(title:"당신의 랜덤BMI는?", message:"키:\(randomHeight), 몸무게:\(randomWeight)이며, BMI는 \(String(format: "%.1f", bmi))입니다.")
        
    }
    
    //얼럿
    func presentAlert(title:String, message:String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let open = UIAlertAction(title: "확인", style: .default)
        alert.addAction(open)
        present(alert, animated: true)
    }
    
}

