import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:web_portfolio/models/design_process.dart';
import 'package:web_portfolio/utils/constants.dart';
import 'package:web_portfolio/utils/screen_helper.dart';
import 'package:dio/dio.dart';
import 'dart:html' as html;
import 'package:web_portfolio/main.dart';


final List<DesignProcess> designProcesses = [
  DesignProcess(
    title: "DEVELOP",
    imagePath: "assets/develop.png",
    subtitle:
        "A software developer with hands on experience in app development for both android and ios. Also have knowledge of python and java.",
  ),
];

class CvSection extends StatelessWidget {
  var dio = Dio();


  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: ScreenHelper(
        desktop: _buildUi(context, kDesktopMaxWidth),
        tablet: _buildUi(context, kTabletMaxWidth),
        mobile: _buildUi(context, getMobileMaxWidth(context)),
      ),
    );
  }

  Widget _buildUi(BuildContext context, double width) {
    // we need the context to get maxWidth before the constraints below
    return ResponsiveWrapper(
      maxWidth: width,
      minWidth: width,
      defaultScale: false,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "BETTER DEVELOPMENT,\nBETTER EXPERIENCES",
                style: GoogleFonts.oswald(
                  color: Colors.white,
                  fontWeight: FontWeight.w900,
                  height: 1.8,
                  fontSize: 18.0,
                ),
              ),
              GestureDetector(
                onTap: () async {
                  if(kIsWeb)
                  {
                    Fluttertoast.showToast(msg: "Downloading..",backgroundColor: Colors.green);
                    print("IS WEB");
                    html.AnchorElement anchorElement =  new html.AnchorElement(href: 'https://drive.google.com/uc?export=download&id=1xOExRA4sS9Ow6aoKHDjUVcc0R751702-');
                    anchorElement.download = 'https://drive.google.com/uc?export=download&id=1xOExRA4sS9Ow6aoKHDjUVcc0R751702-';
                    anchorElement.click();
                  }

                  else
                  {
                    if (Platform.isAndroid)
                    {
                      await Permission.storage.request();
                      if (await Permission.storage.isGranted) {
                        Directory dir = await Directory(
                            "storage/emulated/0/Download/Portfolio").create(
                            recursive: true);
                        String path = dir.path;
                        String fileName = "Portfolio" + DateTime
                            .now()
                            .millisecondsSinceEpoch
                            .toString();
                        print("PATH $path");
                        Fluttertoast.showToast(msg: "Downloading..");
                        Response response = await dio.download(
                          'https://drive.google.com/uc?export=download&id=1xOExRA4sS9Ow6aoKHDjUVcc0R751702-',
                          '$path/$fileName.pdf',)
                            .whenComplete(() {
                          OpenFile.open("$path/$fileName.pdf");
                          Fluttertoast.showToast(msg: "File downloaded!",
                              backgroundColor: Colors.green);
                        });
                      }
                    }
                  }
                  },
                child: MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: Text(
                    "DOWNLOAD CV",
                    style: GoogleFonts.oswald(
                      color: kPrimaryColor,
                      fontWeight: FontWeight.w900,
                      fontSize: 16.0,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 50.0,
          ),
          Container(
            child: LayoutBuilder(
              builder: (_context, constraints) {
                return ResponsiveGridView.builder(
                  padding: EdgeInsets.all(0.0),
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  alignment: Alignment.topCenter,
                  gridDelegate: ResponsiveGridDelegate(
                    mainAxisSpacing: 20.0,
                    crossAxisSpacing: 20.0,
                    maxCrossAxisExtent: ScreenHelper.isTablet(context) ||
                            ScreenHelper.isMobile(context)
                        ? constraints.maxWidth / 2.0
                        : 250.0,
                    // Hack to adjust child height
                    childAspectRatio: ScreenHelper.isDesktop(context)
                        ? 1
                        : MediaQuery.of(context).size.aspectRatio * 1.5,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Image.asset(
                                designProcesses[index].imagePath,
                                width: 40.0,
                              ),
                              SizedBox(
                                width: 15.0,
                              ),
                              Text(
                                designProcesses[index].title,
                                style: GoogleFonts.oswald(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 15.0,
                          ),
                          Text(
                            designProcesses[index].subtitle,
                            style: TextStyle(
                              color: kCaptionColor,
                              height: 1.5,
                              fontSize: 14.0,
                            ),
                          )
                        ],
                      ),
                    );
                  },
                  itemCount: designProcesses.length,
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
