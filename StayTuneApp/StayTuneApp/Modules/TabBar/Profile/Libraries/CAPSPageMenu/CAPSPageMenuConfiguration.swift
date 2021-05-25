//
//  CAPSPageMenuConfiguration.swift
//  StayTuneApp
//
//  Created by Rishat on 07.05.2021.
//

import UIKit

public class CAPSPageMenuConfiguration {
    open var menuHeight: CGFloat = 34.0
    open var menuMargin: CGFloat = 15.0
    open var menuItemWidth: CGFloat = 111.0
    open var selectionIndicatorHeight: CGFloat = 3.0
    open var scrollAnimationDurationOnMenuItemTap: Int = 500 // Millisecons
    open var selectionIndicatorColor = UIColor.white
    open var selectedMenuItemLabelColor = UIColor.white
    open var unselectedMenuItemLabelColor = UIColor.lightGray
    open var scrollMenuBackgroundColor = UIColor.black
    open var viewBackgroundColor = UIColor.white
    open var bottomMenuHairlineColor = UIColor.white
    open var menuItemSeparatorColor = UIColor.lightGray

    open var menuItemFont = UIFont.systemFont(ofSize: 15.0)
    open var menuItemSeparatorPercentageHeight: CGFloat = 0.2
    open var menuItemSeparatorWidth: CGFloat = 0.5
    open var menuItemSeparatorRoundEdges = false

    open var addBottomMenuHairline = true
    open var menuItemWidthBasedOnTitleTextWidth = false
    open var titleTextSizeBasedOnMenuItemWidth = false
    open var useMenuLikeSegmentedControl = false
    open var centerMenuItems = false
    open var enableHorizontalBounce = true
    open var hideTopMenuBar = false

    public init() {
    }
}
