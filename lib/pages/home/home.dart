import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:web_portfolio/main.dart';
import 'package:web_portfolio/pages/home/components/carousel.dart';
import 'package:web_portfolio/pages/home/components/cv_section.dart';
import 'package:web_portfolio/pages/home/components/education_section.dart';
import 'package:web_portfolio/pages/home/components/footer.dart';
import 'package:web_portfolio/pages/home/components/header.dart';
import 'package:web_portfolio/pages/home/components/ios_app_ad.dart';
import 'package:web_portfolio/pages/home/components/portfolio_stats.dart';
import 'package:web_portfolio/pages/home/components/skill_section.dart';
import 'package:web_portfolio/pages/home/components/testimonial_widget.dart';
import 'package:web_portfolio/pages/home/components/website_ad.dart';
import 'package:web_portfolio/utils/constants.dart';
import 'package:web_portfolio/utils/globals.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: Globals.scaffoldKey,
      endDrawer: Drawer(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 24.0,
            ),
            child: ListView.separated(
              itemBuilder: (BuildContext context, int index) {
                return headerItems[index].isButton
                    ? MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: Container(
                          decoration: BoxDecoration(
                            color: kDangerColor,
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 28.0),
                          child: TextButton(
                            onPressed: (){
                              if(Globals.scaffoldKey.currentState.isDrawerOpen)
                              {
                                Navigator.maybePop(context);
                              }
                                return headerItems[index].onTap;
                            },
                            child: Text(
                              headerItems[index].title,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 13.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      )
                    : ListTile(
                        title: Text(
                          headerItems[index].title,
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                  onTap: () async {
                    print("IN TAP");
                    if(Globals.scaffoldKey.currentState.isEndDrawerOpen)
                    {
                      print("DRAWER OPEN");
                      await Navigator.maybePop(context);
                    }
                    String title = headerItems[index].title;
                    switch(title)
                    {
                      case 'HOME' : Scrollable.ensureVisible(cvKey.currentContext);
                      break;
                      case 'TECHNICAL SKILLS' : Scrollable.ensureVisible(skillsKey.currentContext);
                      break;
                      case 'EDUCATION' : Scrollable.ensureVisible(educationKey.currentContext);
                      break;
                      case 'TESTIMONIALS' : Scrollable.ensureVisible(testimonialKey.currentContext);
                      break;
                      case 'CONTACT' : Scrollable.ensureVisible(contactKey.currentContext);
                      break;
                    }
                  },
                      );
              },
              separatorBuilder: (BuildContext context, int index) {
                return SizedBox(
                  height: 10.0,
                );
              },
              itemCount: headerItems.length,
            ),
          ),
        ),
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: Header(),
              ),
              Carousel(),
              SizedBox(
                height: 20.0,
              ),
              Container(
                key: cvKey,
                  child: CvSection()
              ),
              Container(
                  key: iosAppKey,
                  child: IosAppAd()),
              SizedBox(
                height: 70.0,
              ),
              Container(
                key: websiteKey,
                  child: WebsiteAd()),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 28.0),
                child: Container(
                    key: portfolioKey,
                    child: PortfolioStats()),
              ),
              SizedBox(
                height: 50.0,
              ),
              Container(
                  key: educationKey,
                  child: EducationSection()),
              SizedBox(
                height: 50.0,
              ),
              Container(
                  key: skillsKey,
                  child: SkillSection()),
              SizedBox(
                height: 50.0,
              ),
              SizedBox(
                height: 50.0,
              ),
              Container(
                  key: testimonialKey,
                  child: TestimonialWidget()),
              Container(
                  key: contactKey,
                  child: Footer()),
            ],
          ),
        ),
      ),
    );
  }
}
