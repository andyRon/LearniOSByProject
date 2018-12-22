FacebookMe
--------

FacebookMe项目通过UITableView的不同Section模拟Facebook的个人页面。



### 预览图

![](FacebookMe.jpg)



### 重点

通过定义一个结构体`TableKeys`来把用户个人的列表项的文字统一在一起。

```swift
public struct TableKeys {
    static let Section = "section"
    static let Rows = "rows"
    static let ImageName = "imageName"
    static let Title = "title"
    static let SubTitle = "subTitle"
    static let seeMore = "See More..."
    static let addFavorites = "Add Favorites..."
    static let logout = "Log Out"
    
    static func populate(withUser user: FBMeUser) -> [[String: Any]] {
        return [
            [
                TableKeys.Rows: [
                    [TableKeys.ImageName: user.avatarName, TableKeys.Title: user.name, TableKeys.SubTitle: "View your profile"]
                ]
            ],
            [
                TableKeys.Rows: [
                    [TableKeys.ImageName: Specs.imageName.friends, TableKeys.Title: "Friends"],
                    [TableKeys.ImageName: Specs.imageName.events, TableKeys.Title: "Events"],
                    [TableKeys.ImageName: Specs.imageName.groups, TableKeys.Title: "Groups"],
                    [TableKeys.ImageName: Specs.imageName.education, TableKeys.Title: user.education],
                    [TableKeys.ImageName: Specs.imageName.townHall, TableKeys.Title: "Town Hall"],
                    [TableKeys.ImageName: Specs.imageName.instantGames, TableKeys.Title: "Instant Games"],
                    [TableKeys.Title: TableKeys.seeMore]
                ]
            ],
            [
                TableKeys.Section: "FAVORITES",
                TableKeys.Rows: [
                    [TableKeys.Title: TableKeys.addFavorites]
                ]
            ],
            [
                TableKeys.Rows: [
                    [TableKeys.ImageName: Specs.imageName.settings, TableKeys.Title: "Settings"],
                    [TableKeys.ImageName: Specs.imageName.privacyShortcuts, TableKeys.Title: "Privacy Shortcuts"],
                    [TableKeys.ImageName: Specs.imageName.helpSupport, TableKeys.Title: "Help and Support"]
                ]
            ],
            [
                TableKeys.Rows: [
                    [TableKeys.Title: TableKeys.logout]
                ]
            ]
        ]
        
    }
}
```



通过定义另一个`Spec`结构体，来定义一些颜色、字体常用大小、字体格式、图片名等，这样方便以后的修改。

```swift
/*
 这样定义一些常量和参数，很明了
 Specs  specification  说明书, 详细的计划书
 */
public struct Specs {
    public struct Color {
        public let tint = UIColor(hex: 0x3b5998)
        public let red = UIColor.red
        public let white = UIColor.white
        public let black = UIColor.black
        public let gray = UIColor.lightGray
        public let mygray = UIColor(hex: 0xF0EFF4)
    }
    
    public struct FontSize {
        public let tiny: CGFloat = 10
        public let small: CGFloat = 12
        public let regular: CGFloat = 14
        public let large: CGFloat = 16
    }
    
    public struct Font {
        private static let regularName = "Helvetica Neue"
        private static let boldName = "Helvetica Neue Bold"
        public let tiny = UIFont(name: regularName, size: Specs.fontSize.tiny)
        public let small = UIFont(name: regularName, size: Specs.fontSize.small)
        public let regular = UIFont(name: regularName, size: Specs.fontSize.regular)
        public let large = UIFont(name: regularName, size: Specs.fontSize.large)
        public let smallBold = UIFont(name: boldName, size: Specs.fontSize.small)
        public let regularBold = UIFont(name: boldName, size: Specs.fontSize.regular)
        public let largeBold = UIFont(name: boldName, size: Specs.fontSize.large)
    }
    
    public struct ImageName {
        public let friends = "fb_friends"
        public let events = "fb_events"
        public let groups = "fb_groups"
        public let education = "fb_education"
        public let townHall = "fb_town_hall"
        public let instantGames = "fb_games"
        public let settings = "fb_settings"
        public let privacyShortcuts = "fb_privacy_shortcuts"
        public let helpSupport = "fb_help_and_support"
        public let placeholder = "fb_placeholder"
    }
    ...
}    
```





### 关于Visual Format Language

```swift
NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[tableView]-0-|", options: .directionLeadingToTrailing, metrics: nil, views: ["tableView": tableView])
```

上面的类似`"H:|-0-[tableView]-0-|"`叫做**Visual Format Language**，官方的Auto Layout Guide 的[Programmatically Creating Constraints](https://developer.apple.com/library/archive/documentation/UserExperience/Conceptual/AutolayoutPG/ProgrammaticallyCreatingConstraints.html#//apple_ref/doc/uid/TP40010853-CH16-SW1)中有过定义：

> The Visual Format Language lets you use ASCII-art like strings to define your constraints. This provides a visually descriptive representation of the constraints. 
> 可视格式语言可以使用类似字符串的ASCII字符串来定义约束。 这提供了约束的视觉描述性表示。

另外这边 [Visual Format Language](https://developer.apple.com/library/archive/documentation/UserExperience/Conceptual/AutolayoutPG/VisualFormatLanguage.html) ，是其使用方式。

这边的教程 [Auto Layout Visual Format Language Tutorial](https://www.raywenderlich.com/277-auto-layout-visual-format-language-tutorial)，也不错。

