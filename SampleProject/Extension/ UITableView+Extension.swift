//
//   UITableView+Extension.swift
//  SampleProject
//
//  Created by RAVI K GUPTA on 04/01/22.
//

import UIKit

extension UITableView{
    func indexPathForView(_ view: UIView) -> IndexPath? {
        let center = view.center
        let viewCenter = convert(center, from: view.superview)
        let indexPath = indexPathForRow(at: viewCenter)
        return indexPath
    }
    func registerReusableCell<Cell: Reusable>(_ cell: Cell.Type){
        let ni = UINib(nibName: Cell.nib, bundle:  Bundle(for: cell))
        self.register(ni, forCellReuseIdentifier: cell.reuseIdentifier)
    }
    
    func dequeueReusableCell<Cell:Reusable>(_ cell: Cell.Type,for indexPath: IndexPath)-> Cell {
        return self.dequeueReusableCell(withIdentifier: cell.reuseIdentifier, for: indexPath) as! Cell
    }
    
    func registerReusableHeaderFooterCell<Cell: Reusable>(_ cell: Cell.Type){
        let nib = UINib(nibName: Cell.nib, bundle:  Bundle(for: cell))
        self.register(nib, forHeaderFooterViewReuseIdentifier: cell.reuseIdentifier)
    }
    
    func dequeueReusableHeaderFooterCell<Cell:Reusable>(_ cell: Cell.Type)-> Cell {
        return self.dequeueReusableHeaderFooterView(withIdentifier: cell.reuseIdentifier) as! Cell
    }
    func reloadWithoutScroll() {
        let offset = contentOffset
        print("reloadWithoutScroll before \(offset)")
        reloadData()
        layoutIfNeeded()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.setContentOffset(offset, animated: false)

        }
        print("reloadWithoutScroll After \(contentOffset)")

      }
    func restore() {
        self.backgroundView = nil
    }
    func indexPathIsValid(_ indexPath: IndexPath) -> Bool {
        let section = indexPath.section
        let row = indexPath.row
        return section < self.numberOfSections && row < self.numberOfRows(inSection: section)
    }
    func scrollToTop(animated: Bool = true) {
        let indexPath = IndexPath(row: 0, section: 0)
        if self.indexPathIsValid(indexPath) {
          self.scrollToRow(at: indexPath, at: .top, animated: animated)
        }
    }
    
    func setEmptyMessage(_ message: String) {
        let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
        messageLabel.style(fontType: FontType.GoldplayRegular, fontSize: .size20, textColor: Color.appLightGray, textStyle: .body)
        messageLabel.textAlignment = .center
        messageLabel.text = message
        messageLabel.sizeToFit()
        
        self.backgroundView = messageLabel
        self.separatorStyle = .none
    }
  
}
extension UICollectionView{
    func indexPathForView(_ view: UIView) -> IndexPath? {
        let center = view.center
        let viewCenter = convert(center, from: view.superview)
        let indexPath = indexPathForItem(at: viewCenter)
        return indexPath
    }
    
    func registerReusableCell<Cell: Reusable>(_ cell: Cell.Type){
        let ni = UINib(nibName: Cell.nib, bundle:  Bundle(for: cell))
        self.register(ni, forCellWithReuseIdentifier: cell.reuseIdentifier)
    }
    
    func dequeueReusableCell<Cell:Reusable>(_ cell: Cell.Type,for indexPath: IndexPath)-> Cell {
        return self.dequeueReusableCell(withReuseIdentifier: cell.reuseIdentifier, for: indexPath) as! Cell
    }
}

