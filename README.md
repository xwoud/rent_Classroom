# 강의실 빌리SWU
: 서울여자대학교 2018 Guru 해커톤 - 학교 강의실 임대 서비스 어플리케이션

## 제작
##### 제작자
- 서울여자대학교 정보보호학과 17학번 김민희
- 서울여자대학교 정보보호학과 17학번 김민주
- 서울여자대학교 정보보호학과 17학번 문은실

##### 제작일
- 서울여자대학교 2018 겨울방학 Programming Guru

## 개발 배경
1. 실습실 대여시 학과 사무실에 항상 들려야하는 번거로움
2. 현재 사용할 수 있는 실습실 확인 불가
3. 어떤 실습실에 내가 원하는 프로그램이 설치되어 있는지 확인 불가

-> ***어플리케이션을 통해 예약 & 강의실 확인 할 수 있는 어플리케이션 제작***

## iOS 어플리케이션 개발
> ### API

Django(웹 프레임 워크)를 사용하여 웹 서버를 구축하여 API통신을 구현하였다. 사용자는 APP에서 예약을 신청하고 관리자는 WEB에서 예약을 승인 및 관리하고, 문의사항을 확인할 수 있다. 

- 웹에서 데이터 요청하기
: 웹에서 JSON 데이터를 요청하는 코드이다. 이 코드 부분은 데이터를 서버에서 불러와야할때 사용한다. 이 프로젝트에서는 로그인 요청, 강의실 조회 등에 변형해 사용하였다.

```swift
    Alamofire.request("서버주소").responseData { (response) in
        guard let data: Data = response.data else {
                print("데이터 없음")
                return
            }
        let decoder: JSONDecoder = JSONDecoder()
            decoder.keyDecodingStrategy = JSONDecoder.KeyDecodingStrategy.convertFromSnakeCase
```
guard 구문을 사용하였다. guard 구문은 if 구문과 유사하게 Bool 타입의 값으로 동작하는 기능이다. Guard 뒤에 따라붙는 코드의 실행 결과가 true일 때 코드가 계속 실행되고, Else 구문이 항상 뒤따라와야한다. 여기서는 전송받은 데이터가 있는지 확인해 있다면 꺼내주었다. 그 후, JSON 데이터를 구조체 형식으로 변경해 줄 디코더를 선언해 사용해주었다.
<br>

> ### 로그인&회원가입
|<center>로그인</center>|<center>회원가입</center>|
|:--------|:--------:|
|  <img alt="로그인" src="https://user-images.githubusercontent.com/51286963/82704502-a4209f80-9cb0-11ea-9c30-773febf82e3a.png">|  <img alt="회원가입" src="https://user-images.githubusercontent.com/51286963/82704496-a08d1880-9cb0-11ea-8f0f-d870914774dd.png"> |

- 회원가입
```swift
    do {
        request = try URLRequest(url: "서버주소", method: .post)
    } catch {
            print("request 생성 실패 " + error.localizedDescription)
            return
        }
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let userInfo: User = User(username: id, password: pw, name: name, dept: dept, studentID: num, id: nil)
        let encoder: JSONEncoder = JSONEncoder()
```
HTTP 메소드는 **post형식**을 사용해 전송하였고, 파라미터는 아이디 / 비밀번호 / 이름 / 학과 / 학번 총 5개가 존재한다.

- 로그인
```swift
Alamofire.request("계정이 저장되어 있는 서버 주소").responseData { (response) in
            let userInfo = UserDefaults.standard
            userInfo.set(self.log[i].username, forKey: "userid")
            userInfo.set(self.log[i].name, forKey: "username")
            userInfo.set(self.log[i].dept, forKey: "userdept")
            userInfo.set(self.log[i].id, forKey: "useridid")
            userInfo.set(self.log[i].studentID, forKey: "usernum")
        }
```
입력한 계정값을 서버 주소로 보내 가입된 id값이 맞다면 그 정보들을 **UserDefaults를 이용해 공유 객체에 저장**한다. 이 때 저장한 것은 뒤에 마이페이지 정보를 띄울때 사용할 것이다.

> ### 첫번째 탭 : 강의실 조회

|  <center>강의실 조회</center>|  <center>강의실 상세 정보</center>|
|:--------|:--------:|
|<img alt="강의실조회" src="https://user-images.githubusercontent.com/51286963/82704965-b3ecb380-9cb1-11ea-9342-09f72b436241.png"> | <img alt="강의실상세정보" src="https://user-images.githubusercontent.com/51286963/82704952-af27ff80-9cb1-11ea-8f19-b4cb4ea52e5c.png"> |

- 강의실 조회
```swift
do {
        self.lists = try decoder.decode([Condition].self, from: data)
        self.tableView.reloadData() 
}
```
tableView를 이용해 목록을 구성하였고, JSON 데이터가 구조체 형식으로 변환이 성공했다면 테이블뷰의 배열에 넣어주었다. 그리고 갱신된 데이터를 보여주기 위해 테이블뷰를 새로고침한다.

- 강의실 상세정보
```swift
if info.type == "0"{
            if row == 1 {
                cell2.titleLabel.text = "컴퓨터 사양"
                cell2.inLabel.text = info.spec
            } else if row == 2 {
                cell2.titleLabel.text = "설치된 프로그램"
                cell2.inLabel.text = info.program
            } else if row == 3 {
                cell2.titleLabel.text = "사용가능 시간"
                cell2.inLabel.text = info.day
            } else if row == 4 {
                cell2.titleLabel.text = "공지사항"
                cell2.inLabel.text = info.notice
            }
            }else { if row == 1 {
                cell2.titleLabel.text = "사용가능 시간"
                cell2.inLabel.text = info.day
            } else if row == 2 {
                cell2.titleLabel.text = "공지사항"
                cell2.inLabel.text = info.notice
                }
            }
```
역시 tableview를 사용하였고, 여기서 type은 강의실이 실습실인지 혹은 실험실인지를 나타내주는것으로 type에 따라 table에서 보여주는것도 달라지게된다.

> ### 두번째 탭 : 강의실 예약 및 조회

- 강의실 예약

|<center>강의실 예약</center>|<center>강의실 예약 2</center>|
|:--------|:--------:|
|<img alt="강의실예약view" src="https://user-images.githubusercontent.com/51286963/82700232-c1517000-9ca8-11ea-853d-b8cf45d412fd.png"> |<img alt="강의실예약추가" src="https://user-images.githubusercontent.com/51286963/82700243-c6162400-9ca8-11ea-98f7-d93c8311c7d6.png"> |

```swift
    @IBOutlet weak var onePicker: UIPickerView!
    @IBOutlet weak var twoPicker: UIPickerView!
    @IBOutlet weak var threePicker: UIPickerView! 
    @IBOutlet weak var stepper: UIStepper!
```
UIPickerView와 UIStepper를 이용해서 강의실 예약 조건을 쉽게 표현하였다.
```swift
    if (onePicker.selectedRow(inComponent: 0) == 0 || threePicker.selectedRow(inComponent: 0) == 0) || twoPicker.selectedRow(inComponent: 0) == 0 {
            self.addButton.isEnabled = false
        } else {
            self.addButton.isEnabled = true
        }
```
만약의 하나의 조건이라도 선택을 하지 않는다면 **추가 button이 활성화 되지 않게** 하는 코드를 작성하였다. 그리고 추가 버튼을 누르면 이 정보들을 서버로 전달된다.

- 강의실 예약 조회

|<center>강의실 예약 조회</center>|<center>강의실 예약 조회 2</center>|
|:--------|:--------:|
|<img alt="강의실예약확인" src="https://user-images.githubusercontent.com/51286963/82700245-c9111480-9ca8-11ea-8308-e5f04e9e890b.png"> |<img alt="강의실예약확인2" src="https://user-images.githubusercontent.com/51286963/82700249-cadad800-9ca8-11ea-96e1-17313f826ed8.png"> |
데이터는 서버에서 받아오고, 왼쪽의 사진으로 현재 신청이 받아드려졌는지 아직 확인중인지 쉽게 확인할 수 있다.

> ### 세번째 탭 : 일대일 문의게시판

|<center>문의 게시판 tab</center>|<center>문의 게시판 목록</center>|<center>문의글 작성</center>|
|:--------|:--------:|:--------:|
|<img alt="문의게시판" src="https://user-images.githubusercontent.com/51286963/82702088-49854480-9cac-11ea-8fa9-30546ad2b957.png"> |<img alt="문의게시판목록" src="https://user-images.githubusercontent.com/51286963/82702092-4db16200-9cac-11ea-9801-ece8c56ad730.png">|<img alt="글작성" src="https://user-images.githubusercontent.com/51286963/82702094-4e49f880-9cac-11ea-9fc5-e6226409578f.png">

- 문의 게시판 목록

```swift
Alamofire.request("서버 주소").responseData{(response)in
    do{
            self.textList=try
            decoder.decode([Post].self, from: data)
            self.tableView.reloadData()
       }
```
서버에서 Post정보를 받아와서, tableview에 보여준다. 

- 문의글 작성
```swift
        let userInfo = UserDefaults.standard
        var nums = userInfo.integer(forKey: "useridid")
        let textInfo:Post = Post(id: nil, author: nums, text: inquireText, createdDate: currentDate)
```
내 아이디 토큰값을 넘겨주고 textInfo로 아이디,글 내용,시간 정보들을 함께 보낸다.

> ### 네번째 탭 : 마이페이지
마이페이지에서는 내 아이디와 관련된 정보만 보여주어야한다.

|<center>마이페이지 tab</center>|<center>로그인정보</center>|<center>내 신청목록</center>|<center>내 문의글 목록</center>|
|:--------|:--------:|:--------:|:--------:|
|<img alt="마이페이지" src="https://user-images.githubusercontent.com/51286963/82702795-a9c8b600-9cad-11ea-9e68-dc2ff0930136.png">|<img  alt="마이페이지_로그인정보" src="https://user-images.githubusercontent.com/51286963/82702780-a5040200-9cad-11ea-9e4c-c76dd2b165ba.png">|<img alt="마이페이지_예약현황" src="https://user-images.githubusercontent.com/51286963/82702793-a9c8b600-9cad-11ea-8d0c-65042de69f09.png">|<img alt="마이페이지_문의사항" src="https://user-images.githubusercontent.com/51286963/82702792-a9301f80-9cad-11ea-8941-5964af7f3de3.png">

- 로그인정보
```swift
        self.idLabel.text = userInfo.string(forKey: "userid")
        self.nameLabel.text = userInfo.string(forKey: "username")
        self.subLabel.text = userInfo.string(forKey: "userdept")
        self.numLabel.text = userInfo.string(forKey: "usernum")
```
로그인할 때 공유객체에 저장해 둔 정보를 가져와 Label의 text 값으로 넣어주었다.

- 예약 현황, 문의사항
```swift
       let idnumber = self.rsvList[indexPath.row].id
       var URL = "http://서버주소/reservation/reservation/"+String(idnumber!)+"/"
```
특정 아이디 값으로 작성된 예약 건만 리스트에서 가져와야 한다.

## 추후 사항
2019년 춘계 학술대회 [강의실을 스마트하게 빌리기 위한 어플리케이션](https://www.cseric.or.kr/literature/ser_view.php?SnxGubun=INME&mode=total&searchCate=literature&more=Y&research=Y&re_q1=&pg=20&gu=INME001G0&cmd=qryview&SnxIndxNum=209753&rownum=193&totalCnt=57501&q1_t=&listUrl=L3NlYXJjaC9yZXN1bHQucGhwP1NueEd1YnVuPUlOTUUmbW9kZT10b3RhbCZzZWFyY2hDYXRlPWxpdGVyYXR1cmUmcTE9Jm1vcmU9WSZyZXNlYXJjaD1ZJnJlX3ExPSZwZz0yMA==&q1=) 논문 작성 완료


감사합니다.
