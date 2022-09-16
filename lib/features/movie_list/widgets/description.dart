import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:desktop_webview_window/desktop_webview_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:smart_tv/features/movie_list/controller/movie_controller.dart';
import 'package:smart_tv/features/movie_list/utilits/text.dart';
import 'package:video_player/video_player.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import '../../../config/intentFiles/down_intent.dart';
import '../../../config/intentFiles/left_intent.dart';
import '../../../config/intentFiles/right_intent.dart';
import '../../../config/intentFiles/up_intent.dart';

class Description extends StatefulWidget {
  final String name, description, bannerurl, posterurl, vote, lauchOn;

  const Description(
      {Key? key,
      required this.bannerurl,
      required this.description,
      required this.lauchOn,
      required this.name,
      required this.posterurl,
      required this.vote})
      : super(key: key);

  @override
  State<Description> createState() => _DescriptionState();
}

class _DescriptionState extends State<Description> {
  late VideoPlayerController _videoPlayerController;

  bool? _webviewAvailable;

  WebViewController? _webViewController;
  //String filePathe = 'assets/playvideo.html';
  MoviesController controller = Get.find();

  @override
  void initState() {
    super.initState();
    WebviewWindow.isWebviewAvailable().then((value) => setState(() {
          _webviewAvailable = value;
        }));
    _videoPlayerController = VideoPlayerController.network(
        "https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4")
      ..initialize().then((_) => setState(() {}));
  }

  @override
  void dispose() {
    super.dispose();
    _videoPlayerController.dispose();
  }

  _changeNodeFocus(BuildContext build, String direction) {
    if (direction == "Down") {
      controller.DownNavActions(context);
      setState(() {});
    } else if (direction == "Up") {
      controller.UpNavActions(context);
      setState(() {});
    } else if (direction == "Right") {
      controller.RightNavActions(context);
      setState(() {});
    } else if (direction == "Left") {
      controller.LeftNavActions(context);
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          leading: GetPlatform.isDesktop || GetPlatform.isWeb
              ? IconButton(
                  icon: const Icon(
                    Icons.arrow_back,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                )
              : const SizedBox.shrink()),
      backgroundColor: Colors.black,
      body: Shortcuts(
        shortcuts: {
          LogicalKeySet(LogicalKeyboardKey.select): const ActivateIntent(),
          LogicalKeySet(LogicalKeyboardKey.arrowRight): RightbuttonIntent(),
          LogicalKeySet(LogicalKeyboardKey.arrowLeft): LeftbuttonIntent(),
          LogicalKeySet(LogicalKeyboardKey.arrowUp): UpbuttonIntent(),
          LogicalKeySet(LogicalKeyboardKey.arrowDown): DownbuttonIntent(),
        },
        child: Actions(
          actions: <Type, Action<Intent>>{
            DownbuttonIntent: CallbackAction<DownbuttonIntent>(
                onInvoke: (Intent) => _changeNodeFocus(context, "Down")),
            UpbuttonIntent: CallbackAction<UpbuttonIntent>(
                onInvoke: (Intent) => _changeNodeFocus(context, "Up")),
            RightbuttonIntent: CallbackAction<RightbuttonIntent>(
                onInvoke: (Intent) => _changeNodeFocus(context, "Right")),
            LeftbuttonIntent: CallbackAction<LeftbuttonIntent>(
                onInvoke: (Intent) => _changeNodeFocus(context, "Left")),
          },
          child: ListView(
            controller: controller.descPageScrollController,
            children: [
              SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: Stack(
                    children: [
                      !_videoPlayerController.value.isInitialized
                          ? Positioned(
                              child: SizedBox(
                                height: 500,
                                width: MediaQuery.of(context).size.width,
                                child: Image.network(
                                  widget.bannerurl,
                                  fit: BoxFit.fill,
                                ),
                              ),
                            )
                          : AspectRatio(
                              aspectRatio:
                                  _videoPlayerController.value.aspectRatio,
                              child: VideoPlayer(_videoPlayerController),
                            ),
                      Center(
                        child: Focus(
                          focusNode: controller.descNodes![0],
                          child: IconButton(
                            icon: Icon(
                              !_videoPlayerController.value.isPlaying
                                  ? Icons.play_circle_fill_rounded
                                  : Icons.pause_circle_filled_rounded,
                              color: controller.descNodes![0].hasFocus
                                  ? Colors.amber
                                  : Colors.white,
                              size: 40,
                            ),
                            onPressed: () async {
                              _videoPlayerController.value.isPlaying
                                  ? _videoPlayerController.pause()
                                  : _videoPlayerController.play();
                              log("Video is ${_videoPlayerController.value}");
                            },
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 5,
                        child: Focus(
                          focusNode: controller.descNodes![1],
                          child: ModifiedText(
                              text: '⭐Average Rating - ${widget.vote}',
                              color: controller.descNodes![1].hasFocus
                                  ? Colors.amber
                                  : Colors.white60,
                              size: 20),
                        ),
                      ),
                    ],
                  )),
              Focus(
                focusNode: controller.descNodes![2],
                child: Container(
                  padding: const EdgeInsets.all(10),
                  child: ModifiedText(
                      text: widget.name, color: Colors.white60, size: 15),
                ),
              ),
              Focus(
                focusNode: controller.descNodes![3],
                child: Container(
                  padding: const EdgeInsets.only(left: 5),
                  child: ModifiedText(
                      text: 'Releasing On - ${widget.lauchOn}',
                      color: Colors.white60,
                      size: 15),
                ),
              ),
              Focus(
                focusNode: controller.descNodes![4],
                child: Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.all(5),
                      height: 200,
                      width: 100,
                      child: Image.network(widget.posterurl),
                    ),
                    Flexible(
                      child: Container(
                        child: ModifiedText(
                            text: widget.description,
                            color: Colors.white60,
                            size: 15),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
  // Future<String> _getWebViewPath() async {

}

//   _loadHtmlFromAssets() async {
//     // String fileHtml = await rootBundle.loadString(filePathe);
//     // _webViewController!.loadUrl(Uri.dataFromString(fileHtml,
//     //         mimeType: 'text/html', encoding: Encoding.getByName('utf-8'))
//     //     .toString());
//     final document = await getApplicationDocumentsDirectory();
//     return p.join(
//       document.path,
//       "desktop_webview_window",
//     );
//   }
// }

// class HtmlPlayVideo extends StatefulWidget {
//   const HtmlPlayVideo({Key? key}) : super(key: key);

//   @override
//   State<HtmlPlayVideo> createState() => _HtmlPlayVideoState();
// }

// class _HtmlPlayVideoState extends State<HtmlPlayVideo> {
//   InAppWebViewController? controller;
//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: () async {
//         if (await controller!.canGoBack()) {
//           return false;
//         }
//         return true;
//       },
//       child: Scaffold(
//         body: Container(
//           child: InAppWebView(
//             initialUrlRequest: URLRequest(
//                 url: Uri.parse("http://localhost:3030/assets/playvideo.html")),
//             onWebViewCreated: (InAppWebViewController controller) {
//               var webView = controller;
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }

// const String playVideo = """
// <!DOCTYPE html>
// <html>
//   <head>
//     <base hre="" />
//     <meta charset="UTF-8" />
//     <meta conten="IE-Edge" http-equiv="X-UA-Compatible" />
//     <meta name="description" content="Trying Vdieo with WebView" />
//     <meta name="apple-mobile-web-app-capable" content="yes" />
//     <title>Let's play</title>
//   </head>
//   <body>
//     <video with="320" height="240" controls>
//       <source
//         src="https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4"
//         type="video/mp4"
//       />
//     </video>
//   </body>
// </html>
// """
