//
//  TableViewAdTest.swift
//  VogappsLib
//
//  Created by Ogan Topkaya on 21/06/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import Foundation
import XCTest
import VogappsLib

class TableViewAdTest: XCTestCase{

    func testAdCells(){
        var itemCount : Int = 0
        var adCount : Int = 0
        var stride : Int = 0
        
        XCTAssert(TableViewAd.adjustCount(itemCount: itemCount, adCount: adCount, forStride: stride) == 0)
        
        XCTAssert(TableViewAd.adjustNonAdCell(index: 0, itemCount: itemCount, adCount: adCount, forStride: stride) == nil)
        XCTAssert(TableViewAd.adjustNonAdCell(index: 1, itemCount: itemCount, adCount: adCount, forStride: stride) == nil)
        XCTAssert(TableViewAd.adjustNonAdCell(index: 2, itemCount: itemCount, adCount: adCount, forStride: stride) == nil)
        
        XCTAssert(TableViewAd.adjustAdCell(index: 0, itemCount: itemCount, adCount: adCount, forStride: stride) == nil)
        XCTAssert(TableViewAd.adjustAdCell(index: 1, itemCount: itemCount, adCount: adCount, forStride: stride) == nil)
        XCTAssert(TableViewAd.adjustAdCell(index: 2, itemCount: itemCount, adCount: adCount, forStride: stride) == nil)
        
        XCTAssert(TableViewAd.isAdCellAt(index: 0, itemCount: itemCount, adCount: adCount, forStride: stride) == false)
        XCTAssert(TableViewAd.isAdCellAt(index: 1, itemCount: itemCount, adCount: adCount, forStride: stride) == false)
        XCTAssert(TableViewAd.isAdCellAt(index: 2, itemCount: itemCount, adCount: adCount, forStride: stride) == false)
        
        
        //--------------------
        //0
        itemCount = 1
        adCount = 0
        stride = 0
        
        XCTAssert(TableViewAd.adjustCount(itemCount: itemCount, adCount: adCount, forStride: stride) == 1)
        
        XCTAssert(TableViewAd.adjustNonAdCell(index: 0, itemCount: itemCount, adCount: adCount, forStride: stride) == 0)
        XCTAssert(TableViewAd.adjustNonAdCell(index: 1, itemCount: itemCount, adCount: adCount, forStride: stride) == nil)
        XCTAssert(TableViewAd.adjustNonAdCell(index: 2, itemCount: itemCount, adCount: adCount, forStride: stride) == nil)
        
        XCTAssert(TableViewAd.adjustAdCell(index: 0, itemCount: itemCount, adCount: adCount, forStride: stride) == nil)
        XCTAssert(TableViewAd.adjustAdCell(index: 1, itemCount: itemCount, adCount: adCount, forStride: stride) == nil)
        XCTAssert(TableViewAd.adjustAdCell(index: 2, itemCount: itemCount, adCount: adCount, forStride: stride) == nil)
        
        XCTAssert(TableViewAd.isAdCellAt(index: 0, itemCount: itemCount, adCount: adCount, forStride: stride) == false)
        XCTAssert(TableViewAd.isAdCellAt(index: 1, itemCount: itemCount, adCount: adCount, forStride: stride) == false)
        XCTAssert(TableViewAd.isAdCellAt(index: 2, itemCount: itemCount, adCount: adCount, forStride: stride) == false)
        
        
        //--------------------
        //0
        itemCount = 1
        adCount = 1
        stride = 0
        
        XCTAssert(TableViewAd.adjustCount(itemCount: itemCount, adCount: adCount, forStride: stride) == 1)
        
        XCTAssert(TableViewAd.adjustNonAdCell(index: 0, itemCount: itemCount, adCount: adCount, forStride: stride) == 0)
        XCTAssert(TableViewAd.adjustNonAdCell(index: 1, itemCount: itemCount, adCount: adCount, forStride: stride) == nil)
        XCTAssert(TableViewAd.adjustNonAdCell(index: 2, itemCount: itemCount, adCount: adCount, forStride: stride) == nil)
        
        XCTAssert(TableViewAd.adjustAdCell(index: 0, itemCount: itemCount, adCount: adCount, forStride: stride) == nil)
        XCTAssert(TableViewAd.adjustAdCell(index: 1, itemCount: itemCount, adCount: adCount, forStride: stride) == nil)
        XCTAssert(TableViewAd.adjustAdCell(index: 2, itemCount: itemCount, adCount: adCount, forStride: stride) == nil)
        
        XCTAssert(TableViewAd.isAdCellAt(index: 0, itemCount: itemCount, adCount: adCount, forStride: stride) == false)
        XCTAssert(TableViewAd.isAdCellAt(index: 1, itemCount: itemCount, adCount: adCount, forStride: stride) == false)
        XCTAssert(TableViewAd.isAdCellAt(index: 2, itemCount: itemCount, adCount: adCount, forStride: stride) == false)
        
        
        //--------------------
        //0 1
        itemCount = 1
        adCount = 1
        stride = 1
        
        XCTAssert(TableViewAd.adjustCount(itemCount: itemCount, adCount: adCount, forStride: stride) == 2)
        
        XCTAssert(TableViewAd.adjustNonAdCell(index: 0, itemCount: itemCount, adCount: adCount, forStride: stride) == 0)
        XCTAssert(TableViewAd.adjustNonAdCell(index: 1, itemCount: itemCount, adCount: adCount, forStride: stride) == nil)
        XCTAssert(TableViewAd.adjustNonAdCell(index: 2, itemCount: itemCount, adCount: adCount, forStride: stride) == nil)
        
        XCTAssert(TableViewAd.adjustAdCell(index: 0, itemCount: itemCount, adCount: adCount, forStride: stride) == nil)
        XCTAssert(TableViewAd.adjustAdCell(index: 1, itemCount: itemCount, adCount: adCount, forStride: stride) == 0)
        XCTAssert(TableViewAd.adjustAdCell(index: 2, itemCount: itemCount, adCount: adCount, forStride: stride) == nil)
        
        XCTAssert(TableViewAd.isAdCellAt(index: 0, itemCount: itemCount, adCount: adCount, forStride: stride) == false)
        XCTAssert(TableViewAd.isAdCellAt(index: 1, itemCount: itemCount, adCount: adCount, forStride: stride) == true)
        XCTAssert(TableViewAd.isAdCellAt(index: 2, itemCount: itemCount, adCount: adCount, forStride: stride) == false)
        
        
        //--------------------
        //0 1 0
        itemCount = 2
        adCount = 1
        stride = 1
        
        XCTAssert(TableViewAd.adjustCount(itemCount: itemCount, adCount: adCount, forStride: stride) == 3)
        
        XCTAssert(TableViewAd.adjustNonAdCell(index: 0, itemCount: itemCount, adCount: adCount, forStride: stride) == 0)
        XCTAssert(TableViewAd.adjustNonAdCell(index: 1, itemCount: itemCount, adCount: adCount, forStride: stride) == nil)
        XCTAssert(TableViewAd.adjustNonAdCell(index: 2, itemCount: itemCount, adCount: adCount, forStride: stride) == 1)
        
        XCTAssert(TableViewAd.adjustAdCell(index: 0, itemCount: itemCount, adCount: adCount, forStride: stride) == nil)
        XCTAssert(TableViewAd.adjustAdCell(index: 1, itemCount: itemCount, adCount: adCount, forStride: stride) == 0)
        XCTAssert(TableViewAd.adjustAdCell(index: 2, itemCount: itemCount, adCount: adCount, forStride: stride) == nil)
        
        XCTAssert(TableViewAd.isAdCellAt(index: 0, itemCount: itemCount, adCount: adCount, forStride: stride) == false)
        XCTAssert(TableViewAd.isAdCellAt(index: 1, itemCount: itemCount, adCount: adCount, forStride: stride) == true)
        XCTAssert(TableViewAd.isAdCellAt(index: 2, itemCount: itemCount, adCount: adCount, forStride: stride) == false)
        
        
        //--------------------
        //0 1 0 0 0 0
        itemCount = 5
        adCount = 1
        stride = 1
        
        XCTAssert(TableViewAd.adjustCount(itemCount: itemCount, adCount: adCount, forStride: stride) == 6)
        
        XCTAssert(TableViewAd.adjustNonAdCell(index: 0, itemCount: itemCount, adCount: adCount, forStride: stride) == 0)
        XCTAssert(TableViewAd.adjustNonAdCell(index: 1, itemCount: itemCount, adCount: adCount, forStride: stride) == nil)
        XCTAssert(TableViewAd.adjustNonAdCell(index: 2, itemCount: itemCount, adCount: adCount, forStride: stride) == 1)
        XCTAssert(TableViewAd.adjustNonAdCell(index: 3, itemCount: itemCount, adCount: adCount, forStride: stride) == 2)
        XCTAssert(TableViewAd.adjustNonAdCell(index: 4, itemCount: itemCount, adCount: adCount, forStride: stride) == 3)
        XCTAssert(TableViewAd.adjustNonAdCell(index: 5, itemCount: itemCount, adCount: adCount, forStride: stride) == 4)
        XCTAssert(TableViewAd.adjustNonAdCell(index: 6, itemCount: itemCount, adCount: adCount, forStride: stride) == nil)
        XCTAssert(TableViewAd.adjustNonAdCell(index: 7, itemCount: itemCount, adCount: adCount, forStride: stride) == nil)
        
        XCTAssert(TableViewAd.adjustAdCell(index: 0, itemCount: itemCount, adCount: adCount, forStride: stride) == nil)
        XCTAssert(TableViewAd.adjustAdCell(index: 1, itemCount: itemCount, adCount: adCount, forStride: stride) == 0)
        XCTAssert(TableViewAd.adjustAdCell(index: 2, itemCount: itemCount, adCount: adCount, forStride: stride) == nil)
        XCTAssert(TableViewAd.adjustAdCell(index: 3, itemCount: itemCount, adCount: adCount, forStride: stride) == nil)
        XCTAssert(TableViewAd.adjustAdCell(index: 4, itemCount: itemCount, adCount: adCount, forStride: stride) == nil)
        XCTAssert(TableViewAd.adjustAdCell(index: 5, itemCount: itemCount, adCount: adCount, forStride: stride) == nil)
        XCTAssert(TableViewAd.adjustAdCell(index: 6, itemCount: itemCount, adCount: adCount, forStride: stride) == nil)
        XCTAssert(TableViewAd.adjustAdCell(index: 7, itemCount: itemCount, adCount: adCount, forStride: stride) == nil)
        
        XCTAssert(TableViewAd.isAdCellAt(index: 0, itemCount: itemCount, adCount: adCount, forStride: stride) == false)
        XCTAssert(TableViewAd.isAdCellAt(index: 1, itemCount: itemCount, adCount: adCount, forStride: stride) == true)
        XCTAssert(TableViewAd.isAdCellAt(index: 2, itemCount: itemCount, adCount: adCount, forStride: stride) == false)
        XCTAssert(TableViewAd.isAdCellAt(index: 3, itemCount: itemCount, adCount: adCount, forStride: stride) == false)
        XCTAssert(TableViewAd.isAdCellAt(index: 4, itemCount: itemCount, adCount: adCount, forStride: stride) == false)
        XCTAssert(TableViewAd.isAdCellAt(index: 5, itemCount: itemCount, adCount: adCount, forStride: stride) == false)
        XCTAssert(TableViewAd.isAdCellAt(index: 6, itemCount: itemCount, adCount: adCount, forStride: stride) == false)
        XCTAssert(TableViewAd.isAdCellAt(index: 7, itemCount: itemCount, adCount: adCount, forStride: stride) == false)
        
        //--------------------
        //0 1 0 1 0 0 0
        itemCount = 5
        adCount = 2
        stride = 1
        
        XCTAssert(TableViewAd.adjustCount(itemCount: itemCount, adCount: adCount, forStride: stride) == 7)
        
        XCTAssert(TableViewAd.adjustNonAdCell(index: 0, itemCount: itemCount, adCount: adCount, forStride: stride) == 0)
        XCTAssert(TableViewAd.adjustNonAdCell(index: 1, itemCount: itemCount, adCount: adCount, forStride: stride) == nil)
        XCTAssert(TableViewAd.adjustNonAdCell(index: 2, itemCount: itemCount, adCount: adCount, forStride: stride) == 1)
        XCTAssert(TableViewAd.adjustNonAdCell(index: 3, itemCount: itemCount, adCount: adCount, forStride: stride) == nil)
        XCTAssert(TableViewAd.adjustNonAdCell(index: 4, itemCount: itemCount, adCount: adCount, forStride: stride) == 2)
        XCTAssert(TableViewAd.adjustNonAdCell(index: 5, itemCount: itemCount, adCount: adCount, forStride: stride) == 3)
        XCTAssert(TableViewAd.adjustNonAdCell(index: 6, itemCount: itemCount, adCount: adCount, forStride: stride) == 4)
        XCTAssert(TableViewAd.adjustNonAdCell(index: 7, itemCount: itemCount, adCount: adCount, forStride: stride) == nil)
        
        XCTAssert(TableViewAd.adjustAdCell(index: 0, itemCount: itemCount, adCount: adCount, forStride: stride) == nil)
        XCTAssert(TableViewAd.adjustAdCell(index: 1, itemCount: itemCount, adCount: adCount, forStride: stride) == 0)
        XCTAssert(TableViewAd.adjustAdCell(index: 2, itemCount: itemCount, adCount: adCount, forStride: stride) == nil)
        XCTAssert(TableViewAd.adjustAdCell(index: 3, itemCount: itemCount, adCount: adCount, forStride: stride) == 1)
        XCTAssert(TableViewAd.adjustAdCell(index: 4, itemCount: itemCount, adCount: adCount, forStride: stride) == nil)
        XCTAssert(TableViewAd.adjustAdCell(index: 5, itemCount: itemCount, adCount: adCount, forStride: stride) == nil)
        XCTAssert(TableViewAd.adjustAdCell(index: 6, itemCount: itemCount, adCount: adCount, forStride: stride) == nil)
        XCTAssert(TableViewAd.adjustAdCell(index: 7, itemCount: itemCount, adCount: adCount, forStride: stride) == nil)
        
        XCTAssert(TableViewAd.isAdCellAt(index: 0, itemCount: itemCount, adCount: adCount, forStride: stride) == false)
        XCTAssert(TableViewAd.isAdCellAt(index: 1, itemCount: itemCount, adCount: adCount, forStride: stride) == true)
        XCTAssert(TableViewAd.isAdCellAt(index: 2, itemCount: itemCount, adCount: adCount, forStride: stride) == false)
        XCTAssert(TableViewAd.isAdCellAt(index: 3, itemCount: itemCount, adCount: adCount, forStride: stride) == true)
        XCTAssert(TableViewAd.isAdCellAt(index: 4, itemCount: itemCount, adCount: adCount, forStride: stride) == false)
        XCTAssert(TableViewAd.isAdCellAt(index: 5, itemCount: itemCount, adCount: adCount, forStride: stride) == false)
        XCTAssert(TableViewAd.isAdCellAt(index: 6, itemCount: itemCount, adCount: adCount, forStride: stride) == false)
        XCTAssert(TableViewAd.isAdCellAt(index: 7, itemCount: itemCount, adCount: adCount, forStride: stride) == false)

        //--------------------
        //0 1 0 1 0 1 0 1 0 1
        itemCount = 5
        adCount = 5
        stride = 1
        
        XCTAssert(TableViewAd.adjustCount(itemCount: itemCount, adCount: adCount, forStride: stride) == 10)
        
        XCTAssert(TableViewAd.adjustNonAdCell(index: 0, itemCount: itemCount, adCount: adCount, forStride: stride) == 0)
        XCTAssert(TableViewAd.adjustNonAdCell(index: 1, itemCount: itemCount, adCount: adCount, forStride: stride) == nil)
        XCTAssert(TableViewAd.adjustNonAdCell(index: 2, itemCount: itemCount, adCount: adCount, forStride: stride) == 1)
        XCTAssert(TableViewAd.adjustNonAdCell(index: 3, itemCount: itemCount, adCount: adCount, forStride: stride) == nil)
        XCTAssert(TableViewAd.adjustNonAdCell(index: 4, itemCount: itemCount, adCount: adCount, forStride: stride) == 2)
        XCTAssert(TableViewAd.adjustNonAdCell(index: 5, itemCount: itemCount, adCount: adCount, forStride: stride) == nil)
        XCTAssert(TableViewAd.adjustNonAdCell(index: 6, itemCount: itemCount, adCount: adCount, forStride: stride) == 3)
        XCTAssert(TableViewAd.adjustNonAdCell(index: 7, itemCount: itemCount, adCount: adCount, forStride: stride) == nil)
        XCTAssert(TableViewAd.adjustNonAdCell(index: 8, itemCount: itemCount, adCount: adCount, forStride: stride) == 4)
        XCTAssert(TableViewAd.adjustNonAdCell(index: 9, itemCount: itemCount, adCount: adCount, forStride: stride) == nil)
        XCTAssert(TableViewAd.adjustNonAdCell(index: 10, itemCount: itemCount, adCount: adCount, forStride: stride) == nil)
        XCTAssert(TableViewAd.adjustNonAdCell(index: 11, itemCount: itemCount, adCount: adCount, forStride: stride) == nil)
        
        XCTAssert(TableViewAd.adjustAdCell(index: 0, itemCount: itemCount, adCount: adCount, forStride: stride) == nil)
        XCTAssert(TableViewAd.adjustAdCell(index: 1, itemCount: itemCount, adCount: adCount, forStride: stride) == 0)
        XCTAssert(TableViewAd.adjustAdCell(index: 2, itemCount: itemCount, adCount: adCount, forStride: stride) == nil)
        XCTAssert(TableViewAd.adjustAdCell(index: 3, itemCount: itemCount, adCount: adCount, forStride: stride) == 1)
        XCTAssert(TableViewAd.adjustAdCell(index: 4, itemCount: itemCount, adCount: adCount, forStride: stride) == nil)
        XCTAssert(TableViewAd.adjustAdCell(index: 5, itemCount: itemCount, adCount: adCount, forStride: stride) == 2)
        XCTAssert(TableViewAd.adjustAdCell(index: 6, itemCount: itemCount, adCount: adCount, forStride: stride) == nil)
        XCTAssert(TableViewAd.adjustAdCell(index: 7, itemCount: itemCount, adCount: adCount, forStride: stride) == 3)
        XCTAssert(TableViewAd.adjustAdCell(index: 8, itemCount: itemCount, adCount: adCount, forStride: stride) == nil)
        XCTAssert(TableViewAd.adjustAdCell(index: 9, itemCount: itemCount, adCount: adCount, forStride: stride) == 4)
        XCTAssert(TableViewAd.adjustAdCell(index: 10, itemCount: itemCount, adCount: adCount, forStride: stride) == nil)
        XCTAssert(TableViewAd.adjustAdCell(index: 11, itemCount: itemCount, adCount: adCount, forStride: stride) == nil)
        
        XCTAssert(TableViewAd.isAdCellAt(index: 0, itemCount: itemCount, adCount: adCount, forStride: stride) == false)
        XCTAssert(TableViewAd.isAdCellAt(index: 1, itemCount: itemCount, adCount: adCount, forStride: stride) == true)
        XCTAssert(TableViewAd.isAdCellAt(index: 2, itemCount: itemCount, adCount: adCount, forStride: stride) == false)
        XCTAssert(TableViewAd.isAdCellAt(index: 3, itemCount: itemCount, adCount: adCount, forStride: stride) == true)
        XCTAssert(TableViewAd.isAdCellAt(index: 4, itemCount: itemCount, adCount: adCount, forStride: stride) == false)
        XCTAssert(TableViewAd.isAdCellAt(index: 5, itemCount: itemCount, adCount: adCount, forStride: stride) == true)
        XCTAssert(TableViewAd.isAdCellAt(index: 6, itemCount: itemCount, adCount: adCount, forStride: stride) == false)
        XCTAssert(TableViewAd.isAdCellAt(index: 7, itemCount: itemCount, adCount: adCount, forStride: stride) == true)
        XCTAssert(TableViewAd.isAdCellAt(index: 8, itemCount: itemCount, adCount: adCount, forStride: stride) == false)
        XCTAssert(TableViewAd.isAdCellAt(index: 9, itemCount: itemCount, adCount: adCount, forStride: stride) == true)
        XCTAssert(TableViewAd.isAdCellAt(index: 10, itemCount: itemCount, adCount: adCount, forStride: stride) == false)
        XCTAssert(TableViewAd.isAdCellAt(index: 11, itemCount: itemCount, adCount: adCount, forStride: stride) == false)
        
        
        //--------------------
        //0 0 1 0 0 0
        itemCount = 5
        adCount = 1
        stride = 2
        
        XCTAssert(TableViewAd.adjustCount(itemCount: itemCount, adCount: adCount, forStride: stride) == 6)
        
        XCTAssert(TableViewAd.adjustNonAdCell(index: 0, itemCount: itemCount, adCount: adCount, forStride: stride) == 0)
        XCTAssert(TableViewAd.adjustNonAdCell(index: 1, itemCount: itemCount, adCount: adCount, forStride: stride) == 1)
        XCTAssert(TableViewAd.adjustNonAdCell(index: 2, itemCount: itemCount, adCount: adCount, forStride: stride) == nil)
        XCTAssert(TableViewAd.adjustNonAdCell(index: 3, itemCount: itemCount, adCount: adCount, forStride: stride) == 2)
        XCTAssert(TableViewAd.adjustNonAdCell(index: 4, itemCount: itemCount, adCount: adCount, forStride: stride) == 3)
        XCTAssert(TableViewAd.adjustNonAdCell(index: 5, itemCount: itemCount, adCount: adCount, forStride: stride) == 4)
        XCTAssert(TableViewAd.adjustNonAdCell(index: 6, itemCount: itemCount, adCount: adCount, forStride: stride) == nil)
        XCTAssert(TableViewAd.adjustNonAdCell(index: 7, itemCount: itemCount, adCount: adCount, forStride: stride) == nil)
        XCTAssert(TableViewAd.adjustNonAdCell(index: 8, itemCount: itemCount, adCount: adCount, forStride: stride) == nil)
        XCTAssert(TableViewAd.adjustNonAdCell(index: 9, itemCount: itemCount, adCount: adCount, forStride: stride) == nil)
        XCTAssert(TableViewAd.adjustNonAdCell(index: 10, itemCount: itemCount, adCount: adCount, forStride: stride) == nil)
        XCTAssert(TableViewAd.adjustNonAdCell(index: 11, itemCount: itemCount, adCount: adCount, forStride: stride) == nil)
        
        XCTAssert(TableViewAd.adjustAdCell(index: 0, itemCount: itemCount, adCount: adCount, forStride: stride) == nil)
        XCTAssert(TableViewAd.adjustAdCell(index: 1, itemCount: itemCount, adCount: adCount, forStride: stride) == nil)
        XCTAssert(TableViewAd.adjustAdCell(index: 2, itemCount: itemCount, adCount: adCount, forStride: stride) == 0)
        XCTAssert(TableViewAd.adjustAdCell(index: 3, itemCount: itemCount, adCount: adCount, forStride: stride) == nil)
        XCTAssert(TableViewAd.adjustAdCell(index: 4, itemCount: itemCount, adCount: adCount, forStride: stride) == nil)
        XCTAssert(TableViewAd.adjustAdCell(index: 5, itemCount: itemCount, adCount: adCount, forStride: stride) == nil)
        XCTAssert(TableViewAd.adjustAdCell(index: 6, itemCount: itemCount, adCount: adCount, forStride: stride) == nil)
        XCTAssert(TableViewAd.adjustAdCell(index: 7, itemCount: itemCount, adCount: adCount, forStride: stride) == nil)
        XCTAssert(TableViewAd.adjustAdCell(index: 8, itemCount: itemCount, adCount: adCount, forStride: stride) == nil)
        XCTAssert(TableViewAd.adjustAdCell(index: 9, itemCount: itemCount, adCount: adCount, forStride: stride) == nil)
        XCTAssert(TableViewAd.adjustAdCell(index: 10, itemCount: itemCount, adCount: adCount, forStride: stride) == nil)
        XCTAssert(TableViewAd.adjustAdCell(index: 11, itemCount: itemCount, adCount: adCount, forStride: stride) == nil)
        
        XCTAssert(TableViewAd.isAdCellAt(index: 0, itemCount: itemCount, adCount: adCount, forStride: stride) == false)
        XCTAssert(TableViewAd.isAdCellAt(index: 1, itemCount: itemCount, adCount: adCount, forStride: stride) == false)
        XCTAssert(TableViewAd.isAdCellAt(index: 2, itemCount: itemCount, adCount: adCount, forStride: stride) == true)
        XCTAssert(TableViewAd.isAdCellAt(index: 3, itemCount: itemCount, adCount: adCount, forStride: stride) == false)
        XCTAssert(TableViewAd.isAdCellAt(index: 4, itemCount: itemCount, adCount: adCount, forStride: stride) == false)
        XCTAssert(TableViewAd.isAdCellAt(index: 5, itemCount: itemCount, adCount: adCount, forStride: stride) == false)
        XCTAssert(TableViewAd.isAdCellAt(index: 6, itemCount: itemCount, adCount: adCount, forStride: stride) == false)
        XCTAssert(TableViewAd.isAdCellAt(index: 7, itemCount: itemCount, adCount: adCount, forStride: stride) == false)
        XCTAssert(TableViewAd.isAdCellAt(index: 8, itemCount: itemCount, adCount: adCount, forStride: stride) == false)
        XCTAssert(TableViewAd.isAdCellAt(index: 9, itemCount: itemCount, adCount: adCount, forStride: stride) == false)
        XCTAssert(TableViewAd.isAdCellAt(index: 10, itemCount: itemCount, adCount: adCount, forStride: stride) == false)
        XCTAssert(TableViewAd.isAdCellAt(index: 11, itemCount: itemCount, adCount: adCount, forStride: stride) == false)
        
        //--------------------
        //0 0 1 0 0 1 0
        itemCount = 5
        adCount = 2
        stride = 2
        
        XCTAssert(TableViewAd.adjustCount(itemCount: itemCount, adCount: adCount, forStride: stride) == 7)
        
        XCTAssert(TableViewAd.adjustNonAdCell(index: 0, itemCount: itemCount, adCount: adCount, forStride: stride) == 0)
        XCTAssert(TableViewAd.adjustNonAdCell(index: 1, itemCount: itemCount, adCount: adCount, forStride: stride) == 1)
        XCTAssert(TableViewAd.adjustNonAdCell(index: 2, itemCount: itemCount, adCount: adCount, forStride: stride) == nil)
        XCTAssert(TableViewAd.adjustNonAdCell(index: 3, itemCount: itemCount, adCount: adCount, forStride: stride) == 2)
        XCTAssert(TableViewAd.adjustNonAdCell(index: 4, itemCount: itemCount, adCount: adCount, forStride: stride) == 3)
        XCTAssert(TableViewAd.adjustNonAdCell(index: 5, itemCount: itemCount, adCount: adCount, forStride: stride) == nil)
        XCTAssert(TableViewAd.adjustNonAdCell(index: 6, itemCount: itemCount, adCount: adCount, forStride: stride) == 4)
        XCTAssert(TableViewAd.adjustNonAdCell(index: 7, itemCount: itemCount, adCount: adCount, forStride: stride) == nil)
        XCTAssert(TableViewAd.adjustNonAdCell(index: 8, itemCount: itemCount, adCount: adCount, forStride: stride) == nil)
        XCTAssert(TableViewAd.adjustNonAdCell(index: 9, itemCount: itemCount, adCount: adCount, forStride: stride) == nil)
        XCTAssert(TableViewAd.adjustNonAdCell(index: 10, itemCount: itemCount, adCount: adCount, forStride: stride) == nil)
        XCTAssert(TableViewAd.adjustNonAdCell(index: 11, itemCount: itemCount, adCount: adCount, forStride: stride) == nil)
        
        XCTAssert(TableViewAd.adjustAdCell(index: 0, itemCount: itemCount, adCount: adCount, forStride: stride) == nil)
        XCTAssert(TableViewAd.adjustAdCell(index: 1, itemCount: itemCount, adCount: adCount, forStride: stride) == nil)
        XCTAssert(TableViewAd.adjustAdCell(index: 2, itemCount: itemCount, adCount: adCount, forStride: stride) == 0)
        XCTAssert(TableViewAd.adjustAdCell(index: 3, itemCount: itemCount, adCount: adCount, forStride: stride) == nil)
        XCTAssert(TableViewAd.adjustAdCell(index: 4, itemCount: itemCount, adCount: adCount, forStride: stride) == nil)
        XCTAssert(TableViewAd.adjustAdCell(index: 5, itemCount: itemCount, adCount: adCount, forStride: stride) == 1)
        XCTAssert(TableViewAd.adjustAdCell(index: 6, itemCount: itemCount, adCount: adCount, forStride: stride) == nil)
        XCTAssert(TableViewAd.adjustAdCell(index: 7, itemCount: itemCount, adCount: adCount, forStride: stride) == nil)
        XCTAssert(TableViewAd.adjustAdCell(index: 8, itemCount: itemCount, adCount: adCount, forStride: stride) == nil)
        XCTAssert(TableViewAd.adjustAdCell(index: 9, itemCount: itemCount, adCount: adCount, forStride: stride) == nil)
        XCTAssert(TableViewAd.adjustAdCell(index: 10, itemCount: itemCount, adCount: adCount, forStride: stride) == nil)
        XCTAssert(TableViewAd.adjustAdCell(index: 11, itemCount: itemCount, adCount: adCount, forStride: stride) == nil)
        
        XCTAssert(TableViewAd.isAdCellAt(index: 0, itemCount: itemCount, adCount: adCount, forStride: stride) == false)
        XCTAssert(TableViewAd.isAdCellAt(index: 1, itemCount: itemCount, adCount: adCount, forStride: stride) == false)
        XCTAssert(TableViewAd.isAdCellAt(index: 2, itemCount: itemCount, adCount: adCount, forStride: stride) == true)
        XCTAssert(TableViewAd.isAdCellAt(index: 3, itemCount: itemCount, adCount: adCount, forStride: stride) == false)
        XCTAssert(TableViewAd.isAdCellAt(index: 4, itemCount: itemCount, adCount: adCount, forStride: stride) == false)
        XCTAssert(TableViewAd.isAdCellAt(index: 5, itemCount: itemCount, adCount: adCount, forStride: stride) == true)
        XCTAssert(TableViewAd.isAdCellAt(index: 6, itemCount: itemCount, adCount: adCount, forStride: stride) == false)
        XCTAssert(TableViewAd.isAdCellAt(index: 7, itemCount: itemCount, adCount: adCount, forStride: stride) == false)
        XCTAssert(TableViewAd.isAdCellAt(index: 8, itemCount: itemCount, adCount: adCount, forStride: stride) == false)
        XCTAssert(TableViewAd.isAdCellAt(index: 9, itemCount: itemCount, adCount: adCount, forStride: stride) == false)
        XCTAssert(TableViewAd.isAdCellAt(index: 10, itemCount: itemCount, adCount: adCount, forStride: stride) == false)
        XCTAssert(TableViewAd.isAdCellAt(index: 11, itemCount: itemCount, adCount: adCount, forStride: stride) == false)
        
        //--------------------
        //0 0 1 0 0 1 0
        itemCount = 5
        adCount = 4
        stride = 2
        
        XCTAssert(TableViewAd.adjustCount(itemCount: itemCount, adCount: adCount, forStride: stride) == 7)
        
        XCTAssert(TableViewAd.adjustNonAdCell(index: 0, itemCount: itemCount, adCount: adCount, forStride: stride) == 0)
        XCTAssert(TableViewAd.adjustNonAdCell(index: 1, itemCount: itemCount, adCount: adCount, forStride: stride) == 1)
        XCTAssert(TableViewAd.adjustNonAdCell(index: 2, itemCount: itemCount, adCount: adCount, forStride: stride) == nil)
        XCTAssert(TableViewAd.adjustNonAdCell(index: 3, itemCount: itemCount, adCount: adCount, forStride: stride) == 2)
        XCTAssert(TableViewAd.adjustNonAdCell(index: 4, itemCount: itemCount, adCount: adCount, forStride: stride) == 3)
        XCTAssert(TableViewAd.adjustNonAdCell(index: 5, itemCount: itemCount, adCount: adCount, forStride: stride) == nil)
        XCTAssert(TableViewAd.adjustNonAdCell(index: 6, itemCount: itemCount, adCount: adCount, forStride: stride) == 4)
        XCTAssert(TableViewAd.adjustNonAdCell(index: 7, itemCount: itemCount, adCount: adCount, forStride: stride) == nil)
        XCTAssert(TableViewAd.adjustNonAdCell(index: 8, itemCount: itemCount, adCount: adCount, forStride: stride) == nil)
        XCTAssert(TableViewAd.adjustNonAdCell(index: 9, itemCount: itemCount, adCount: adCount, forStride: stride) == nil)
        XCTAssert(TableViewAd.adjustNonAdCell(index: 10, itemCount: itemCount, adCount: adCount, forStride: stride) == nil)
        XCTAssert(TableViewAd.adjustNonAdCell(index: 11, itemCount: itemCount, adCount: adCount, forStride: stride) == nil)
        
        XCTAssert(TableViewAd.adjustAdCell(index: 0, itemCount: itemCount, adCount: adCount, forStride: stride) == nil)
        XCTAssert(TableViewAd.adjustAdCell(index: 1, itemCount: itemCount, adCount: adCount, forStride: stride) == nil)
        XCTAssert(TableViewAd.adjustAdCell(index: 2, itemCount: itemCount, adCount: adCount, forStride: stride) == 0)
        XCTAssert(TableViewAd.adjustAdCell(index: 3, itemCount: itemCount, adCount: adCount, forStride: stride) == nil)
        XCTAssert(TableViewAd.adjustAdCell(index: 4, itemCount: itemCount, adCount: adCount, forStride: stride) == nil)
        XCTAssert(TableViewAd.adjustAdCell(index: 5, itemCount: itemCount, adCount: adCount, forStride: stride) == 1)
        XCTAssert(TableViewAd.adjustAdCell(index: 6, itemCount: itemCount, adCount: adCount, forStride: stride) == nil)
        XCTAssert(TableViewAd.adjustAdCell(index: 7, itemCount: itemCount, adCount: adCount, forStride: stride) == nil)
        XCTAssert(TableViewAd.adjustAdCell(index: 8, itemCount: itemCount, adCount: adCount, forStride: stride) == nil)
        XCTAssert(TableViewAd.adjustAdCell(index: 9, itemCount: itemCount, adCount: adCount, forStride: stride) == nil)
        XCTAssert(TableViewAd.adjustAdCell(index: 10, itemCount: itemCount, adCount: adCount, forStride: stride) == nil)
        XCTAssert(TableViewAd.adjustAdCell(index: 11, itemCount: itemCount, adCount: adCount, forStride: stride) == nil)
        
        XCTAssert(TableViewAd.isAdCellAt(index: 0, itemCount: itemCount, adCount: adCount, forStride: stride) == false)
        XCTAssert(TableViewAd.isAdCellAt(index: 1, itemCount: itemCount, adCount: adCount, forStride: stride) == false)
        XCTAssert(TableViewAd.isAdCellAt(index: 2, itemCount: itemCount, adCount: adCount, forStride: stride) == true)
        XCTAssert(TableViewAd.isAdCellAt(index: 3, itemCount: itemCount, adCount: adCount, forStride: stride) == false)
        XCTAssert(TableViewAd.isAdCellAt(index: 4, itemCount: itemCount, adCount: adCount, forStride: stride) == false)
        XCTAssert(TableViewAd.isAdCellAt(index: 5, itemCount: itemCount, adCount: adCount, forStride: stride) == true)
        XCTAssert(TableViewAd.isAdCellAt(index: 6, itemCount: itemCount, adCount: adCount, forStride: stride) == false)
        XCTAssert(TableViewAd.isAdCellAt(index: 7, itemCount: itemCount, adCount: adCount, forStride: stride) == false)
        XCTAssert(TableViewAd.isAdCellAt(index: 8, itemCount: itemCount, adCount: adCount, forStride: stride) == false)
        XCTAssert(TableViewAd.isAdCellAt(index: 9, itemCount: itemCount, adCount: adCount, forStride: stride) == false)
        XCTAssert(TableViewAd.isAdCellAt(index: 10, itemCount: itemCount, adCount: adCount, forStride: stride) == false)
        XCTAssert(TableViewAd.isAdCellAt(index: 11, itemCount: itemCount, adCount: adCount, forStride: stride) == false)
        
        //--------------------
        //0 0 1 0 0 1 0 0 1
        itemCount = 6
        adCount = 4
        stride = 2
        
        XCTAssert(TableViewAd.adjustCount(itemCount: itemCount, adCount: adCount, forStride: stride) == 9)
        
        XCTAssert(TableViewAd.adjustNonAdCell(index: 0, itemCount: itemCount, adCount: adCount, forStride: stride) == 0)
        XCTAssert(TableViewAd.adjustNonAdCell(index: 1, itemCount: itemCount, adCount: adCount, forStride: stride) == 1)
        XCTAssert(TableViewAd.adjustNonAdCell(index: 2, itemCount: itemCount, adCount: adCount, forStride: stride) == nil)
        XCTAssert(TableViewAd.adjustNonAdCell(index: 3, itemCount: itemCount, adCount: adCount, forStride: stride) == 2)
        XCTAssert(TableViewAd.adjustNonAdCell(index: 4, itemCount: itemCount, adCount: adCount, forStride: stride) == 3)
        XCTAssert(TableViewAd.adjustNonAdCell(index: 5, itemCount: itemCount, adCount: adCount, forStride: stride) == nil)
        XCTAssert(TableViewAd.adjustNonAdCell(index: 6, itemCount: itemCount, adCount: adCount, forStride: stride) == 4)
        XCTAssert(TableViewAd.adjustNonAdCell(index: 7, itemCount: itemCount, adCount: adCount, forStride: stride) == 5)
        XCTAssert(TableViewAd.adjustNonAdCell(index: 8, itemCount: itemCount, adCount: adCount, forStride: stride) == nil)
        XCTAssert(TableViewAd.adjustNonAdCell(index: 9, itemCount: itemCount, adCount: adCount, forStride: stride) == nil)
        XCTAssert(TableViewAd.adjustNonAdCell(index: 10, itemCount: itemCount, adCount: adCount, forStride: stride) == nil)
        XCTAssert(TableViewAd.adjustNonAdCell(index: 11, itemCount: itemCount, adCount: adCount, forStride: stride) == nil)
        
        XCTAssert(TableViewAd.adjustAdCell(index: 0, itemCount: itemCount, adCount: adCount, forStride: stride) == nil)
        XCTAssert(TableViewAd.adjustAdCell(index: 1, itemCount: itemCount, adCount: adCount, forStride: stride) == nil)
        XCTAssert(TableViewAd.adjustAdCell(index: 2, itemCount: itemCount, adCount: adCount, forStride: stride) == 0)
        XCTAssert(TableViewAd.adjustAdCell(index: 3, itemCount: itemCount, adCount: adCount, forStride: stride) == nil)
        XCTAssert(TableViewAd.adjustAdCell(index: 4, itemCount: itemCount, adCount: adCount, forStride: stride) == nil)
        XCTAssert(TableViewAd.adjustAdCell(index: 5, itemCount: itemCount, adCount: adCount, forStride: stride) == 1)
        XCTAssert(TableViewAd.adjustAdCell(index: 6, itemCount: itemCount, adCount: adCount, forStride: stride) == nil)
        XCTAssert(TableViewAd.adjustAdCell(index: 7, itemCount: itemCount, adCount: adCount, forStride: stride) == nil)
        XCTAssert(TableViewAd.adjustAdCell(index: 8, itemCount: itemCount, adCount: adCount, forStride: stride) == 2)
        XCTAssert(TableViewAd.adjustAdCell(index: 9, itemCount: itemCount, adCount: adCount, forStride: stride) == nil)
        XCTAssert(TableViewAd.adjustAdCell(index: 10, itemCount: itemCount, adCount: adCount, forStride: stride) == nil)
        XCTAssert(TableViewAd.adjustAdCell(index: 11, itemCount: itemCount, adCount: adCount, forStride: stride) == nil)
        
        XCTAssert(TableViewAd.isAdCellAt(index: 0, itemCount: itemCount, adCount: adCount, forStride: stride) == false)
        XCTAssert(TableViewAd.isAdCellAt(index: 1, itemCount: itemCount, adCount: adCount, forStride: stride) == false)
        XCTAssert(TableViewAd.isAdCellAt(index: 2, itemCount: itemCount, adCount: adCount, forStride: stride) == true)
        XCTAssert(TableViewAd.isAdCellAt(index: 3, itemCount: itemCount, adCount: adCount, forStride: stride) == false)
        XCTAssert(TableViewAd.isAdCellAt(index: 4, itemCount: itemCount, adCount: adCount, forStride: stride) == false)
        XCTAssert(TableViewAd.isAdCellAt(index: 5, itemCount: itemCount, adCount: adCount, forStride: stride) == true)
        XCTAssert(TableViewAd.isAdCellAt(index: 6, itemCount: itemCount, adCount: adCount, forStride: stride) == false)
        XCTAssert(TableViewAd.isAdCellAt(index: 7, itemCount: itemCount, adCount: adCount, forStride: stride) == false)
        XCTAssert(TableViewAd.isAdCellAt(index: 8, itemCount: itemCount, adCount: adCount, forStride: stride) == true)
        XCTAssert(TableViewAd.isAdCellAt(index: 9, itemCount: itemCount, adCount: adCount, forStride: stride) == false)
        XCTAssert(TableViewAd.isAdCellAt(index: 10, itemCount: itemCount, adCount: adCount, forStride: stride) == false)
        XCTAssert(TableViewAd.isAdCellAt(index: 11, itemCount: itemCount, adCount: adCount, forStride: stride) == false)
        
        //--------------------
        //0 0 1 0 0 1 0 0
        itemCount = 6
        adCount = 2
        stride = 2
        
        XCTAssert(TableViewAd.adjustCount(itemCount: itemCount, adCount: adCount, forStride: stride) == 8)
        
        XCTAssert(TableViewAd.adjustNonAdCell(index: 0, itemCount: itemCount, adCount: adCount, forStride: stride) == 0)
        XCTAssert(TableViewAd.adjustNonAdCell(index: 1, itemCount: itemCount, adCount: adCount, forStride: stride) == 1)
        XCTAssert(TableViewAd.adjustNonAdCell(index: 2, itemCount: itemCount, adCount: adCount, forStride: stride) == nil)
        XCTAssert(TableViewAd.adjustNonAdCell(index: 3, itemCount: itemCount, adCount: adCount, forStride: stride) == 2)
        XCTAssert(TableViewAd.adjustNonAdCell(index: 4, itemCount: itemCount, adCount: adCount, forStride: stride) == 3)
        XCTAssert(TableViewAd.adjustNonAdCell(index: 5, itemCount: itemCount, adCount: adCount, forStride: stride) == nil)
        XCTAssert(TableViewAd.adjustNonAdCell(index: 6, itemCount: itemCount, adCount: adCount, forStride: stride) == 4)
        XCTAssert(TableViewAd.adjustNonAdCell(index: 7, itemCount: itemCount, adCount: adCount, forStride: stride) == 5)
        XCTAssert(TableViewAd.adjustNonAdCell(index: 8, itemCount: itemCount, adCount: adCount, forStride: stride) == nil)
        XCTAssert(TableViewAd.adjustNonAdCell(index: 9, itemCount: itemCount, adCount: adCount, forStride: stride) == nil)
        XCTAssert(TableViewAd.adjustNonAdCell(index: 10, itemCount: itemCount, adCount: adCount, forStride: stride) == nil)
        XCTAssert(TableViewAd.adjustNonAdCell(index: 11, itemCount: itemCount, adCount: adCount, forStride: stride) == nil)
        
        XCTAssert(TableViewAd.adjustAdCell(index: 0, itemCount: itemCount, adCount: adCount, forStride: stride) == nil)
        XCTAssert(TableViewAd.adjustAdCell(index: 1, itemCount: itemCount, adCount: adCount, forStride: stride) == nil)
        XCTAssert(TableViewAd.adjustAdCell(index: 2, itemCount: itemCount, adCount: adCount, forStride: stride) == 0)
        XCTAssert(TableViewAd.adjustAdCell(index: 3, itemCount: itemCount, adCount: adCount, forStride: stride) == nil)
        XCTAssert(TableViewAd.adjustAdCell(index: 4, itemCount: itemCount, adCount: adCount, forStride: stride) == nil)
        XCTAssert(TableViewAd.adjustAdCell(index: 5, itemCount: itemCount, adCount: adCount, forStride: stride) == 1)
        XCTAssert(TableViewAd.adjustAdCell(index: 6, itemCount: itemCount, adCount: adCount, forStride: stride) == nil)
        XCTAssert(TableViewAd.adjustAdCell(index: 7, itemCount: itemCount, adCount: adCount, forStride: stride) == nil)
        XCTAssert(TableViewAd.adjustAdCell(index: 8, itemCount: itemCount, adCount: adCount, forStride: stride) == nil)
        XCTAssert(TableViewAd.adjustAdCell(index: 9, itemCount: itemCount, adCount: adCount, forStride: stride) == nil)
        XCTAssert(TableViewAd.adjustAdCell(index: 10, itemCount: itemCount, adCount: adCount, forStride: stride) == nil)
        XCTAssert(TableViewAd.adjustAdCell(index: 11, itemCount: itemCount, adCount: adCount, forStride: stride) == nil)
        
        XCTAssert(TableViewAd.isAdCellAt(index: 0, itemCount: itemCount, adCount: adCount, forStride: stride) == false)
        XCTAssert(TableViewAd.isAdCellAt(index: 1, itemCount: itemCount, adCount: adCount, forStride: stride) == false)
        XCTAssert(TableViewAd.isAdCellAt(index: 2, itemCount: itemCount, adCount: adCount, forStride: stride) == true)
        XCTAssert(TableViewAd.isAdCellAt(index: 3, itemCount: itemCount, adCount: adCount, forStride: stride) == false)
        XCTAssert(TableViewAd.isAdCellAt(index: 4, itemCount: itemCount, adCount: adCount, forStride: stride) == false)
        XCTAssert(TableViewAd.isAdCellAt(index: 5, itemCount: itemCount, adCount: adCount, forStride: stride) == true)
        XCTAssert(TableViewAd.isAdCellAt(index: 6, itemCount: itemCount, adCount: adCount, forStride: stride) == false)
        XCTAssert(TableViewAd.isAdCellAt(index: 7, itemCount: itemCount, adCount: adCount, forStride: stride) == false)
        XCTAssert(TableViewAd.isAdCellAt(index: 8, itemCount: itemCount, adCount: adCount, forStride: stride) == false)
        XCTAssert(TableViewAd.isAdCellAt(index: 9, itemCount: itemCount, adCount: adCount, forStride: stride) == false)
        XCTAssert(TableViewAd.isAdCellAt(index: 10, itemCount: itemCount, adCount: adCount, forStride: stride) == false)
        XCTAssert(TableViewAd.isAdCellAt(index: 11, itemCount: itemCount, adCount: adCount, forStride: stride) == false)
        
        //--------------------
        //0 0 0 1 0 0
        itemCount = 5
        adCount = 4
        stride = 3
        
        XCTAssert(TableViewAd.adjustCount(itemCount: itemCount, adCount: adCount, forStride: stride) == 6)
        
        XCTAssert(TableViewAd.adjustNonAdCell(index: 0, itemCount: itemCount, adCount: adCount, forStride: stride) == 0)
        XCTAssert(TableViewAd.adjustNonAdCell(index: 1, itemCount: itemCount, adCount: adCount, forStride: stride) == 1)
        XCTAssert(TableViewAd.adjustNonAdCell(index: 2, itemCount: itemCount, adCount: adCount, forStride: stride) == 2)
        XCTAssert(TableViewAd.adjustNonAdCell(index: 3, itemCount: itemCount, adCount: adCount, forStride: stride) == nil)
        XCTAssert(TableViewAd.adjustNonAdCell(index: 4, itemCount: itemCount, adCount: adCount, forStride: stride) == 3)
        XCTAssert(TableViewAd.adjustNonAdCell(index: 5, itemCount: itemCount, adCount: adCount, forStride: stride) == 4)
        XCTAssert(TableViewAd.adjustNonAdCell(index: 6, itemCount: itemCount, adCount: adCount, forStride: stride) == nil)
        XCTAssert(TableViewAd.adjustNonAdCell(index: 7, itemCount: itemCount, adCount: adCount, forStride: stride) == nil)
        XCTAssert(TableViewAd.adjustNonAdCell(index: 8, itemCount: itemCount, adCount: adCount, forStride: stride) == nil)
        XCTAssert(TableViewAd.adjustNonAdCell(index: 9, itemCount: itemCount, adCount: adCount, forStride: stride) == nil)
        XCTAssert(TableViewAd.adjustNonAdCell(index: 10, itemCount: itemCount, adCount: adCount, forStride: stride) == nil)
        XCTAssert(TableViewAd.adjustNonAdCell(index: 11, itemCount: itemCount, adCount: adCount, forStride: stride) == nil)
        
        XCTAssert(TableViewAd.adjustAdCell(index: 0, itemCount: itemCount, adCount: adCount, forStride: stride) == nil)
        XCTAssert(TableViewAd.adjustAdCell(index: 1, itemCount: itemCount, adCount: adCount, forStride: stride) == nil)
        XCTAssert(TableViewAd.adjustAdCell(index: 2, itemCount: itemCount, adCount: adCount, forStride: stride) == nil)
        XCTAssert(TableViewAd.adjustAdCell(index: 3, itemCount: itemCount, adCount: adCount, forStride: stride) == 0)
        XCTAssert(TableViewAd.adjustAdCell(index: 4, itemCount: itemCount, adCount: adCount, forStride: stride) == nil)
        XCTAssert(TableViewAd.adjustAdCell(index: 5, itemCount: itemCount, adCount: adCount, forStride: stride) == nil)
        XCTAssert(TableViewAd.adjustAdCell(index: 6, itemCount: itemCount, adCount: adCount, forStride: stride) == nil)
        XCTAssert(TableViewAd.adjustAdCell(index: 7, itemCount: itemCount, adCount: adCount, forStride: stride) == nil)
        XCTAssert(TableViewAd.adjustAdCell(index: 8, itemCount: itemCount, adCount: adCount, forStride: stride) == nil)
        XCTAssert(TableViewAd.adjustAdCell(index: 9, itemCount: itemCount, adCount: adCount, forStride: stride) == nil)
        XCTAssert(TableViewAd.adjustAdCell(index: 10, itemCount: itemCount, adCount: adCount, forStride: stride) == nil)
        XCTAssert(TableViewAd.adjustAdCell(index: 11, itemCount: itemCount, adCount: adCount, forStride: stride) == nil)
        
        XCTAssert(TableViewAd.isAdCellAt(index: 0, itemCount: itemCount, adCount: adCount, forStride: stride) == false)
        XCTAssert(TableViewAd.isAdCellAt(index: 1, itemCount: itemCount, adCount: adCount, forStride: stride) == false)
        XCTAssert(TableViewAd.isAdCellAt(index: 2, itemCount: itemCount, adCount: adCount, forStride: stride) == false)
        XCTAssert(TableViewAd.isAdCellAt(index: 3, itemCount: itemCount, adCount: adCount, forStride: stride) == true)
        XCTAssert(TableViewAd.isAdCellAt(index: 4, itemCount: itemCount, adCount: adCount, forStride: stride) == false)
        XCTAssert(TableViewAd.isAdCellAt(index: 5, itemCount: itemCount, adCount: adCount, forStride: stride) == false)
        XCTAssert(TableViewAd.isAdCellAt(index: 6, itemCount: itemCount, adCount: adCount, forStride: stride) == false)
        XCTAssert(TableViewAd.isAdCellAt(index: 7, itemCount: itemCount, adCount: adCount, forStride: stride) == false)
        XCTAssert(TableViewAd.isAdCellAt(index: 8, itemCount: itemCount, adCount: adCount, forStride: stride) == false)
        XCTAssert(TableViewAd.isAdCellAt(index: 9, itemCount: itemCount, adCount: adCount, forStride: stride) == false)
        XCTAssert(TableViewAd.isAdCellAt(index: 10, itemCount: itemCount, adCount: adCount, forStride: stride) == false)
        XCTAssert(TableViewAd.isAdCellAt(index: 11, itemCount: itemCount, adCount: adCount, forStride: stride) == false)
        
        //--------------------
        //0 0 0 1 0 0 0 1
        itemCount = 6
        adCount = 4
        stride = 3
        
        XCTAssert(TableViewAd.adjustCount(itemCount: itemCount, adCount: adCount, forStride: stride) == 8)
        
        XCTAssert(TableViewAd.adjustNonAdCell(index: 0, itemCount: itemCount, adCount: adCount, forStride: stride) == 0)
        XCTAssert(TableViewAd.adjustNonAdCell(index: 1, itemCount: itemCount, adCount: adCount, forStride: stride) == 1)
        XCTAssert(TableViewAd.adjustNonAdCell(index: 2, itemCount: itemCount, adCount: adCount, forStride: stride) == 2)
        XCTAssert(TableViewAd.adjustNonAdCell(index: 3, itemCount: itemCount, adCount: adCount, forStride: stride) == nil)
        XCTAssert(TableViewAd.adjustNonAdCell(index: 4, itemCount: itemCount, adCount: adCount, forStride: stride) == 3)
        XCTAssert(TableViewAd.adjustNonAdCell(index: 5, itemCount: itemCount, adCount: adCount, forStride: stride) == 4)
        XCTAssert(TableViewAd.adjustNonAdCell(index: 6, itemCount: itemCount, adCount: adCount, forStride: stride) == 5)
        XCTAssert(TableViewAd.adjustNonAdCell(index: 7, itemCount: itemCount, adCount: adCount, forStride: stride) == nil)
        XCTAssert(TableViewAd.adjustNonAdCell(index: 8, itemCount: itemCount, adCount: adCount, forStride: stride) == nil)
        XCTAssert(TableViewAd.adjustNonAdCell(index: 9, itemCount: itemCount, adCount: adCount, forStride: stride) == nil)
        XCTAssert(TableViewAd.adjustNonAdCell(index: 10, itemCount: itemCount, adCount: adCount, forStride: stride) == nil)
        XCTAssert(TableViewAd.adjustNonAdCell(index: 11, itemCount: itemCount, adCount: adCount, forStride: stride) == nil)
        
        XCTAssert(TableViewAd.adjustAdCell(index: 0, itemCount: itemCount, adCount: adCount, forStride: stride) == nil)
        XCTAssert(TableViewAd.adjustAdCell(index: 1, itemCount: itemCount, adCount: adCount, forStride: stride) == nil)
        XCTAssert(TableViewAd.adjustAdCell(index: 2, itemCount: itemCount, adCount: adCount, forStride: stride) == nil)
        XCTAssert(TableViewAd.adjustAdCell(index: 3, itemCount: itemCount, adCount: adCount, forStride: stride) == 0)
        XCTAssert(TableViewAd.adjustAdCell(index: 4, itemCount: itemCount, adCount: adCount, forStride: stride) == nil)
        XCTAssert(TableViewAd.adjustAdCell(index: 5, itemCount: itemCount, adCount: adCount, forStride: stride) == nil)
        XCTAssert(TableViewAd.adjustAdCell(index: 6, itemCount: itemCount, adCount: adCount, forStride: stride) == nil)
        XCTAssert(TableViewAd.adjustAdCell(index: 7, itemCount: itemCount, adCount: adCount, forStride: stride) == 1)
        XCTAssert(TableViewAd.adjustAdCell(index: 8, itemCount: itemCount, adCount: adCount, forStride: stride) == nil)
        XCTAssert(TableViewAd.adjustAdCell(index: 9, itemCount: itemCount, adCount: adCount, forStride: stride) == nil)
        XCTAssert(TableViewAd.adjustAdCell(index: 10, itemCount: itemCount, adCount: adCount, forStride: stride) == nil)
        XCTAssert(TableViewAd.adjustAdCell(index: 11, itemCount: itemCount, adCount: adCount, forStride: stride) == nil)
        
        XCTAssert(TableViewAd.isAdCellAt(index: 0, itemCount: itemCount, adCount: adCount, forStride: stride) == false)
        XCTAssert(TableViewAd.isAdCellAt(index: 1, itemCount: itemCount, adCount: adCount, forStride: stride) == false)
        XCTAssert(TableViewAd.isAdCellAt(index: 2, itemCount: itemCount, adCount: adCount, forStride: stride) == false)
        XCTAssert(TableViewAd.isAdCellAt(index: 3, itemCount: itemCount, adCount: adCount, forStride: stride) == true)
        XCTAssert(TableViewAd.isAdCellAt(index: 4, itemCount: itemCount, adCount: adCount, forStride: stride) == false)
        XCTAssert(TableViewAd.isAdCellAt(index: 5, itemCount: itemCount, adCount: adCount, forStride: stride) == false)
        XCTAssert(TableViewAd.isAdCellAt(index: 6, itemCount: itemCount, adCount: adCount, forStride: stride) == false)
        XCTAssert(TableViewAd.isAdCellAt(index: 7, itemCount: itemCount, adCount: adCount, forStride: stride) == true)
        XCTAssert(TableViewAd.isAdCellAt(index: 8, itemCount: itemCount, adCount: adCount, forStride: stride) == false)
        XCTAssert(TableViewAd.isAdCellAt(index: 9, itemCount: itemCount, adCount: adCount, forStride: stride) == false)
        XCTAssert(TableViewAd.isAdCellAt(index: 10, itemCount: itemCount, adCount: adCount, forStride: stride) == false)
        XCTAssert(TableViewAd.isAdCellAt(index: 11, itemCount: itemCount, adCount: adCount, forStride: stride) == false)

        
        //--------------------
        //0 0 0 1 0 0 0 1 0
        itemCount = 7
        adCount = 4
        stride = 3
        
        XCTAssert(TableViewAd.adjustCount(itemCount: itemCount, adCount: adCount, forStride: stride) == 9)
        
        XCTAssert(TableViewAd.adjustNonAdCell(index: 0, itemCount: itemCount, adCount: adCount, forStride: stride) == 0)
        XCTAssert(TableViewAd.adjustNonAdCell(index: 1, itemCount: itemCount, adCount: adCount, forStride: stride) == 1)
        XCTAssert(TableViewAd.adjustNonAdCell(index: 2, itemCount: itemCount, adCount: adCount, forStride: stride) == 2)
        XCTAssert(TableViewAd.adjustNonAdCell(index: 3, itemCount: itemCount, adCount: adCount, forStride: stride) == nil)
        XCTAssert(TableViewAd.adjustNonAdCell(index: 4, itemCount: itemCount, adCount: adCount, forStride: stride) == 3)
        XCTAssert(TableViewAd.adjustNonAdCell(index: 5, itemCount: itemCount, adCount: adCount, forStride: stride) == 4)
        XCTAssert(TableViewAd.adjustNonAdCell(index: 6, itemCount: itemCount, adCount: adCount, forStride: stride) == 5)
        XCTAssert(TableViewAd.adjustNonAdCell(index: 7, itemCount: itemCount, adCount: adCount, forStride: stride) == nil)
        XCTAssert(TableViewAd.adjustNonAdCell(index: 8, itemCount: itemCount, adCount: adCount, forStride: stride) == 6)
        XCTAssert(TableViewAd.adjustNonAdCell(index: 9, itemCount: itemCount, adCount: adCount, forStride: stride) == nil)
        XCTAssert(TableViewAd.adjustNonAdCell(index: 10, itemCount: itemCount, adCount: adCount, forStride: stride) == nil)
        XCTAssert(TableViewAd.adjustNonAdCell(index: 11, itemCount: itemCount, adCount: adCount, forStride: stride) == nil)
        
        XCTAssert(TableViewAd.adjustAdCell(index: 0, itemCount: itemCount, adCount: adCount, forStride: stride) == nil)
        XCTAssert(TableViewAd.adjustAdCell(index: 1, itemCount: itemCount, adCount: adCount, forStride: stride) == nil)
        XCTAssert(TableViewAd.adjustAdCell(index: 2, itemCount: itemCount, adCount: adCount, forStride: stride) == nil)
        XCTAssert(TableViewAd.adjustAdCell(index: 3, itemCount: itemCount, adCount: adCount, forStride: stride) == 0)
        XCTAssert(TableViewAd.adjustAdCell(index: 4, itemCount: itemCount, adCount: adCount, forStride: stride) == nil)
        XCTAssert(TableViewAd.adjustAdCell(index: 5, itemCount: itemCount, adCount: adCount, forStride: stride) == nil)
        XCTAssert(TableViewAd.adjustAdCell(index: 6, itemCount: itemCount, adCount: adCount, forStride: stride) == nil)
        XCTAssert(TableViewAd.adjustAdCell(index: 7, itemCount: itemCount, adCount: adCount, forStride: stride) == 1)
        XCTAssert(TableViewAd.adjustAdCell(index: 8, itemCount: itemCount, adCount: adCount, forStride: stride) == nil)
        XCTAssert(TableViewAd.adjustAdCell(index: 9, itemCount: itemCount, adCount: adCount, forStride: stride) == nil)
        XCTAssert(TableViewAd.adjustAdCell(index: 10, itemCount: itemCount, adCount: adCount, forStride: stride) == nil)
        XCTAssert(TableViewAd.adjustAdCell(index: 11, itemCount: itemCount, adCount: adCount, forStride: stride) == nil)
        
        XCTAssert(TableViewAd.isAdCellAt(index: 0, itemCount: itemCount, adCount: adCount, forStride: stride) == false)
        XCTAssert(TableViewAd.isAdCellAt(index: 1, itemCount: itemCount, adCount: adCount, forStride: stride) == false)
        XCTAssert(TableViewAd.isAdCellAt(index: 2, itemCount: itemCount, adCount: adCount, forStride: stride) == false)
        XCTAssert(TableViewAd.isAdCellAt(index: 3, itemCount: itemCount, adCount: adCount, forStride: stride) == true)
        XCTAssert(TableViewAd.isAdCellAt(index: 4, itemCount: itemCount, adCount: adCount, forStride: stride) == false)
        XCTAssert(TableViewAd.isAdCellAt(index: 5, itemCount: itemCount, adCount: adCount, forStride: stride) == false)
        XCTAssert(TableViewAd.isAdCellAt(index: 6, itemCount: itemCount, adCount: adCount, forStride: stride) == false)
        XCTAssert(TableViewAd.isAdCellAt(index: 7, itemCount: itemCount, adCount: adCount, forStride: stride) == true)
        XCTAssert(TableViewAd.isAdCellAt(index: 8, itemCount: itemCount, adCount: adCount, forStride: stride) == false)
        XCTAssert(TableViewAd.isAdCellAt(index: 9, itemCount: itemCount, adCount: adCount, forStride: stride) == false)
        XCTAssert(TableViewAd.isAdCellAt(index: 10, itemCount: itemCount, adCount: adCount, forStride: stride) == false)
        XCTAssert(TableViewAd.isAdCellAt(index: 11, itemCount: itemCount, adCount: adCount, forStride: stride) == false)
        
        
        //--------------------
        //0 0 1
        itemCount = 2
        adCount = 2
        stride = 10
        
        XCTAssert(TableViewAd.adjustCount(itemCount: itemCount, adCount: adCount, forStride: stride) == 3)
        
        XCTAssert(TableViewAd.adjustNonAdCell(index: 0, itemCount: itemCount, adCount: adCount, forStride: stride) == 0)
        XCTAssert(TableViewAd.adjustNonAdCell(index: 1, itemCount: itemCount, adCount: adCount, forStride: stride) == 1)
        XCTAssert(TableViewAd.adjustNonAdCell(index: 2, itemCount: itemCount, adCount: adCount, forStride: stride) == nil)
        
        XCTAssert(TableViewAd.adjustAdCell(index: 0, itemCount: itemCount, adCount: adCount, forStride: stride) == nil)
        XCTAssert(TableViewAd.adjustAdCell(index: 1, itemCount: itemCount, adCount: adCount, forStride: stride) == nil)
        XCTAssert(TableViewAd.adjustAdCell(index: 2, itemCount: itemCount, adCount: adCount, forStride: stride) == 0)
        
        XCTAssert(TableViewAd.isAdCellAt(index: 0, itemCount: itemCount, adCount: adCount, forStride: stride) == false)
        XCTAssert(TableViewAd.isAdCellAt(index: 1, itemCount: itemCount, adCount: adCount, forStride: stride) == false)
        XCTAssert(TableViewAd.isAdCellAt(index: 2, itemCount: itemCount, adCount: adCount, forStride: stride) == true)
        
        
        //--------------------
        //0 0 1
        itemCount = 2
        adCount = 2
        stride = 2
        
        XCTAssert(TableViewAd.adjustCount(itemCount: itemCount, adCount: adCount, forStride: stride) == 3)
        
        XCTAssert(TableViewAd.adjustNonAdCell(index: 0, itemCount: itemCount, adCount: adCount, forStride: stride) == 0)
        XCTAssert(TableViewAd.adjustNonAdCell(index: 1, itemCount: itemCount, adCount: adCount, forStride: stride) == 1)
        XCTAssert(TableViewAd.adjustNonAdCell(index: 2, itemCount: itemCount, adCount: adCount, forStride: stride) == nil)
        
        XCTAssert(TableViewAd.adjustAdCell(index: 0, itemCount: itemCount, adCount: adCount, forStride: stride) == nil)
        XCTAssert(TableViewAd.adjustAdCell(index: 1, itemCount: itemCount, adCount: adCount, forStride: stride) == nil)
        XCTAssert(TableViewAd.adjustAdCell(index: 2, itemCount: itemCount, adCount: adCount, forStride: stride) == 0)
        
        XCTAssert(TableViewAd.isAdCellAt(index: 0, itemCount: itemCount, adCount: adCount, forStride: stride) == false)
        XCTAssert(TableViewAd.isAdCellAt(index: 1, itemCount: itemCount, adCount: adCount, forStride: stride) == false)
        XCTAssert(TableViewAd.isAdCellAt(index: 2, itemCount: itemCount, adCount: adCount, forStride: stride) == true)
        
        //--------------------
        //0 1 0 1
        itemCount = 2
        adCount = 2
        stride = 1
        
        XCTAssert(TableViewAd.adjustCount(itemCount: itemCount, adCount: adCount, forStride: stride) == 4)
        
        XCTAssert(TableViewAd.adjustNonAdCell(index: 0, itemCount: itemCount, adCount: adCount, forStride: stride) == 0)
        XCTAssert(TableViewAd.adjustNonAdCell(index: 1, itemCount: itemCount, adCount: adCount, forStride: stride) == nil)
        XCTAssert(TableViewAd.adjustNonAdCell(index: 2, itemCount: itemCount, adCount: adCount, forStride: stride) == 1)
        XCTAssert(TableViewAd.adjustNonAdCell(index: 3, itemCount: itemCount, adCount: adCount, forStride: stride) == nil)
        
        XCTAssert(TableViewAd.adjustAdCell(index: 0, itemCount: itemCount, adCount: adCount, forStride: stride) == nil)
        XCTAssert(TableViewAd.adjustAdCell(index: 1, itemCount: itemCount, adCount: adCount, forStride: stride) == 0)
        XCTAssert(TableViewAd.adjustAdCell(index: 2, itemCount: itemCount, adCount: adCount, forStride: stride) == nil)
        XCTAssert(TableViewAd.adjustAdCell(index: 3, itemCount: itemCount, adCount: adCount, forStride: stride) == 1)
        
        XCTAssert(TableViewAd.isAdCellAt(index: 0, itemCount: itemCount, adCount: adCount, forStride: stride) == false)
        XCTAssert(TableViewAd.isAdCellAt(index: 1, itemCount: itemCount, adCount: adCount, forStride: stride) == true)
        XCTAssert(TableViewAd.isAdCellAt(index: 2, itemCount: itemCount, adCount: adCount, forStride: stride) == false)
        XCTAssert(TableViewAd.isAdCellAt(index: 3, itemCount: itemCount, adCount: adCount, forStride: stride) == true)
        
        //--------------------
        //0 1 0
        itemCount = 2
        adCount = 1
        stride = 1
        
        XCTAssert(TableViewAd.adjustCount(itemCount: itemCount, adCount: adCount, forStride: stride) == 3)
        
        XCTAssert(TableViewAd.adjustNonAdCell(index: 0, itemCount: itemCount, adCount: adCount, forStride: stride) == 0)
        XCTAssert(TableViewAd.adjustNonAdCell(index: 1, itemCount: itemCount, adCount: adCount, forStride: stride) == nil)
        XCTAssert(TableViewAd.adjustNonAdCell(index: 2, itemCount: itemCount, adCount: adCount, forStride: stride) == 1)
        
        XCTAssert(TableViewAd.adjustAdCell(index: 0, itemCount: itemCount, adCount: adCount, forStride: stride) == nil)
        XCTAssert(TableViewAd.adjustAdCell(index: 1, itemCount: itemCount, adCount: adCount, forStride: stride) == 0)
        XCTAssert(TableViewAd.adjustAdCell(index: 2, itemCount: itemCount, adCount: adCount, forStride: stride) == nil)
        
        XCTAssert(TableViewAd.isAdCellAt(index: 0, itemCount: itemCount, adCount: adCount, forStride: stride) == false)
        XCTAssert(TableViewAd.isAdCellAt(index: 1, itemCount: itemCount, adCount: adCount, forStride: stride) == true)
        XCTAssert(TableViewAd.isAdCellAt(index: 2, itemCount: itemCount, adCount: adCount, forStride: stride) == false)
        
    }
    
}


