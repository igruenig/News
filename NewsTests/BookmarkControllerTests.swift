//
//  BookmarkControllerTests.swift
//  NewsTests
//
//  Created by Ian Grünig on 28.04.22.
//

import XCTest

class BookmarkControllerTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testFindAll_Nil_ReturnsEmptyArray() throws {
        // given
        let bookmarkController = BookmarkController(db: MockBookmarkStore())
        
        // when
        let bookmarks = bookmarkController.findAll()
        
        //then
        XCTAssertEqual(bookmarks, [])
    }
    
    func testFindAll_TwoBookmarks_ReturnsTwoBookmarks() throws {
        // given
        let bookmarkController = BookmarkController(db: storeWithBookmarks(2))
        
        // when
        let bookmarks = bookmarkController.findAll()
        
        // then
        XCTAssertEqual(bookmarks.count, 2)
    }
    
    func testIsBookmarked_EmptyStore_ReturnsFalse() throws {
        // given
        let bookmarkController = BookmarkController(db: MockBookmarkStore())
        
        // when
        let isBookmarked = bookmarkController.isBookmarked(MockBookmarkFactory.randomURL().absoluteString)
        
        // then
        XCTAssertFalse(isBookmarked)
    }
    
    func testIsBookmarked_FullStoreNewBookmark_ReturnsFalse() throws {
        // given
        let bookmarkController = BookmarkController(db: storeWithBookmarks(100))
        
        // when
        let isBookmarked = bookmarkController.isBookmarked(MockBookmarkFactory.randomURL().absoluteString)
        
        // then
        XCTAssertFalse(isBookmarked)
    }
    
    func testIsBookmarked_FullStoreExistingBookmark_ReturnsTrue() throws {
        // given
        let bookmarkController = BookmarkController(db: storeWithBookmarks(100))
        
        // when
        let savedBookmark = bookmarkController.findAll().randomElement()!
        let isBookmarked = bookmarkController.isBookmarked(savedBookmark.url.absoluteString)
        
        // then
        XCTAssertTrue(isBookmarked)
    }
    
    func testAdd_EmptyStore_HasOneBookmark() throws {
        // given
        let bookmarkController = BookmarkController(db: MockBookmarkStore())
        
        // when
        let _ = bookmarkController.add(MockBookmarkFactory.randomURL(), title: MockBookmarkFactory.randomTitle())
        
        // then
        XCTAssertEqual(bookmarkController.findAll().count, 1)
    }
    
    func testAdd_StoreWithBookmarks_HasOneMoreBookmark() throws {
        // given
        let bookmarkController = BookmarkController(db: storeWithBookmarks(3))
        
        // when
        let _ = bookmarkController.add(MockBookmarkFactory.randomURL(), title: MockBookmarkFactory.randomTitle())
        
        // then
        XCTAssertEqual(bookmarkController.findAll().count, 4)
    }
    
    func testRemove_StoreWithBookmarks_HasOneLessBookmark() throws {
        // given
        let bookmarkController = BookmarkController(db: storeWithBookmarks(3))
        
        // when
        let savedBookmark = bookmarkController.findAll().randomElement()!
        let _ = bookmarkController.remove(savedBookmark.url.absoluteString)
        
        // then
        XCTAssertEqual(bookmarkController.findAll().count, 2)
    }
    
    func testRemove_EmptyStore_IsStillEmpty() throws {
        // given
        let bookmarkController = BookmarkController(db: MockBookmarkStore())
        
        // when
        let randomURL = MockBookmarkFactory.randomURL()
        let _ = bookmarkController.remove(randomURL.absoluteString)
        
        // then
        XCTAssertEqual(bookmarkController.findAll().count, 0)
    }
    
    private func storeWithBookmarks(_ numberOfBookmarks: Int) -> MockBookmarkStore {
        let bookmarkStore = MockBookmarkStore()
        bookmarkStore.bookmarks = []
        
        for _ in repeatElement((), count: numberOfBookmarks) {
            bookmarkStore.bookmarks?.append(MockBookmarkFactory.randomBookmark())
        }
        
        return bookmarkStore
    }

}
