import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:web_portfolio/models/testimonial.dart';
import 'package:web_portfolio/utils/constants.dart';
import 'package:web_portfolio/utils/screen_helper.dart';

final List<Testimonial> testimonials = [
  Testimonial(
    text: "He has been actively and diligently involved in the projects and tasks assigned to him. He was very impressive in handling the tasks as well as collabrating with the team.",
    occupation: "Manager- Human Resource",
    personName: "Ms.Akanksha Jain",
    profilePhoto: "assets/female.png",
  ),
  Testimonial(
    text:
        "Akshat is a dedicated and skilled developer with ability to pickup new skills very quickly. He never complained of the work assigned to him and completed all taks on time and missed no deadlines. I want to wish him best of luck and it was a pleasure working with such an enthusiastic and dedicated young person. One of the best interns I have trained under me.",
    occupation: "Tech Lead",
    personName: "Shivansh Sharma",
    profilePhoto: "assets/male.png",
  )
];

class TestimonialWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ScreenHelper(
        desktop: _buildUi(kDesktopMaxWidth),
        tablet: _buildUi(kTabletMaxWidth),
        mobile: _buildUi(getMobileMaxWidth(context)),
      ),
    );
  }
}

Widget _buildUi(double width) {
  return Center(
    child: LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return ResponsiveWrapper(
          maxWidth: width,
          minWidth: width,
          defaultScale: false,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "TESTIMONIALS",
                style: GoogleFonts.oswald(
                  color: Colors.white,
                  fontWeight: FontWeight.w900,
                  fontSize: 30.0,
                  height: 1.3,
                ),
              ),
              SizedBox(
                height: 5.0,
              ),
              Container(
                constraints: BoxConstraints(maxWidth: 400.0),
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text:
                            "Glad to share feedbacks received from professionals of my past recruiters!",
                        style: TextStyle(color: Colors.white, height: 1.8),
                      ),
                      TextSpan(
                        text: ". Please reach me out to know more :-)",
                        style: TextStyle(color: Colors.white, height: 1.8),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 45.0,
              ),
              Flex(
                direction: ScreenHelper.isMobile(context)
                    ? Axis.vertical
                    : Axis.horizontal,
                // Lets map
                children: testimonials.map((testimonial) {
                  return Expanded(
                    flex: ScreenHelper.isMobile(context) ? 0 : 1,
                    child: Container(
                      padding: const EdgeInsets.all(8.0),
                      margin: EdgeInsets.only(bottom: 50.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            child: Image.asset(
                              "assets/quote.png",
                              width: 50.0,
                            ),
                          ),
                          SizedBox(
                            height: 15.0,
                          ),
                          Text(
                            testimonial.text,
                            style: TextStyle(
                              color: kCaptionColor,
                              height: 1.8,
                            ),
                          ),
                          SizedBox(
                            height: 15.0,
                          ),
                          Row(
                            children: [
                              CircleAvatar(
                                radius: 25.0,
                                backgroundColor: Colors.transparent,
                                backgroundImage: AssetImage(
                                  testimonial.profilePhoto,
                                ),
                              ),
                              SizedBox(
                                width: 20.0,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    testimonial.personName,
                                    style: GoogleFonts.oswald(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 16.0,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 4.0,
                                  ),
                                  Text(
                                    testimonial.occupation,
                                    style: TextStyle(
                                      color: kCaptionColor,
                                    ),
                                  )
                                ],
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        );
      },
    ),
  );
}
