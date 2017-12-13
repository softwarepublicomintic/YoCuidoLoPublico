//
//  elefantesblancosTests.m
//  elefantesblancosTests
//
//  Created by Ihonahan Buitrago on 25/11/13.
//  Copyright (c) 2013 softwareworks. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "LectorLocalJson.h"

@interface elefantesblancosTests : XCTestCase

@end

@implementation elefantesblancosTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample
{
    NSArray *test1 = [LectorLocalJson obtenerElementosJsonDeArchivo:@"municipios"];
    NSArray *test2 = [LectorLocalJson obtenerElementosJsonDeArchivo:@"departamentos"];
    XCTAssertNotNil(test1, @"Archivo de municipios no existe");
    XCTAssertNotNil(test2, @"Archivo de departamentos no existe");
}

@end
