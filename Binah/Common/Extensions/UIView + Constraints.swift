//
//  UIView + Constraints.swift
//  Binah
//
//  Created by Adar Tzeiri on 18/01/2021.
//

import UIKit

extension UIView
{
    /// Will add "view" to "superView" with superView's constraints.
    ///
    /// - Parameters:
    ///     - view     : The view which you want to add to superView.
    ///     - superView: The view which you add view to.
    ///     view will get superView's constraints.
    static func addEqualConstraints(for view: UIView, to superView: UIView)
    {
        superView.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        let top = NSLayoutConstraint(item: view, attribute: .top, relatedBy: .equal, toItem: superView, attribute: .top, multiplier: 1.0, constant: 0)
        let leading = NSLayoutConstraint(item: view, attribute: .leading, relatedBy: .equal, toItem: superView, attribute: .leading, multiplier: 1.0, constant: 0)
        let trailing = NSLayoutConstraint(item: view, attribute: .trailing, relatedBy: .equal, toItem: superView, attribute: .trailing, multiplier: 1.0, constant: 0)
        let bottom = NSLayoutConstraint(item: view, attribute: .bottom, relatedBy: .equal, toItem: superView, attribute: .bottom, multiplier: 1.0, constant: 0)
        superView.addConstraints([top,leading,trailing,bottom])
        
        superView.setNeedsLayout()
        superView.layoutIfNeeded()
    }
    
    static func addCustomConstraints(for view: UIView, to superView: UIView, top: CGFloat = 0, bottom: CGFloat = 0, leading: CGFloat = 0, trailing: CGFloat = 0)
    {
        superView.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        let top = NSLayoutConstraint(item: view, attribute: .top, relatedBy: .equal, toItem: superView, attribute: .top, multiplier: 1.0, constant: top)
        let leading = NSLayoutConstraint(item: view, attribute: .leading, relatedBy: .equal, toItem: superView, attribute: .leading, multiplier: 1.0, constant: leading)
        let trailing = NSLayoutConstraint(item: view, attribute: .trailing, relatedBy: .equal, toItem: superView, attribute: .trailing, multiplier: 1.0, constant: trailing)
        let bottom = NSLayoutConstraint(item: view, attribute: .bottom, relatedBy: .equal, toItem: superView, attribute: .bottom, multiplier: 1.0, constant: bottom)
        superView.addConstraints([top,leading,trailing,bottom])
        
        superView.setNeedsLayout()
        superView.layoutIfNeeded()
    }
    
    static func addCenterConstraints(for view: UIView, to superView: UIView)
    {
        superView.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        let centerX = NSLayoutConstraint(item: view, attribute: .centerX, relatedBy: .equal, toItem: superView, attribute: .centerX, multiplier: 1.0, constant: 0)
        let centerY = NSLayoutConstraint(item: view, attribute: .centerY, relatedBy: .equal, toItem: superView, attribute: .centerY, multiplier: 1.0, constant: 0)
        superView.addConstraints([centerX,centerY])
        
        superView.setNeedsLayout()
        superView.layoutIfNeeded()
    }
    
    var isAlphaHidden : Bool
    {
        return alpha == 0.0
    }
    
    func constraintFrame(to superViewObject: UIView)
    {
        translatesAutoresizingMaskIntoConstraints = false
        
        let      topConstraint = NSLayoutConstraint(item: self, attribute: .top     , relatedBy: .equal, toItem: superViewObject, attribute: .top     , multiplier: 1.0, constant: 0.0)
        let   bottomConstraint = NSLayoutConstraint(item: self, attribute: .bottom  , relatedBy: .equal, toItem: superViewObject, attribute: .bottom  , multiplier: 1.0, constant: 0.0)
        let  leadingConstraint = NSLayoutConstraint(item: self, attribute: .leading , relatedBy: .equal, toItem: superViewObject, attribute: .leading , multiplier: 1.0, constant: 0.0)
        let trailingConstraint = NSLayoutConstraint(item: self, attribute: .trailing, relatedBy: .equal, toItem: superViewObject, attribute: .trailing, multiplier: 1.0, constant: 0.0)
        superViewObject.addConstraints([topConstraint,bottomConstraint,leadingConstraint,trailingConstraint])
    }
    
    static func addViewConstraintsForTopLevelView(View view : UIView, superView : UIView) -> Void
    {
        view.constraintFrame(to: superView)
    }
    
    @discardableResult
    func removeConstraintsfromSuperView(Superview superview : UIView) -> [NSLayoutConstraint]
    {
        var constraintsCopy  = Array<NSLayoutConstraint>()
        
        var searchView = self
        
        while (searchView.superview != nil) && searchView != superview
        {
            searchView = searchView.superview!
            
            let affectingConstraints = searchView.constraints
            var constraintsToRemove = Array<NSLayoutConstraint>()
            
            for  constrint : NSLayoutConstraint in affectingConstraints
            {
                guard let  firstItem = constrint.firstItem as? NSObject else { continue }
                guard let secondItem = constrint.secondItem             else { continue }
                
                guard (firstItem == self) || (secondItem as? NSObject == self) else { continue }
                
                constraintsCopy.append(constrint)
                constraintsToRemove.append(constrint)
            }
            searchView.removeConstraints(constraintsToRemove)
        }
        return constraintsCopy;
    }
}

extension UIView
{
    func tableContainer() -> UITableView?
    {
        var currentView: UIView? = self
        while currentView?.superview != nil
        {
            if let cell = currentView as? UITableView
            {
                return cell
            }
            currentView = currentView?.superview
        }
        return nil
    }
    
    func cellContainer() -> UITableViewCell?
    {
        var currentView: UIView? = self
        while currentView?.superview != nil
        {
            if let cell = currentView as? UITableViewCell
            {
                return cell
            }
            currentView = currentView?.superview
        }
        return nil
    }
}

extension UIView
{
    func rotateAnimation(value: CGFloat = CGFloat(.pi * 2.0) ,repeat repeatCount: Float = Float.greatestFiniteMagnitude ,duration: CFTimeInterval = 2.0, key: String)
    {
        let rotateAnimation = CABasicAnimation(keyPath: "transform.rotation")
        rotateAnimation.fromValue = 0.0
        rotateAnimation.toValue = value
        rotateAnimation.duration = duration
        rotateAnimation.repeatCount = repeatCount
        
        layer.add(rotateAnimation, forKey: key)
    }
    
    func stopAnimation()
    {
        layer.removeAnimation(forKey: "rotate")
        layer.removeAllAnimations()
    }
}

//MARK: - Bottom View Addition
extension UIView
{
    func addBottomView(_ newSubview: UIView)
    {
        newSubview.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(newSubview)
        
        let centerXConstraint = NSLayoutConstraint(item: newSubview,
                                                   attribute: .centerX,
                                                   relatedBy: .equal,
                                                   toItem: self,
                                                   attribute: .centerX,
                                                   multiplier: 1,
                                                   constant: 0)
        
        let topConstraint = NSLayoutConstraint(item: newSubview,
                                                   attribute: .top,
                                                   relatedBy: .equal,
                                                   toItem: self,
                                                   attribute: .top,
                                                   multiplier: 1,
                                                   constant: 0)
 
        self.addConstraints([centerXConstraint, topConstraint])
    }
}

// MARK: - Frame/Bounds Methods
extension UIView
{
    /// If some parameter's value is nil, the current value will be used
    func setFrameWithOptionalValues(x: CGFloat? = nil, y: CGFloat? = nil, width: CGFloat? = nil, height: CGFloat? = nil)
    {
        frame = CGRect(x: x ?? frame.origin.x, y: y ?? frame.origin.y, width: width ?? frame.width, height: height ?? frame.height)
    }
    
    /// If some parameter's value is nil, the current value will be used
    func setBoundsWithOptionalValues(x: CGFloat? = nil, y: CGFloat? = nil, width: CGFloat? = nil, height: CGFloat? = nil)
    {
        bounds = CGRect(x: x ?? bounds.origin.x, y: y ?? bounds.origin.y, width: width ?? bounds.width, height: height ?? bounds.height)
    }
}

extension UIView {
   
    func findViewController() -> UIViewController? {
        if let nextResponder = self.next as? UIViewController {
            return nextResponder
        } else if let nextResponder = self.next as? UIView {
            return nextResponder.findViewController()
        } else {
            return nil
        }
    }
}

extension UIView {
    
    // MARK: - constraints
    func addSubviewWithSameSizeConstraints(_ subview: UIView) {
        /*
         by default, the autoresizing mask on a view gives rise to constraints that fully determine the view's position.
         Any constraints you set on the view are likely to conflict with autoresizing constraints,
         so you must turn off this property first. IB will turn it off for you.
         */
        subview.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(subview);
        
        addSameSizeConstraints(subview)
    }
    
    func addSubviewWithSameSizeConstraints(_ subview: UIView, topView: UIView?) {
        subview.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(subview);
        
        addSameSizeConstraints(subview, topView: topView)
    }
    
    func addSameSizeConstraints(_ subview: UIView) {
        
        addSameSizeConstraints(subview, topView: nil)
    }
    
    func addSubViewWithCenterConstraints(_ subview: UIView) {
        subview.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(subview)
        
        let padding: CGFloat = 0.0
        
        let centerConstraints = [
            NSLayoutConstraint(item: self, attribute: .centerX, relatedBy: .equal, toItem: subview, attribute: .centerX, multiplier: 1.0, constant: padding),
            NSLayoutConstraint(item: self, attribute: .centerY, relatedBy: .equal, toItem: subview, attribute: .centerY, multiplier: 1.0, constant: padding),
            ]
        addConstraints(centerConstraints)
    }
    
    fileprivate func addSameSizeConstraints(_ subview: UIView, topView: UIView?) {
        let padding: CGFloat = 0.0
        
        var topConstraint: NSLayoutConstraint!
        if topView == nil {
            // subview top is connected to view top
            topConstraint = NSLayoutConstraint(item: subview, attribute: NSLayoutConstraint.Attribute.top, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self, attribute: NSLayoutConstraint.Attribute.top, multiplier: 1.0, constant: padding)
        } else {
            // subview top is connected to bottom of topView
            topConstraint = NSLayoutConstraint(item: subview, attribute: NSLayoutConstraint.Attribute.top, relatedBy: NSLayoutConstraint.Relation.equal, toItem: topView, attribute: NSLayoutConstraint.Attribute.bottom, multiplier: 1.0, constant: padding)
        }
        
        let bottomConstraint = NSLayoutConstraint(item: subview, attribute: NSLayoutConstraint.Attribute.bottom, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self, attribute: NSLayoutConstraint.Attribute.bottom, multiplier: 1.0, constant: padding)
        
        let rightConstraint = NSLayoutConstraint(item: subview, attribute: NSLayoutConstraint.Attribute.right, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self, attribute: NSLayoutConstraint.Attribute.right, multiplier: 1.0, constant: padding)
        
        let leftConstraint = NSLayoutConstraint(item: subview, attribute: NSLayoutConstraint.Attribute.left, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self, attribute: NSLayoutConstraint.Attribute.left, multiplier: 1.0, constant: padding)
        
        addConstraints([topConstraint, bottomConstraint, rightConstraint, leftConstraint])
    }
    
    func addSubviewWithSameWidthConstraints(_ subview: UIView, andheight height: CGFloat) {
        
        subview.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(subview);
        
        // vertical constraints to top + height
        let views = ["subview": subview]
        let metrics = ["height": height]
        let verticalConstraints   = NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[subview(height)]", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: metrics, views: views)
        addConstraints(verticalConstraints)
        
        // horizontal constraints to right+left
        let horizontalConstraints = NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[subview]-0-|", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: nil, views: views)
        addConstraints(horizontalConstraints)
    }
}

