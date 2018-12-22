> 参考 [Using Quick Look Framework for Previewing Documents](http://www.appcoda.com/quick-look-framework/)

iOS SDK中有很多不常见，却非常好用的库，Quick Look框架就是一个非常好的例子。Quick Look框架提供了预览很多不同类型文件的功能，而不需要打开不同的APP查看，有点像Mac中的空格键功能。

Quick Look框架可以预览的文件类型：
- iWork documents (Pages, Numbers and Keynote)
- Microsoft Office documents (as long as they’ve been created with Office 97 or any other newer version)
- PDF files
- Images
- Text files
- Rich-Text Format documents
- Comma-Separated Value files (csv)

### 开始项目
到[开始项目]()处下载开始项目，这是原文提供了一个开始项目，代码是老版本的，需要转换一下。这个开始项目中包括了六种不同的类型的文件，一个navigation controller，一个table view controller（`FileListViewController`），另外还做了一些初始化工作。之后代码就在`FileListViewController`中完成。

### 文件和文件的URLS

- 在`FileListViewController`中定义一个文件名字的数组变量：
`let fileNames = ["AppCoda-PDF.pdf", "AppCoda-Pages.pages", "AppCoda-Word.docx", "AppCoda-Keynote.key", "AppCoda-Text.txt", "AppCoda-Image.jpeg"]`

- 继续定义一个数组变量，用户存储不同的文件的URL：
`var fileURLs = [NSURL]()`

- 创建一个方法`prepareFileURLs()`，用于为`fileURLs`添加值：
```
    func prepareFileURLs() {
        for file in fileNames {
            // 1
            let fileParts = file.components(separatedBy: ".")
            if let fileURL = Bundle.main.url(forResource: fileParts[0], withExtension: fileParts[1]) {
                // 2
                if FileManager.default.fileExists(atPath: fileURL.path) {
                    fileURLs.append(fileURL as NSURL)
                }
            }
        }
    }
```
  + 1 `components(separatedBy:)`方法用于把`String`按照给定的分隔符，分解成`[String]`。
  + 2 判断文件地址是否真实存在。

- 在 `viewDidLoad()`中实现上面的函数：
```
override func viewDidLoad() {
    ...
 
    prepareFileURLs()
}
```

### 展示文件
用table view展示不同的文件：
![](http://www.appcoda.com/wp-content/uploads/2016/04/t51_1_file_list.png)
- 根据文件的URL，获得文件名和文件后缀（文件类型），添加函数`extractAndBreakFilenameInComponents(:)`。
```
    func extractAndBreakFilenameInComponents(fileURL: NSURL) -> (fileName: String, fileExtension: String) {

        let fileURLParts = fileURL.path!.components(separatedBy: "/")
    
        let fileName = fileURLParts.last

        let filenameParts = fileName?.components(separatedBy: ".")
    
        return (filenameParts![0], filenameParts![1])
    }
```
- 修改 `tableView(tableView:cellForRowAtIndexPath)`：
```
func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("idCellFile", forIndexPath: indexPath)
 
    let currentFileParts = extractAndBreakFilenameInComponents(fileURLs[indexPath.row])
 
    cell.textLabel?.text = currentFileParts.fileName
 
    return cell
}
```

- 根据不同的后缀名，定义不同的文件类型名称，添加函数`getFileTypeFromFileExtension(:)`：
```
    func getFileTypeFromFileExtension(fileExtension: String) -> String {
        var fileType = ""
    
        switch fileExtension {
        case "docx":
            fileType = "Microsoft Word document"
    
        case "pages":
            fileType = "Pages document"
    
        case "jpeg":
            fileType = "Image document"
    
        case "key":
            fileType = "Keynote document"
    
        case "pdf":
            fileType = "PDF document"
    
        default:
            fileType = "Text document"
        }
    
        return fileType
    }
```

- 回到`tableView(tableView:cellForRowAtIndexPath)`，添加一段cell配置：

      cell.detailTextLabel?.text = getFileTypeFromFileExtension(fileExtension: currentFileParts.fileExtension)

- 修改每个section中row的数目为文件数目：
```
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fileNames.count
    }
```


### QLPreviewControllerDataSource

- 引入框架Quick Look 
      import QuickLook

- 定义`QLPreviewController`
      let quickLookController = QLPreviewController()

- 让`FileListViewController`实现`QLPreviewControllerDataSource`协议

- 实现`QLPreviewControllerDataSource`协议的必须要实现的方法。
第一方法表示有多少个文件需要预览：
```
    func numberOfPreviewItems(in controller: QLPreviewController) -> Int {
        return fileURLs.count
    }
```
第二个方法：
```
    func previewController(_ controller: QLPreviewController, previewItemAt index: Int) -> QLPreviewItem {
        return fileURLs[index]
    }
```

- 在`viewDidLoad()`中添加：
       quickLookController.dataSource = self


### 预览文件
在table view中选中文件，就要跳转的预览页面。实现方法`tableView(_:didSelectRowAt:)`：
```
func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if QLPreviewController.canPreview(fileURLs[indexPath.row]) {
            quickLookController.currentPreviewItemIndex = indexPath.row
            navigationController?.pushViewController(quickLookController, animated: true)
        }
    }
```
`navigationController?.pushViewController(quickLookController, animated: true)`可用`presentViewController(quickLookController, animated: true, completion: nil)`代替。

运行可预览文件：
![](http://upload-images.jianshu.io/upload_images/1678135-1f8f7308c725eab5.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

观察上图，可发现 **Quick Look Preview Controller**自带了**toolbar**，左边一个是分享按钮(通过`UIActivityViewController`实现的)，右边一个是类似目录功能，当有很多预览文件时，来跳转到不同预览文件。
![](http://www.appcoda.com/wp-content/uploads/2016/04/t51_4_switch_document.png)


### 代码
[QuickLookDemo](https://github.com/andyRon/LearniOSByProject/tree/master/P075-QuickLookDemo)
