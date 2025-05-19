//-------------Filter--------
import RealmSwift

let realm = try! Realm()

let predicate = NSPredicate(format: "age > 18 AND city == %@", "New York")
let filteredUsers = realm.objects(User.self).filter(predicate)

//-------------Limit--------

let realm = try! Realm()
let limitedResults = realm.objects(User.self).filter("age > 18").limit(10)

//---------------------

let realm = try! Realm()

if let user = realm.objects(User.self).first {
    // At this point, related objects (e.g., User's orders) are not yet loaded
    print(user.name)  // Now related objects (e.g., orders) are fetched if accessed
}
