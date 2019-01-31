**OpenGLKit**——入门OpenGL

-----

OpenGL ES (OpenGL for Embedded Systems) 是 OpenGL 三维图形 API 的子集，针对手机、PDA和游戏主机等[嵌入式设备](https://baike.baidu.com/item/%E5%B5%8C%E5%85%A5%E5%BC%8F%E8%AE%BE%E5%A4%87/10055189)而设计。该API由Khronos集团定义推广，Khronos是一个图形软硬件行业协会，该协会主要关注图形和多媒体方面的开放标准。



OpenGL ES 是从 OpenGL 裁剪的定制而来的，去除了glBegin/glEnd，四边形（GL_QUADS）、[多边形](https://baike.baidu.com/item/%E5%A4%9A%E8%BE%B9%E5%BD%A2)（GL_POLYGONS）等复杂图元等许多非绝对必要的特性。经过多年发展，现在主要有两个版本，OpenGL ES 1.x 针对固定管线硬件的，OpenGL ES 2.x 针对可编程管线硬件。



### GLKView 和 GLKViewController



`GLKView`的**Color Format**默认是`GLKViewDrawableColorFormatRGBA8888`，meaning that eight bits are used for each color component in the buffer (four total bytes per pixel).







![](https://ws2.sinaimg.cn/large/006tNc79gy1fzq1aecuz3g30ag0ikhdt.gif)



### 参考

[GLKit Tutorial for iOS: Getting started with OpenGL ES](https://www.raywenderlich.com/5146-glkit-tutorial-for-ios-getting-started-with-opengl-es)