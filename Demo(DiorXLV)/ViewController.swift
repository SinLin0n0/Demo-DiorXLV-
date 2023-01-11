//
//  ViewController.swift
//  Demo(DiorXLV)
//
//  Created by Sin on 2023/1/11.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var louisVuittonImageView: UIImageView!
    @IBOutlet weak var redSlider: UISlider!
    @IBOutlet weak var greenSlider: UISlider!
    @IBOutlet weak var blueSlider: UISlider!
    @IBOutlet weak var redLabel: UILabel!
    @IBOutlet weak var greenLabel: UILabel!
    @IBOutlet weak var blueLabel: UILabel!
    @IBOutlet weak var starEmitterControl: UISwitch!
    let starLayer = CAEmitterLayer()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //旋轉LV的圖片
        let oneDegree = CGFloat.pi / 180
        louisVuittonImageView.transform = CGAffineTransform.identity.rotated(by: oneDegree * -30)
        //設定SliderLabel的預設值
        redLabel.text = "255"
        greenLabel.text = "255"
        blueLabel.text = "255"
        //一開畫面就有星星
        starEmitter()
        
        
    }
    @IBAction func changeColor(_ sender: Any) {
        //三個slider功能是一樣的，可以拉到同一個Action，就不用寫三個Action的內容
        //拉動slider時，會有兩個動作，圖片改顏色以及slider label數字改變
        
        //因為RGB的值最多為1，所以要/255
        louisVuittonImageView.backgroundColor = UIColor(red: CGFloat(redSlider.value/255), green: CGFloat(greenSlider.value/255), blue: CGFloat(blueSlider.value/255), alpha: 1)
        //Slider後的數字設定
        redLabel.text = String(Int(redSlider.value))
        greenLabel.text = Int(greenSlider.value).description
        blueLabel.text = String(format:"%.0f", blueSlider.value)
        //"%.0f"是要取到小數點後幾位的寫法，這邊寫取到第0位代表整數
       


    }
    
    @IBAction func random(_ sender: Any) {
        //設定亂數，因為這個按鈕是一次產生3個針對Slider的亂數，所以3個slider都寫在此Func內
        redSlider.value = Float.random(in: 0...255)
        greenSlider.value = Float.random(in: 0...255)
        blueSlider.value = Float.random(in: 0...255)
        
        //複製剛剛寫好的changeColor程式碼
        //Image
        louisVuittonImageView.backgroundColor = UIColor(red: CGFloat(redSlider.value/255), green: CGFloat(greenSlider.value/255), blue: CGFloat(blueSlider.value/255), alpha: 1)
        //Slider
        redLabel.text = String(Int(redSlider.value))
        greenLabel.text = Int(greenSlider.value).description
        blueLabel.text = String(format:"%.0f", blueSlider.value)
    }
    func starEmitter(){
        //設定星星動畫
        let starEmitterCell = CAEmitterCell()
        starEmitterCell.contents = UIImage(named: "star")?.cgImage
        
        starEmitterCell.birthRate = 0.5
        starEmitterCell.lifetime = 100
        starEmitterCell.velocity = 1
        starEmitterCell.yAcceleration = 1
        starEmitterCell.scale = 0.3
        starEmitterCell.spin = 0.5
        starEmitterCell.emissionRange = .pi*0.5
        
       //將 let starLayer = CAEmitterLayer()寫在func外
        starLayer.emitterCells = [starEmitterCell]
        starLayer.emitterPosition = CGPoint(x: view.bounds.width/2, y: -50)
        starLayer.emitterSize = CGSize(width: view.bounds.width, height: 0)
        starLayer.emitterShape = .line
        view.layer.addSublayer(starLayer)
        
    }
    
    @IBAction func starSwitch(_ sender: Any) {
        if starEmitterControl.isOn{
            starEmitter()
        } else {
            starLayer.removeFromSuperlayer()
        }
    }
    
}

