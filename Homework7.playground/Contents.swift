import Foundation

// For this homework project, we'll be connecting to the "TLDR" server
// to add a few books. The first thing you need to do is create an object
// that we'll upload to the server.

// MARK: - STEP ONE

// Implement a struct that defines a book. A book consists of the following
// items:
// A title, which is a string
// An author, which is a string
// The publication year, as a string (because dates are hard)
// A string for the URL for an image for the book cover
//
// Remember that this structure needs to conform to the `Encodable` protocol.
// Using `Codable` more generally will be useful, as by doing this you'll
// be able to reuse this struct in Project Three.

struct Book: Codable{
    let title: String
    let author: String
    let pubYear: String
    let url: String
    
    init(title: String, author: String, pubYear: String, url: String){
        self.title = title
        self.author = author
        self.pubYear = pubYear
        self.url = url
    }
}

// MARK: - STEP TWO

// Once you've defined this structure, you'll need to define a couple of
// book objects that you can insert into the database. In order or us to
// have an amusing dataset to work with, each student is requested to
// create five different books for this database.

let books: [Book] = [Book(title: "The Great Gatsby", author: "F. Scott Fitzgerald", pubYear: "1925", url: "https://www.google.com/url?sa=i&rct=j&q=&esrc=s&source=images&cd=&ved=2ahUKEwillN3ttvXlAhVLS6wKHeYIBNkQjRx6BAgBEAQ&url=https%3A%2F%2Fwww.theliterarygiftcompany.com%2Fcollections%2Fbook-cover-posters-1%2Fproducts%2Fthe-great-gatsby-poster&psig=AOvVaw0BVS4yJDI5NLWNViVtVM0W&ust=1574223797192684"),
Book(title: "Nineteen Eighty-Four", author: "Gearge Orwell", pubYear: "1949", url: "https://www.google.com/url?sa=i&rct=j&q=&esrc=s&source=images&cd=&ved=2ahUKEwj2s52zt_XlAhVCY6wKHbHnAAMQjRx6BAgBEAQ&url=https%3A%2F%2Fpixel8prints.net%2Fproducts%2F1984-alternative-book-cover-print-poster-art-orwells-powerful-book-with-quote-in-vintage-a-cool-russian-style-available-at-a3-a4-a5&psig=AOvVaw2XCLAhG8JVxaQT-k-E68GS&ust=1574223958754082"),
Book(title: "Being John Lennon: A Restless Life", author: "Ray Connolly", pubYear: "2018", url: "https://www.google.com/url?sa=i&rct=j&q=&esrc=s&source=images&cd=&ved=2ahUKEwix4-eeuPXlAhVH7qwKHRGdBCsQjRx6BAgBEAQ&url=https%3A%2F%2Fwww.wamc.org%2Fpost%2Fbeing-john-lennon-restless-life-ray-connolly&psig=AOvVaw39fmHEZaEGUJ4Q3D05ohSi&ust=1574224187767070"),
Book(title: "The Grapes of Wrath", author: "John Steinbeck", pubYear: "1939", url: "https://www.google.com/url?sa=i&rct=j&q=&esrc=s&source=images&cd=&ved=2ahUKEwiJgoeUufXlAhVGba0KHbGvAHcQjRx6BAgBEAQ&url=https%3A%2F%2Fwww.amazon.com%2FGrapes-Wrath-John-Steinbeck%2Fdp%2F0143039431&psig=AOvVaw1JWyDOnR0PPO5Xew4v5MtD&ust=1574224430645718"),
Book(title: "Oedipus the King", author: "Sophocles", pubYear: "429 BC", url: "https://www.google.com/url?sa=i&rct=j&q=&esrc=s&source=images&cd=&ved=2ahUKEwiD99fnufXlAhUFL6wKHS_-DL4QjRx6BAgBEAQ&url=https%3A%2F%2Fwww.amazon.com%2FOedipus-Rex-Literary-Touchstone-Sophocles%2Fdp%2F1580495931&psig=AOvVaw3vJg2EipKGTlfQqlYz4vTd&ust=1574224591791594")]


// MARK: - STEP THREE

// Now we need to publish this data to the server.

// Create a URL to connect to the server. Its address is:
//      https://uofd-tldrserver-develop.vapor.cloud/books
let urlString = "https://uofd-tldrserver-develop.vapor.cloud/books"
let url = URL(string: urlString)!
// Create a URL request to publish the information, based upon the URL you
// just created.
var request = URLRequest(url: url)
// Add the body to the URL request you just created, by using JSONEncoder.
func addBody(book: Book){
    request.httpBody = try? JSONEncoder().encode(book)
}

// Add a "Content-Type" : "application/json" header to your request, so that
// the server will properly understand the body of your request.
func addAValue(){
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
}
// Set the method of the request to "POST", because we're providing information
// rather than retrieving it.
func post(){
    request.httpMethod = "POST"
}
// Create a data task for publishing this element, and kick it off with a resume().

let task = URLSession(configuration: .ephemeral).dataTask(with: request)


for book in books{
    addBody(book: book)
    addAValue()
    
    
    print(book.title + " " + " ", book.author + " " + " " + book.pubYear + " " + " " + book.url)
}
post()
task.resume()
// MARK: - HELPFUL HINTS
// You might want to create a method for publishing the data, so that you
// can effectively loop over an array of books.
//
// If you visit the URL for the service in a 'GET' request, it will return a
// list of books to you. We'll be using this list of books for Project Three.
