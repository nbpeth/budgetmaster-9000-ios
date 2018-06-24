import UIKit

@IBDesignable
class CircleProgressView: UIView {
    var value:Float?
    var lineWidth:CGFloat?
    var inTheRed: Bool = false
    @IBInspectable var baseColor:UIColor?
    @IBInspectable var progressColor:UIColor?
    
    override func draw(_ rect: CGRect) {
        let center = CGPoint(x:bounds.width/2, y: bounds.height/2)
        let radius: CGFloat = min(bounds.width, bounds.height)/2.5
        let circlePath = UIBezierPath(arcCenter: center, radius: radius, startAngle: CGFloat(00), endAngle: CGFloat(Double.pi * 2), clockwise: true)
        baseColor?.set()
        circlePath.lineWidth = CGFloat(20)
        circlePath.stroke()
        
        let progressCirclePath = UIBezierPath(arcCenter: center, radius: radius, startAngle: CGFloat(00), endAngle: progressToCircle(), clockwise: true)
        
        progressCirclePath.lineWidth = CGFloat(20)
        
//        progressColor?.set()
        progressColor = self.value ?? Float(0) >= Float(100) ? UIColor.red : UIColor.green
        progressColor?.setStroke()
        progressCirclePath.stroke()
        
    }
    
    func moveit(_ value:Float){
        self.value = value
//        self.inTheRed = inTheRed
        setNeedsDisplay()
    }
    
    fileprivate func progressToCircle() -> CGFloat{
        var angle:CGFloat = 00
        if let progress = value {
            angle = degreesToRadians(value: CGFloat((1-progress) * 360))
        }
        return angle
    }
    
    
    fileprivate func degreesToRadians (value:CGFloat) -> CGFloat {
        return value * CGFloat(Double.pi) / 180.0
    }
    
    fileprivate func radiansToDegrees (value:CGFloat) -> CGFloat {
        return value * 180.0 / CGFloat(Double.pi)
    }
}
