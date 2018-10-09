//
//  ViewController.swift
//  NJ TRANSIT
//
//  Created by Matt Bowyer on 5/29/17.
//  Copyright © 2017 Grape. All rights reserved.
//

import UIKit


class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var ScrollView: UIScrollView!
    
    @IBOutlet weak var TextFieldOrigin: UITextField!
    @IBOutlet weak var TextFieldDestination: UITextField!
    @IBOutlet weak var TextFieldRoute: UITextField!
    @IBOutlet weak var TextFieldColorBanner: UITextField!
    @IBOutlet weak var TextFieldColor1: UITextField!
    @IBOutlet weak var TextFieldColor2: UITextField!
    @IBOutlet weak var TextFieldColor3: UITextField!
    
    var gradient = CAGradientLayer()
    let dateFormatter = DateFormatter()
    let timeFormatter = DateFormatter()
    var startTime = Date()
    
    /* --- iPhone 6
    var Ticket = UIView(frame: CGRect(x: 0, y: 0, width: 375, height: 300))
    var DestinationView = UIView(frame: CGRect(x: 11, y: 8, width: 354, height: 150))
    var LabelOriginM = UILabel(frame: CGRect(x: 14, y: 5, width: 326, height: 41))
    var LabelToM = UILabel(frame: CGRect(x: 144, y: 47, width: 67, height: 57))
    var LabelRouteM = UILabel(frame: CGRect(x: 14, y: 37, width: 52, height: 30))
    var LabelDestinationM = UILabel(frame: CGRect(x: 14, y: 105, width: 326, height: 40))
    */
    
    // ---- iPhone 5
    var Ticket = UIView(frame: CGRect(x: 0, y: 0, width: 320, height: 280))
    var DestinationView = UIView(frame: CGRect(x: 11, y: 8, width: 299, height: 152))
    var LabelOriginM = UILabel(frame: CGRect(x: -2, y: 6, width: 301, height: 41))
    var LabelToM = UILabel(frame: CGRect(x: 116, y: 48, width: 67, height: 57))
    var LabelRouteM = UILabel(frame: CGRect(x: 8, y: 38, width: 52, height: 30))
    var LabelDestinationM = UILabel(frame: CGRect(x: 0, y: 107, width: 299, height: 40))
    
    var LabelTimeCurrentM = UILabel(frame: CGRect(x: 24, y: 205, width: 326, height: 20))
    var LabelDateCurrentM = UILabel(frame: CGRect(x: 24, y: 226, width: 326, height: 20))
    var LabelTimeExpirationM = UILabel(frame: CGRect(x: 100, y: 270, width: 170, height: 20))
    var BlinkerViewM = UIView(frame: CGRect(x: 16, y: 250, width: 142, height: 20))
    var BlinkerLeftM = UIView(frame: CGRect(x: 0, y: 0, width: 114, height: 20))
    var BlinkerMidM = UIView(frame: CGRect(x: 114, y: 0, width: 114, height: 20))
    var BlinkerRightM = UIView(frame: CGRect(x: 228, y: 0, width: 114, height: 20))
    var accessButton = UIButton(frame: CGRect(x: 16, y: 268, width: 34, height: 30))
    
    var barcodeView = UIImageView(image: UIImage(named: "Barcode.png" ))
    var directionView = UIImageView(image: UIImage(named: "Direction.png"))
    
    
    var detailOrientation = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(self.updateTicket), userInfo: nil, repeats: true)
        gradient.frame = DestinationView.bounds
        DestinationView.layer.insertSublayer(gradient, at: 0)
        DestinationView.layer.cornerRadius = 8
        DestinationView.layer.masksToBounds = true
        dateFormatter.dateStyle = DateFormatter.Style.full
        dateFormatter.timeStyle = DateFormatter.Style.none
        timeFormatter.dateStyle = DateFormatter.Style.none
        timeFormatter.timeStyle = DateFormatter.Style.medium
        accessButton.setTitle("Back", for: UIControlState.normal)
        accessButton.setTitleColor(pickColor(input: "017BFF"), for: UIControlState.normal)
        accessButton.addTarget(self, action: #selector(display), for: .touchDown)

        LabelTimeExpirationM.textAlignment = .center
        LabelDateCurrentM.textAlignment = .center
        LabelTimeCurrentM.textAlignment = .center
        LabelDestinationM.textAlignment = .center
        LabelRouteM.textAlignment = .center
        LabelToM.textAlignment = .center
        LabelOriginM.textAlignment = .center
        
        LabelToM.text="to"
        LabelOriginM.font = UIFont.boldSystemFont(ofSize: 42)
        LabelToM.font = UIFont.boldSystemFont(ofSize: 42)
        LabelRouteM.font = UIFont.boldSystemFont(ofSize: 16)
        LabelDestinationM.font = UIFont.boldSystemFont(ofSize: 42)
        LabelTimeCurrentM.font = UIFont.boldSystemFont(ofSize: 21)
        LabelDateCurrentM.font = UIFont.boldSystemFont(ofSize: 21)
        LabelTimeExpirationM.font = UIFont.boldSystemFont(ofSize: 16)
        accessButton.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        
        /* --- iPhone 6
        BlinkerLeftM.frame = CGRect(x: 0, y: 0, width: 121, height: 20)
        BlinkerMidM.frame = CGRect(x: 121, y: 0, width: 121, height: 20)
        BlinkerRightM.frame = CGRect(x: 242, y: 0, width: 121, height: 20)
        directionView.frame=CGRect(x: 4, y: 161, width: 157, height: 170)
        barcodeView.frame=CGRect(x: 215, y: 164, width: 160, height: 170)
        */
        
        // --- iPhone 5
        BlinkerLeftM.frame = CGRect(x: 0, y: 0, width: 104, height: 20)
        BlinkerMidM.frame = CGRect(x: 104, y: 0, width: 104, height: 20)
        BlinkerRightM.frame = CGRect(x: 208, y: 0, width: 104, height: 20)
        directionView.frame=CGRect(x: 4, y: 161, width: 156, height: 170)
        barcodeView.frame=CGRect(x: 161, y: 163, width: 159, height: 170)
        
        directionView.alpha=0.0
        barcodeView.alpha=0.0
 
        BlinkerViewM.addSubview(BlinkerLeftM)
        BlinkerViewM.addSubview(BlinkerMidM)
        BlinkerViewM.addSubview(BlinkerRightM)
        DestinationView.addSubview(LabelOriginM)
        DestinationView.addSubview(LabelToM)
        DestinationView.addSubview(LabelRouteM)
        DestinationView.addSubview(LabelDestinationM)
        Ticket.addSubview(barcodeView)
        Ticket.addSubview(directionView)
        Ticket.addSubview(DestinationView)
        Ticket.addSubview(BlinkerViewM)
        Ticket.addSubview(LabelTimeCurrentM)
        Ticket.addSubview(LabelDateCurrentM)
        Ticket.addSubview(LabelTimeExpirationM)
        Ticket.addSubview(accessButton)
        Ticket.backgroundColor=UIColor.white
        setDetailPosition()
        self.view.addSubview(Ticket)
        
        //TextFieldOrigin.text="NW BRUNS"
        //TextFieldRoute.text="SEC"
        //TextFieldDestination.text="NYP NYP"
        //TextFieldColor1.text="11aaff"
        //TextFieldColor2.text="ffaa11"
        //TextFieldColor3.text="11aa11"
        //TextFieldColorBanner.text="11aaaa"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    override var prefersStatusBarHidden: Bool{
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        //ScrollView.setContentOffset(CGPoint(x:0,y:textField.frame.origin.y-43), animated: true)
        ScrollView.setContentOffset(CGPoint(x:0,y:textField.frame.origin.y-13), animated: true)
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        ScrollView.setContentOffset(CGPoint(x:0,y:0), animated: true)
        updateTicket()
    }
    
    func display(){
        setDisplayPosition()
        
        /*
        print("fuck you")
        if(detailOrientation){
            setDisplayPosition()
        }
        else{
            setDetailPosition()
        }*/
    }
    
    func setDetailPosition(){
        //ScrollView.alpha=1.0
        detailOrientation=true

        /* --- iPhone 6
        LabelTimeCurrentM.frame=CGRect(x: 100, y: 195, width: 174, height: 21)
        LabelDateCurrentM.frame=CGRect(x: 51, y: 215, width: 273, height: 21)
        LabelTimeExpirationM.frame=CGRect(x: 80, y: 260, width: 226, height: 21)
        BlinkerViewM.frame=CGRect(x: 4, y: 240, width: 336, height: 20)
        accessButton.frame = CGRect(x: 19, y: 258, width: 49, height: 30)
        Ticket.frame = CGRect(x: 0, y: 0, width: 375, height: 300)
        */
        
        LabelTimeCurrentM.frame=CGRect(x: 73, y: 175, width: 174, height: 21)
        LabelDateCurrentM.frame=CGRect(x: 22, y: 195, width: 273, height: 24)
        LabelTimeExpirationM.frame=CGRect(x: 63, y: 240, width: 226, height: 21)
        BlinkerViewM.frame=CGRect(x: 4, y: 220, width: 326, height: 20)
        accessButton.frame = CGRect(x: 19, y: 238, width: 49, height: 30)
        Ticket.frame = CGRect(x: 0, y: 0, width: 320, height: 280)
        
        directionView.alpha=0.0
        barcodeView.alpha=0.0
        
    }
    
    func setDisplayPosition(){
        //ScrollView.alpha=0.0
        detailOrientation=false
        
        /* --- iPhone 6
        Ticket.frame = CGRect(x: 0, y: 0, width: 375, height: 667)
        LabelTimeCurrentM.frame=CGRect(x: 100, y: 544, width: 174, height: 21)
        LabelDateCurrentM.frame=CGRect(x: 51, y: 576, width: 273, height: 21)
        LabelTimeExpirationM.frame=CGRect(x: 80, y: 632, width: 226, height: 21)
        BlinkerViewM.frame=CGRect(x: 4, y: 605, width: 336, height: 20)
        accessButton.frame = CGRect(x: 19, y: 629, width: 49, height: 30)
        */
        
        //--- iPhone 5 Presets
        Ticket.frame = CGRect(x: 0, y: 0, width: 320, height: 568)
        LabelTimeCurrentM.frame=CGRect(x: 73, y: 445, width: 174, height: 21)
        LabelDateCurrentM.frame=CGRect(x: 22, y: 474, width: 273, height: 24)
        LabelTimeExpirationM.frame=CGRect(x: 63, y: 534, width: 226, height: 21)
        BlinkerViewM.frame=CGRect(x: 4, y: 506, width: 312, height: 20)
        accessButton.frame = CGRect(x: 19, y: 530, width: 49, height: 30)
        
        directionView.alpha=1.0
        barcodeView.alpha=1.0

    }
    
    func updateTicket(){
        let date = Date()
        let di = date.timeIntervalSince(startTime)
        let second = 1
        let minute = 60*second
        let hour = 60*minute
        let day = 24*hour
        let week = 7*day
        let countDown = 2*hour - Int(di)
        if(countDown==1){ startTime = date }
        let s = ((countDown % minute)/second)
        let m = ((countDown % hour)/minute)
        let h = ((countDown % day)/hour)
        let d = ((countDown % week)/day)
        var ss = String(s)
        var mm = String(m)
        var dd = String(d)
        var hh = String(h)
        if(ss.characters.count==1){ss = "0"+ss}
        if(mm.characters.count==1){mm = "0"+mm}
        if(hh.characters.count==1){hh = "0"+hh}
        if(dd.characters.count==1){dd = "0"+dd}
        LabelTimeCurrentM.text = timeFormatter.string(from: date)
        LabelDateCurrentM.text = dateFormatter.string(from: date)
        LabelTimeExpirationM.text = "Expires in "+dd+":"+hh+":"+mm+":"+ss
        setGradient(color: TextFieldColorBanner.text!)
        LabelOriginM.text = TextFieldOrigin.text
        LabelDestinationM.text = TextFieldDestination.text
        LabelRouteM.text = TextFieldRoute.text
        BlinkerLeftM.backgroundColor = pickColor(input: TextFieldColor1.text!)
        BlinkerMidM.backgroundColor = pickColor(input: TextFieldColor2.text!)
        BlinkerRightM.backgroundColor = pickColor(input: TextFieldColor3.text!)
        if(BlinkerViewM.alpha==1.0){
            BlinkerViewM.alpha=0.0
        }
        else{
            BlinkerViewM.alpha=1.0
        }
    }
    
    func setGradient(color: String){
        let shade = [
            pickCgcolor(input: color, alpha: 1.0),
            pickCgcolor(input: color, alpha: 0.9),
            pickCgcolor(input: color, alpha: 0.75),
            pickCgcolor(input: color, alpha: 0.6),
            pickCgcolor(input: color, alpha: 0.5),
            pickCgcolor(input: color, alpha: 0.35),
            pickCgcolor(input: color, alpha: 0.25),
            pickCgcolor(input: color, alpha: 0.15),
            pickCgcolor(input: color, alpha: 0.1),
            pickCgcolor(input: color, alpha: 0.05),
            pickCgcolor(input: color, alpha: 0.0)]
        let rev = shade.reversed()
        gradient.colors = shade + rev
    }
    
    func pickColor(input: String) -> UIColor {
        if let num = UInt(input, radix: 16) {
            return UIColor(rgb: Int(num))
        }
        return UIColor.white
    }
    func pickCgcolor(input: String, alpha: CGFloat) -> CGColor {
        if let num = UInt(input, radix: 16) {
            return UIColor(rgb: Int(num)).withAlphaComponent(alpha).cgColor
        }
        return UIColor.white.cgColor
    }
}

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(rgb: Int) {
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: rgb & 0xFF
        )
    }
}


