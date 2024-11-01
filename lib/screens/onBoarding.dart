import 'package:flutter/material.dart';
import 'package:notes_app/constants/colors.dart';
import 'package:notes_app/constants/images.dart';
import 'package:notes_app/shared/network/local_network/preferences_helper.dart';
import 'package:notes_app/screens/home.dart';
import 'package:notes_app/shared/shared_component/default_button.dart';


class OnBoadringScreen extends StatefulWidget {
  const OnBoadringScreen({super.key});

  @override
  State<OnBoadringScreen> createState() => _OnBoadringScreenState();
}

class _OnBoadringScreenState extends State<OnBoadringScreen> {
  var pageController = PageController();

  int pageIndex = 0;
  List<String> headlines = [
    "Generate and Manage Notes",
    "Update Your Notes Anytime",
    "Delete Unwanted Notes",
    "Sort and Search Your Notes",
  ];
  List<String> subTitle = [
    "Instantly create new notes with a single tap, so you never miss capturing your thoughts.",
    " Modify your notes easily whenever you need to make updates or revisions.",
    "Quickly remove notes you no longer need, keeping your workspace clean and tidy.",
    "Efficiently manage your notes by sorting them based on creation or update date, and quickly find specific notes using the powerful search function. Just type in keywords to locate your notes in seconds."
  ];
  List<String> imagePath = [
    ImageUtility.onBoarding1,
    ImageUtility.onBoarding2,
    ImageUtility.onBoarding3,
    ImageUtility.onBoarding4,
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorUtility.secondary,
        body: SafeArea(
            child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: PageView(
            controller: pageController,
            children: List.generate(
              4,
              (index) {
                return onBoadringItem(
                    context: context,
                    index: index,
                    headline: headlines[index],
                    imagePath: imagePath[index],
                    subTitle: subTitle[index],
                    pageController: pageController);
              },
            ),
            onPageChanged: (value) {
              pageIndex = value;
              setState(() {});
            },
          ),
        ),
        onBoardingFotter()
      ],
    )));
  }

  Padding onBoardingFotter() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          pageIndex != 0
              ? onBoardingArrow(
                  icon: Icons.arrow_back,
                  onClick: () {
                    pageController.previousPage(
                        duration: const Duration(milliseconds: 5),
                        curve: Curves.bounceIn);
                  })
              : const SizedBox(),
          const SizedBox(width: 10),
          Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                4,
                (index) {
                  return Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          pageController.jumpToPage(index);
                          pageIndex = index;
                        });
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 1),
                        height: 15,
                        width: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: index == pageIndex
                              ? ColorUtility.main
                              : ColorUtility.lightBlack,
                        ),
                      ),
                    ),
                  );
                },
              )),
          const SizedBox(width: 10),
          pageIndex != 3
              ? onBoardingArrow(
                  icon: Icons.arrow_forward,
                  onClick: () {
                    pageController.nextPage(
                        duration: const Duration(milliseconds: 5),
                        curve: Curves.bounceIn);
                  })
              : const SizedBox()
        ],
      ),
    );
  }
}

Widget onBoadringItem(
    {required String headline,
    required String subTitle,
    required String imagePath,
    var pageController,
    required int index,
    required BuildContext context}) {
  return SingleChildScrollView(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            Image.asset(
              imagePath,
              width: double.infinity,
              fit: BoxFit.cover,
              height: 300,
            ),
            index != 3
                ? Row( 
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                          onPressed: () {
                            pageController.jumpToPage(3); 
                          },
                          child:  Text(
                            "Skip",
                            style:
                                TextStyle(fontSize: 19, color: index == 0?ColorUtility.main: ColorUtility.white),
                          )),
                    ],
                  )
                : const Text("")
          ],
        ),
        const SizedBox(height: 30),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: Text(
            headline,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: ColorUtility.white,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: Text(
            subTitle,
            style: const TextStyle(
              fontSize: 17,
              color: ColorUtility.lightGrey,
            ),
          ),
        ),
        index == 3
            ? Padding(
                padding: const EdgeInsets.symmetric(vertical: 50),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    defaultButton(
                      context: context,
                      title: "Let's Start",
                      onClick: () async {
                        await PreferenceHelper.isOnBoardingSeen(
                            isOnBoardingSeen: true);
                          
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const HomeScreen()),
                        );
                      },
                    )
                  ],
                ),
              )
            : const Text("")
      ],
    ),
  );
}

Widget onBoardingArrow({
  required VoidCallback onClick,
  required IconData icon,
}) {
  return AnimatedContainer(
    duration: const Duration(milliseconds: 2),
    height: 40,
    width: 40,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(30),
      color: ColorUtility.main,
    ),
    child: IconButton(
      icon: Icon(icon, color: Colors.white),
      onPressed: onClick,
    ),
  );
}
