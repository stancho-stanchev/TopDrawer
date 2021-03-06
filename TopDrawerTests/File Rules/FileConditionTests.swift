//
//  FileConditionTests.swift
//  MenuNav
//
//  Created by Steve Barnegren on 11/08/2017.
//  Copyright © 2017 SteveBarnegren. All rights reserved.
//

import XCTest
@testable import TopDrawer

class FileConditionTests: XCTestCase {
    
    // MARK: - Test Matching
    
    func testFileConditionMatchesName() {
        
        let condition = FileCondition.name(.matching("dog"))
        let file = File(name: "dog", ext: "png", path: "animals/dog.png")
        
        XCTAssertTrue(condition.matches(file: file, inHierarchy: HierarchyInformation()))
    }
    
    func testFileConditionFailsToMatchName() {
        
        let condition = FileCondition.name(.matching("dog"))
        let file = File(name: "cat", ext: "png", path: "animals/dog.png")
        
        XCTAssertFalse(condition.matches(file: file, inHierarchy: HierarchyInformation()))
    }
    
    func testFileConditionMatchesExtension() {
        
        let condition = FileCondition.ext(.matching("png"))
        let file = File(name: "dog", ext: "png", path: "animals/dog.png")
        
        XCTAssertTrue(condition.matches(file: file, inHierarchy: HierarchyInformation()))
    }
    
    func testFileConditionFailsToMatchExtension() {
        
        let condition = FileCondition.ext(.matching("png"))
        let file = File(name: "dog", ext: "pdf", path: "animals/dog.png")
        
        XCTAssertFalse(condition.matches(file: file, inHierarchy: HierarchyInformation()))
    }
    
    func testFileConditionMatchesFullName() {
        
        let condition = FileCondition.fullName(.matching("dog.png"))
        let file = File(name: "dog", ext: "png", path: "animals/dog.png")
        
        XCTAssertTrue(condition.matches(file: file, inHierarchy: HierarchyInformation()))
    }
    
    func testFileConditionFailsToMatchFullName() {
        
        let condition = FileCondition.fullName(.matching("dog.png"))
        let file = File(name: "cat", ext: "png", path: "animals/dog.png")
        
        XCTAssertFalse(condition.matches(file: file, inHierarchy: HierarchyInformation()))
    }
    
    func testFileConditionMatchesHierarchy() {
        
        let condition = FileCondition.hierarchyContains(.folderWithName(.matching("Photos")))
        let file = File(name: "photo", ext: "png", path: "Photos/photo.png")
        
        var hierarchy = HierarchyInformation()
        hierarchy.add(folderName: "Photos")
        
        XCTAssertTrue(condition.matches(file: file, inHierarchy: hierarchy))
    }
    
    func testFileConditionFailsToMatchHierarchy() {
        
        let condition = FileCondition.hierarchyContains(.folderWithName(.matching("Photos")))
        let file = File(name: "photo", ext: "png", path: "Photos/photo.png")
        
        XCTAssertFalse(condition.matches(file: file, inHierarchy: HierarchyInformation()))
    }

    // MARK: - Test Equatable
    
    func testFileConditionsWithNameAreEqual() {
        
        let condition = FileCondition.name(.matching("dog"))
        let same = FileCondition.name(.matching("dog"))
        let different = FileCondition.name(.matching("cat"))
        
        XCTAssertTrue(condition == same)
        XCTAssertFalse(condition == different)
    }
    
    func testFileConditionsWithExtensionAreEqual() {
        
        let condition = FileCondition.ext(.matching("png"))
        let same = FileCondition.ext(.matching("png"))
        let different = FileCondition.ext(.matching("gif"))
        
        XCTAssertTrue(condition == same)
        XCTAssertFalse(condition == different)
    }
    
    func testFileConditionsWithFullNameAreEqual() {
        
        let condition = FileCondition.fullName(.matching("dog.png"))
        let same = FileCondition.fullName(.matching("dog.png"))
        let different = FileCondition.fullName(.matching("cat.gif"))
        
        XCTAssertTrue(condition == same)
        XCTAssertFalse(condition == different)
    }
    
    func testFileConditionsWithDifferentCasesAreNotEqual() {
        
        let name = FileCondition.name(.matching("dog"))
        let ext = FileCondition.ext(.matching("png"))
        let fullName = FileCondition.fullName(.matching("dog.png"))
        
        XCTAssertFalse(name == ext)
        XCTAssertFalse(name == fullName)
        XCTAssertFalse(ext == fullName)
    }
    
    // MARK: - Test Decision Tree Input
    
    func testFileConditionWithNameDecisionTreeInput() {
        
        let condition = FileCondition.name(.matching("dog"))
        XCTAssertEqual(condition.decisionTreeInput(), "dog")
    }
    
    func testFileConditionWithExtensionDecisionTreeInput() {
        
        let condition = FileCondition.ext(.matching("png"))
        XCTAssertEqual(condition.decisionTreeInput(), "png")
    }
    
    func testFileConditionWithFullNameDecisionTreeInput() {
        
        let condition = FileCondition.fullName(.matching("dog.png"))
        XCTAssertEqual(condition.decisionTreeInput(), "dog.png")
    }
    
    func testFileConditionWithParentContainsDecisionTreeInput() {
        
        let condition = FileCondition.parentContains(.filesWithExtension("png"))
        XCTAssertEqual(condition.decisionTreeInput(), "png")
    }
    
    func testFileConditionWithParentDoesntContainDecisionTreeInput() {
        
        let condition = FileCondition.parentDoesntContain(.filesWithExtension("png"))
        XCTAssertEqual(condition.decisionTreeInput(), "png")
    }

    // MARK: - Test DictionaryRepresentable
    
    func testFileConditionToDictionaryAndBackIsTheSame() {
        
        let name = FileCondition.name(.matching("dog"))
        let ext = FileCondition.ext(.matching("png"))
        let fullName = FileCondition.fullName(.matching("dog.png"))
        
        XCTAssertTrue(name == name.convertedToDictionaryAndBack)
        XCTAssertTrue(ext == ext.convertedToDictionaryAndBack)
        XCTAssertTrue(fullName == fullName.convertedToDictionaryAndBack)
    }
    
}
