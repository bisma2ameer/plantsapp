import 'package:flutter/material.dart';
import 'package:plantsapp/constants.dart';
import 'package:plantsapp/design/login.dart';
import 'package:plantsapp/design/root_page.dart';

class OnboardingScreen extends StatefulWidget {
  OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController(initialPage: 0);
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 20, top: 20),
            child: InkWell(
              onTap: (() {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=> const RootPage())); 
              }
              ),
              child: Text(
                'Skip',
                style: TextStyle(
                    color: Colors.grey,
                    fontSize: 16,
                    fontWeight: FontWeight.w400),
              ),
            ),
          )
        ],
        title: const Text('Onboarding Screen'),
      ),
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          PageView(
            onPageChanged: (int page) {
              setState(() {
                currentIndex = page;
              });
            },
            controller: _pageController,
            children: [
              createPage(
                image: 'assets/images/plant-one.png',
                titleOne: Constants.titleOne,
                descriptionOne: Constants.descriptionOne,
              ),
              createPage(
                image: 'assets/images/plant-two.png',
                titleOne: Constants.titleTwo,
                descriptionOne: Constants.descriptionTwo,
              ),
              createPage(
                image: 'assets/images/plant-three.png',
                titleOne: Constants.titleThree,
                descriptionOne: Constants.descriptionThree,
              ),
            ],
          ),
          Positioned(
           bottom: 80,
            left: 30,
              child: Row(
                
            children: _buildIndicator(),
          )),
          Positioned(
            bottom: 60,
            right: 30,
            child: Container(child: 
            IconButton(onPressed: (){
              setState(() {
                if(currentIndex < 2){
                  currentIndex++;
                  if(currentIndex < 3){
                    _pageController.nextPage(duration: Duration(milliseconds: 300), curve: Curves.easeIn);
                  }
                }
                else{
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=> const RootPage()));
                }
              });
            },
             icon: Icon(Icons.arrow_forward_ios, color: Colors.white,size: 24,),),
             padding:  EdgeInsets.all(4),
             decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Constants.primaryColor,
             ),
             ),
             
          )
        ],
      ),
    );
  }

  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      duration: Duration(
        milliseconds: 300,
      ),
      height: 10,
      width: isActive ? 20 : 8,
      margin: EdgeInsets.only(right: 5),
      decoration: BoxDecoration(
        color: Constants.primaryColor,
        borderRadius: BorderRadius.circular(5),
      ),
    );
  }

  List<Widget> _buildIndicator() {
    List<Widget> _indicators = [];
    for (int i = 0; i < 3; i++) {
      if (currentIndex == i) {
        _indicators.add(_indicator(true));
      } else {
        _indicators.add(_indicator(false));
      }
    }
    return _indicators;
  }
}

class createPage extends StatelessWidget {
  final String image;
  final String titleOne;
  final String descriptionOne;
  const createPage({
    super.key,
    required this.image,
    required this.titleOne,
    required this.descriptionOne,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 80, right: 50, bottom: 80),
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        SizedBox(
          height: 350,
          child: Image.asset(image),
        ),
        const SizedBox(
          height: 20,
        ),
        Text(
          titleOne,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Constants.primaryColor,
            fontWeight: FontWeight.bold,
            fontSize: 30,
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Text(
          descriptionOne,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.grey,
            fontWeight: FontWeight.w400,
            fontSize: 20,
          ),
        ),
      ]),
    );
  }
}
