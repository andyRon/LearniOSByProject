> 参考：[Parsing XML Tutorial](https://www.ioscreator.com/tutorials/parsing-xml-tutorial)

使用`XMLParser`解析XML文件，然后用table展示数据。

- 以**Single View Application**模板新建项目**XMLParserTutorial**。
- 删除SB中的View Controller，拖进一个Navigation Controller。选择新的View Controller为 "Is Initial View Controller"。设置Navigation Bar的title为*Books*。
- 新建一个继承至`UITableViewController`，名为`TableViewController`的控制器文件，并与SB的控制器关联。
- 新建一个xml文件`Books.xml`，用于之后解析，文件内容为:
```
<?xml version="1.0"?>
<catalog>
    <book id="1">
        <title>To Kill a Mockingbird</title>
        <author>Harper Lee</author>
    </book>
    <book id="2">
        <title>1984</title>
        <author>George Orwell</author>
    </book>
    <book id="3">
        <title>The Lord of the Rings</title>
        <author>J.R.R Tolkien</author>
    </book>
    <book id="4">
        <title>The Catcher in the Rye</title>
        <author>J.D. Salinger</author>
    </book>
    <book id="5">
        <title>The Great Gatsby</title>
        <author>F. Scott Fitzgerald</author>
    </book>
</catalog>
```

- 新建一个文件 `Book.swift`：
```
import Foundation

class Book {
    var bookTitle: String = ""
    var bookAuthor: String = ""
}
```
- 在`TableViewController`中添加几个变量：
```
    var books: [Book] = []
    var eName: String = ""
    var bookTitle = ""
    var bookAuthor = ""
```

- 在`viewDidLoad`方法中，添加读取XMl文件代码：
```
    override func viewDidLoad() {
        super.viewDidLoad()

        if let path = Bundle.main.url(forResource: "Books", withExtension: "xml") {
            if let parser = XMLParser(contentsOf: path) {
                parser.delegate = self
                parser.parse()
            }
        }
```

- 添加Table View的数据源代理方法：

```
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return books.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        let book = books[indexPath.row]
        cell.textLabel?.text = book.bookTitle
        cell.detailTextLabel?.text = book.bookAuthor

        return cell
    }
```

- 让`TableViewController`采纳`XMLParserDelegate`协议：

      class TableViewController: UITableViewController, XMLParserDelegate 

- 实现`XMLParserDelegate`中的三个方法：
```
    // 解析XMl元素开始时
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        print("开始 \(elementName)")
        eName = elementName
        if elementName == "book" {
            bookTitle = ""
            bookAuthor = ""
        }
    }
    // 正在解析XMl元素
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        print("ing \(eName)")
        let data = string.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines)
        
        if (!data.isEmpty) {
            if eName == "title" {
                bookTitle += data
            } else if eName == "author" {
                bookAuthor += data
            }
        }
    }
    // 结束解析XMl元素
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        print("结束 \(elementName)")
        if elementName == "book" {
            
            let book = Book()
            book.bookTitle = bookTitle
            book.bookAuthor = bookAuthor
            
            books.append(book)
        }
    }
```
三个方法分别在XMl元素开始解析、正在解析、结束解析时调用，也就是说有很多元素时就不停在调用这三个方法。

![](http://upload-images.jianshu.io/upload_images/1678135-d35b99babadabe34.jpg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)


### 代码
[XMLParserTutorial](https://github.com/andyRon/LearniOSByProject/tree/master/P025-XMLParserTutorial)
