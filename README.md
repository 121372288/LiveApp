# LiveApp
从零开始的直播App

# 使用方式
导入后 需要pods安装
还有导入 IJKMediaFramework.framework 才能正常使用

# 功能介绍

具有完整的直播功能，主Tap中有两个可选切换页面，最热和最新， 两页用scrollView管理，两页本身子视图为TableView和CollectionView，播放页面单独处理使用present方式显示，使用分三页ScrolView的方式，处理播放页面的侧滑切换，目前还没测是否用collectionView的性能更好。
播放功能主要使用IJKMediaframework框架实现，模拟器上略显卡顿，视频和音频不同步，但是真机使用很流畅，无掉帧现象。视图大多使用模块化，较少控制器代码量，代码更易读，并减少以后修改维护的难度。
