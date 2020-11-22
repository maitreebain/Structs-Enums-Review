import UIKit


struct User {
  let id: Int
  let name: String
  let bio: String
  let location: Location

  struct Location {
    let id: Int
    let name: String
    let city: City

    struct City {
      let id: Int
      let name: String
    }
  }
}

let user = User(id: 42, name: "Blob", bio: "Stuff", location: .init(id: 1, name: "", city: .init(id: 1, name: "")))

//User.init(id: <#T##Int#>, name: <#T##String#>, bio: <#T##String#>)

struct Foo {
  let field1: Bool // 2
  let field2: Bool // 2
}

Foo.init(field1: true, field2: true)
Foo.init(field1: true, field2: false)
Foo.init(field1: false, field2: false)
Foo.init(field1: false, field2: true)

struct Bar {
  let field1: Bool // 2
  let field2: Bool // 2
  let field3: Bool // 2
}

Bar(field1: true, field2: true, field3: true)
Bar(field1: false, field2: true, field3: true)
Bar(field1: true, field2: false, field3: true)
Bar(field1: true, field2: true, field3: false)
Bar(field1: false, field2: false, field3: true)
Bar(field1: false, field2: true, field3: false)
Bar(field1: true, field2: false, field3: false)
Bar(field1: false, field2: false, field3: false)

struct Baz {
  let field1: Bool // 2
  let field2: Bool // 2
  let field3: Bool // 2
  let field4: Void // 1
} // 8

let x: Void = ()
let y: Void = Void()

func viewDidLoad() /* -> Void */ {


//  return ()
}


//class BaseUser {
//  let age: Int
//
//  init(age: Int) { self.age = age }
//}
//class User_: BaseUser {
//  let id: Int
//  let name: String
//  let bio: String
//
//  init() {
//    self.id = 1
//    self.name = ""
//    self.bio = ""
//    super.init(age: 42)
//  }
//}
//
////User_.init



enum Three {
  case one(Void /* 1 */)
  case two(Void)
  case three(Void)
}

Three.one
Three.two
Three.three

enum Buz { // +
  case one(Bool)
  case two(Bool)
  case three(Bool)
}

Buz.one(true)
Buz.one(false)
Buz.two(true)
Buz.two(false)
Buz.three(true)
let buz = Buz.three(false)

//switch buz {
//case .one(_):
//  <#code#>
//case .two(_):
//  <#code#>
//case .three(_):
//  <#code#>
//}

struct Pair<A, B> { // A*B
  let first: A
  let second: B
}

enum Either<A, B> { // A+B
  case left(A)
  case right(B)
}

Pair<Int, String>(first: 1, second: "Hello")
Either<Int, String>.left(1)

// A * (B + C) = A*B + A*C
//Pair<A, Either<B, C>> = Either<Pair<A, B>, Pair<A, C>>
func to<A, B, C>(_ x: Pair<A, Either<B, C>>) -> Either<Pair<A, B>, Pair<A, C>> {
  switch x.second {
  case .left(let b):
    return .left(.init(first: x.first, second: b))
  case .right(let c):
    return .right(.init(first: x.first, second: c))
  }
}

func from<A, B, C>(_ x: Either<Pair<A, B>, Pair<A, C>>) -> Pair<A, Either<B, C>> {
  fatalError("Exercise")
}



enum Route {
  case feed(Feed)
  case explore(Explore)
  case activity(Activity)
  case profile(Profile)

  enum Feed {
    case home
    case messages(Messages)
    case post

    enum Messages {
      case home
      case profile
      case post
    }
  }

  enum Explore {
    case home
    case post
    case search
  }

  enum Activity {
    case home
    case post
    case profile
  }

  enum Profile {
    case home
    case post
    case settings
//    case privacy
    case followers
  }
}

Route.profile(.settings)
let route = Route.feed(.messages(.home))

// twitter.com/mbrandonw/post/123t238746/comments

switch route {
case .feed(.home):
  break
case .feed(.messages(.home)):
  break

case .feed:
  break

  // rootTabController.currentTab = 0
case .explore(_):
// rootTabController.currentTab = 1
  break
case .activity(_):
// rootTabController.currentTab = 2
  break
case .profile(_):
// rootTabController.currentTab = 3
  break
}

struct SearchResults: Decodable {
  let results: [Result]
  let info: Info

  struct Result: Decodable {
    let gender: String
    let name: Name
    let location: Location

    struct Name: Decodable {
      let title: Title
      let first: String
      let last: String

      enum Title: String, Decodable {
        case mr = "Mr"
        case ms = "Ms"
        case mrs = "Mrs"
      }
    }

    struct Location: Decodable {
      let city: String
      let postcode: Int
    }
  }

  struct Info: Decodable {
    let page: Int
    let version: String
  }
}

//SearchResults.init(
//  results: [
//    .init(
//      gender: "male",
//      name: .init(
//        title: .mr,
//        first: <#T##String#>,
//        last: <#T##String#>
//      ),
//      location: .init(
//        city: <#T##String#>,
//        postcode: <#T##Int#>
//      )
//    )
//  ],
//  info: .init(
//    page: <#T##Int#>,
//    version: <#T##String#>
//  )
//)


import Foundation

dump(
try JSONDecoder().decode(
  SearchResults.self,
  from: Data(
    """
    {
        "results": [
            {
                "gender": "male",
                "name": {
                    "title": "Mr",
                    "first": "Maël",
                    "last": "Dubois"
                },
                "location": {
                    "street": {
                        "number": 3973,
                        "name": "Rue de L'Abbé-Grégoire"
                    },
                    "city": "Mulhouse",
                    "state": "Loiret",
                    "country": "France",
                    "postcode": 16113,
                    "coordinates": {
                        "latitude": "-3.5928",
                        "longitude": "-81.4979"
                    },
                    "timezone": {
                        "offset": "-6:00",
                        "description": "Central Time (US & Canada), Mexico City"
                    }
                },
                "email": "mael.dubois@example.com",
                "login": {
                    "uuid": "a3368891-ee6c-4402-a75f-4f4a2983ba61",
                    "username": "greenzebra345",
                    "password": "jackal",
                    "salt": "46zYtdk4",
                    "md5": "250abdaa4b53bb3414665befdd64ec24",
                    "sha1": "693319d37ae54390f7ddd3342017cabe4b0f3ba6",
                    "sha256": "6c4c41d08b92117420841fc600daac41ef875649bcfb27cb8be3e01ac17139c5"
                },
                "dob": {
                    "date": "1995-10-03T15:19:49.561Z",
                    "age": 25
                },
                "registered": {
                    "date": "2006-11-21T19:26:18.213Z",
                    "age": 14
                },
                "phone": "01-65-17-63-05",
                "cell": "06-04-43-10-04",
                "id": {
                    "name": "INSEE",
                    "value": "1NNaN67014939 24"
                },
                "picture": {
                    "large": "https://randomuser.me/api/portraits/men/65.jpg",
                    "medium": "https://randomuser.me/api/portraits/med/men/65.jpg",
                    "thumbnail": "https://randomuser.me/api/portraits/thumb/men/65.jpg"
                },
                "nat": "FR"
            }
               ],
        "info": {
            "seed": "dd5624068cf15d52",
            "results": 50,
            "page": 1,
            "version": "1.3"
        }
    }
    """.utf8
  )
)
)


1

1

