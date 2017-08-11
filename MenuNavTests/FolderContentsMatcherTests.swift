//
//  FolderContentsMatcherTests.swift
//  MenuNav
//
//  Created by Steve Barnegren on 11/08/2017.
//  Copyright © 2017 SteveBarnegren. All rights reserved.
//

import XCTest

class FolderContentsMatcherTests: XCTestCase {
    
    // MARK: - Test Matching
    
    func testMatchesFilesWithExtension() {
        
        let folder = TestDirectoryBuilder.makeDirectory(withFileNames: ["dog.png"])
        let matcher = FolderContentsMatcher.filesWithExtension("png")
        
        XCTAssertTrue(matcher.matches(directory: folder))
    }
    
    func testFailsToMatchFilesWithExtension() {
        
        let folder = TestDirectoryBuilder.makeDirectory(withFileNames: ["dog.gif"])
        let matcher = FolderContentsMatcher.filesWithExtension("png")
        
        XCTAssertFalse(matcher.matches(directory: folder))
    }
    
    func testMatchesFilesWithNameAndExtension() {
        
        let folder = TestDirectoryBuilder.makeDirectory(withFileNames: ["dog.png"])
        let matcher = FolderContentsMatcher.filesWithNameAndExtension(name: "dog", ext: "png")
        
        XCTAssertTrue(matcher.matches(directory: folder))
    }
    
    func testFailsToMatchFilesWithNameAndExtension() {
        
        let folder = TestDirectoryBuilder.makeDirectory(withFileNames: ["dog.gif", "cat.png"])
        let matcher = FolderContentsMatcher.filesWithNameAndExtension(name: "dog", ext: "png")
        
        XCTAssertFalse(matcher.matches(directory: folder))
    }
    
    func testMatchesFoldersWithName() {
        
        let folder = TestDirectoryBuilder.makeDirectory(withFolderNames: ["animals"])
        let matcher = FolderContentsMatcher.foldersWithName("animals")
        
        XCTAssertTrue(matcher.matches(directory: folder))
    }
    
    func testFailsToMatchFoldersWithName() {
        
        let folder = TestDirectoryBuilder.makeDirectory(withFolderNames: ["no animals here"])
        let matcher = FolderContentsMatcher.foldersWithName("animals")
        
        XCTAssertFalse(matcher.matches(directory: folder))
    }
    
    // MARK: - Test Equatable
    
    func testFolderContentsMatchersAreEqualWithFilesWithExtensionCaseAndSameString() {
        
        let firstMatcher = FolderContentsMatcher.filesWithExtension("png")
        let secondMatcher = FolderContentsMatcher.filesWithExtension("png")
        
        XCTAssertTrue(firstMatcher == secondMatcher)
    }
    
    func testFolderContentsMatchersAreNotEqualWithFilesWithExtensionCaseAndDifferentString() {
        
        let firstMatcher = FolderContentsMatcher.filesWithExtension("png")
        let secondMatcher = FolderContentsMatcher.filesWithExtension("pdf")
        
        XCTAssertFalse(firstMatcher == secondMatcher)
    }
    
    func testFolderContentsMatchersAreEqualWithFullNameCaseAndSameString() {
        
        let firstMatcher = FolderContentsMatcher.filesWithNameAndExtension(name: "dog", ext: "png")
        let secondMatcher = FolderContentsMatcher.filesWithNameAndExtension(name: "dog", ext: "png")
        
        XCTAssertTrue(firstMatcher == secondMatcher)
    }
    
    func testFolderContentsMatchersAreNotEqualWithFullNameCaseAndDifferentString() {
        
        let firstMatcher = FolderContentsMatcher.filesWithNameAndExtension(name: "dog", ext: "png")
        let differentNameMatcher = FolderContentsMatcher.filesWithNameAndExtension(name: "cat", ext: "png")
        let differentExtMatcher = FolderContentsMatcher.filesWithNameAndExtension(name: "dog", ext: "pdf")
        
        XCTAssertFalse(firstMatcher == differentNameMatcher)
        XCTAssertFalse(firstMatcher == differentExtMatcher)
    }
    
    func testFolderContentsMatchersAreEqualWithFolderNameCaseAndSameString() {
        
        let firstMatcher = FolderContentsMatcher.foldersWithName("animals")
        let secondMatcher = FolderContentsMatcher.foldersWithName("animals")
        
        XCTAssertTrue(firstMatcher == secondMatcher)
    }
    
    func testFolderContentsMatchersAreNotEqualWithFolderNameCaseAndDifferentString() {
        
        let firstMatcher = FolderContentsMatcher.foldersWithName("animals")
        let secondMatcher = FolderContentsMatcher.foldersWithName("no animals here")
        
        XCTAssertFalse(firstMatcher == secondMatcher)
    }

    // MARK: - Test DictionaryRepresentable
    
    func testFolderContentsMatcherToDictionaryAndBackIsSame() {
        
        let filesWithExtension = FolderContentsMatcher.filesWithExtension("pdf")
        let filesWithNameAndExtension = FolderContentsMatcher.filesWithNameAndExtension(name: "dog", ext: "png")
        let foldersWithName = FolderContentsMatcher.foldersWithName("animals")
        
        XCTAssertTrue(filesWithExtension == filesWithExtension.convertedToDictionaryAndBack)
        XCTAssertTrue(filesWithNameAndExtension == filesWithNameAndExtension.convertedToDictionaryAndBack)
        XCTAssertTrue(foldersWithName == foldersWithName.convertedToDictionaryAndBack)
    }

}