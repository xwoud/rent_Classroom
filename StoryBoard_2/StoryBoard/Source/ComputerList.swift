//
//  ComputerList.swift
//  StoryBoard
//
//  Created by swuad_14 on 2019. 1. 11..
//  Copyright © 2019년 swuad_14. All rights reserved.
//

import Foundation

struct ComputerList: Codable {
    var computer: [Condition]

}

struct Condition: Codable {
    var image: URL // 이미지
    var name: String // 이름
    var spec: String // 컴퓨터 사양
    var program: String // 깔려있는 프로그램
    var day: String // 사용가능한 날짜
    var notice: String // 공지사항
    var type: String // 실습실인지 컴퓨터실인지
}

struct User: Codable {
    var username: String // 아이디
    var password: String // 비밀번호
    var name: String // 이름
    var dept: String // 학과
    var studentID: String // 학번
    var id: Int?
    
}
struct Post: Codable{
    var id: Int? // 글번호 입니다
    var author: Int // 작성자 ( 아이디 가입번호 ) 
    var text: String // 글 내용
    var createdDate:String // 글 쓴 날짜 ( 보내줘야함 )
}


struct Rsv: Codable {
    var name: String // 이름
    var author: Int // 아이디 가입번호
    var classRoom: String
    var rsvTime: String
    var rsvDate: String
    var rsvPeopleNum: String
    var rsvResult: Int
    var id: Int?
}
