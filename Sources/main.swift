import Foundation

public struct AppMain {
	public private(set) var text = "Hello, World!"
	
	public static func main() {
		let runLoop = RunLoop.current
		let distantFuture = Date.distantFuture
		///	Set this to false when we want to exit the app...
		let shouldKeepRunning = true
		

		//	Run forever
		while shouldKeepRunning == true &&
				runLoop.run(mode:.default, before: distantFuture) {}
	}
	
}


@propertyWrapper struct TestPropertyWrapper: Codable {
	var wrappedValue: String {
		didSet {
			global.aFunc()
		}
	}
}
							  
public struct GlobalStruct: Codable {
	
	enum CodingKeys: CodingKey {
		case stringOne
		case stringTwo
		case stringThree
	}

	var stringOne: String = "One" {
		didSet {
			aFunc()
		}
	}
	
	var stringTwo: String = "Two" {
		didSet {
			aFunc()
		}
	}

	@TestPropertyWrapper var stringThree: String = "Three"
	
	//	MARK: - Functions -
	
	func aFunc() {
		print("aFunc")
	}
}



class ClientClass {

	var activeProfile = String()
	{
		didSet {
			global.stringOne = activeProfile
			global.stringThree = activeProfile
		}
	}
}



var global = GlobalStruct()
global.stringOne = "Hello"
global.stringTwo = "World"
global.stringThree = "DubDub Next Week..."

let client = ClientClass()
client.activeProfile = "Test"


AppMain.main()
print("never got here")

