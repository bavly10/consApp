import 'package:flutter/material.dart';
import 'package:helpy_app/modules/User/cubit/cubit.dart';
import 'package:helpy_app/shared/my_colors.dart';
import 'package:hexcolor/hexcolor.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            _showShapedDialog();
          }),
    );
  }

  _showShapedDialog() {
    showDialog(
      context: context,
      builder: (context) {
        double height = MediaQuery.of(context).size.height * 0.27;
        return Padding(
          padding: const EdgeInsets.fromLTRB(24.0, 20.0, 24.0, 24.0),
          child: ClipPath(
            child: Material(
              shape: RoundedRectangleBorder(
                  side: BorderSide.none,
                  borderRadius: BorderRadius.circular(20)),
              shadowColor: Colors.grey,
              color: Colors.white,
              child: Container(
                child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Policy Privacy",
                          style: TextStyle(
                              color: myAmber, fontWeight: FontWeight.bold),
                        ),
                      ),
                      const Text(
                        "con built the Consolutios app as a Commercial app This SERVICE is provided by con and is intended for This page is used to inform visitors regarding our policies with the collection use and disclosure of Personal Information if anyone decided to use our Service If you choose to use our Service, then you agree to the collection and use of information in relation to this policy. The Personal Information that we collect is used for providing and improving the Service. We will not use or share your information with anyone except as described in this Privacy Policy  The terms used in this Privacy Policy have the same meanings as in our Terms and Conditions, which are accessible at Consolutios unless otherwise defined in this Privacy PolicyInformation Collection and UseFor a better experience, while using our Service, we may require you to provide us with certain personally identifiable information, including but not limited to con. The information that we request will be retained by us and used as described in this privacy policy The app does use third-party services that may collect information used to identify you Link to the privacy policy of third-party service providers used by the app Google Play Services Log Data We want to inform you that whenever you use our Service, in a case of an error in the app we collect data and information (through third-party products) on your phone called Log Data. This Log Data may include information such as your device Internet Protocol (“IP”) address, device name, operating system version, the configuration of the app when utilizing our Service, the time and date of your use of the Service, and other statistics Cookies Cookies are files with a small amount of data that are commonly used as anonymous unique identifiers. These are sent to your browser from the websites that you visit and are stored on your device's internal memory This Service does not use these cookies explicitly. However, the app may use third-party code and libraries that use “cookies” to collect information and improve their services. You have the option to either accept or refuse these cookies and know when a cookie is being sent to your device. If you choose to refuse our cookies, you may not be able to use some portions of this Service Service Providers We may employ third-party companies and individuals due to the following reasons To facilitate our Service To provide the Service on our behalf",
                        maxLines: 28,
                      ),
                      Expanded(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Checkbox(
                              activeColor: HexColor('#C18F3A'),
                              value: UserCubit.get(context).isChecked,
                              onChanged: (s) {
                                UserCubit.get(context).changeChecked(s!);
                                Navigator.pop(context);
                              },
                            ),
                            const Text('Accept'),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                width: 150,
                height: height,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            clipper: FullTicketClipper(
                15,
                height *
                    2), // Comment this out if you want to replace ClipPath with ClipOval
          ),
        );
      },
    );
  }
}

class FullTicketClipper extends CustomClipper<Path> {
  final double radius;
  final double top;
  FullTicketClipper(
    this.radius,
    this.top,
  );

  @override
  Path getClip(Size size) {
    Path path = Path();

    path.lineTo(0.0, top - radius);
    path.conicTo(
      radius,
      top - radius,
      radius,
      top,
      2.0,
    );
    path.conicTo(
      radius,
      top + radius,
      0,
      top + radius,
      1.0,
    );

    path.lineTo(0.0, size.height);
    path.lineTo(size.width, size.height);

    path.lineTo(size.width, top + radius);
    path.conicTo(
      size.width - radius,
      top + radius,
      size.width - radius,
      top,
      2.0,
    );
    path.conicTo(
      size.width - radius,
      top - radius,
      size.width,
      top - radius,
      1.0,
    );

    path.lineTo(size.width, 0);

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

/// Clip widget in wave shape shape
class WaveClipperOne extends CustomClipper<Path> {
  /// reverse the wave direction in vertical axis
  bool reverse;

  /// flip the wave direction horizontal axis
  bool flip;

  WaveClipperOne({this.reverse = false, this.flip = false});

  @override
  Path getClip(Size size) {
    if (!reverse && !flip) {
      Offset firstEndPoint = Offset(size.width * .5, size.height - 20);
      Offset firstControlPoint = Offset(size.width * .25, size.height - 30);
      Offset secondEndPoint = Offset(size.width, size.height - 50);
      Offset secondControlPoint = Offset(size.width * .75, size.height - 10);

      final path = Path()
        ..lineTo(0.0, size.height)
        ..quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
            firstEndPoint.dx, firstEndPoint.dy)
        ..quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
            secondEndPoint.dx, secondEndPoint.dy)
        ..lineTo(size.width, 0.0)
        ..close();
      return path;
    } else if (!reverse && flip) {
      Offset firstEndPoint = Offset(size.width * .5, size.height - 20);
      Offset firstControlPoint = Offset(size.width * .25, size.height - 10);
      Offset secondEndPoint = Offset(size.width, size.height);
      Offset secondControlPoint = Offset(size.width * .75, size.height - 30);

      final path = Path()
        ..lineTo(0.0, size.height - 30)
        ..quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
            firstEndPoint.dx, firstEndPoint.dy)
        ..quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
            secondEndPoint.dx, secondEndPoint.dy)
        ..lineTo(size.width, 0.0)
        ..close();
      return path;
    } else if (reverse && flip) {
      Offset firstEndPoint = Offset(size.width * .5, 20);
      Offset firstControlPoint = Offset(size.width * .25, 10);
      Offset secondEndPoint = Offset(size.width, 0);
      Offset secondControlPoint = Offset(size.width * .75, 30);

      final path = Path()
        ..lineTo(0, 30)
        ..quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
            firstEndPoint.dx, firstEndPoint.dy)
        ..quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
            secondEndPoint.dx, secondEndPoint.dy)
        ..lineTo(size.width, size.height)
        ..lineTo(0.0, size.height)
        ..close();
      return path;
    } else {
      Offset firstEndPoint = Offset(size.width * .5, 20);
      Offset firstControlPoint = Offset(size.width * .25, 30);
      Offset secondEndPoint = Offset(size.width, 50);
      Offset secondControlPoint = Offset(size.width * .75, 10);

      final path = Path()
        ..quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
            firstEndPoint.dx, firstEndPoint.dy)
        ..quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
            secondEndPoint.dx, secondEndPoint.dy)
        ..lineTo(size.width, size.height)
        ..lineTo(0.0, size.height)
        ..close();
      return path;
    }
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}

class PointsClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height);
    double x = 0;
    double y = size.height;
    double increment = size.width / 20;

    while (x < size.width) {
      x += increment;
      y = (y == size.height) ? size.height * .88 : size.height;
      path.lineTo(x, y);
    }
    path.lineTo(size.width, 0.0);

    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper old) {
    return old != this;
  }
}

// [MovieTicketBothSidesClipper], can be used with [ClipPath] widget, and clips the widget like a movie ticket
class MovieTicketBothSidesClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0.0, size.height);
    double x = 0;
    double y = size.height;
    double yControlPoint = size.height * .85;
    double increment = size.width / 12;

    while (x < size.width) {
      path.quadraticBezierTo(
          x + increment / 2, yControlPoint, x + increment, y);
      x += increment;
    }

    path.lineTo(size.width, 0.0);

    while (x > 0) {
      path.quadraticBezierTo(
          x - increment / 2, size.height * .15, x - increment, 0);
      x -= increment;
    }
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper old) {
    return old != this;
  }
}

class RoundedDiagonalPathClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path()
      ..lineTo(0.0, size.height)
      ..lineTo(size.width, size.height)
      ..lineTo(size.width, 0.0)
      ..quadraticBezierTo(size.width, 0.0, size.width - 20.0, 0.0)
      ..lineTo(40.0, 70.0)
      ..quadraticBezierTo(10.0, 85.0, 0.0, 120.0)
      ..close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}

// Clip widget in wave shape
class WaveClipperTwo extends CustomClipper<Path> {
  /// reverse the wave direction in vertical axis
  bool reverse;

  /// flip the wave direction horizontal axis
  bool flip;

  WaveClipperTwo({this.reverse = false, this.flip = false});

  @override
  Path getClip(Size size) {
    var path = Path();
    if (!reverse && !flip) {
      path.lineTo(0.0, size.height - 20);

      var firstControlPoint = Offset(size.width / 4, size.height);
      var firstEndPoint = Offset(size.width / 2.25, size.height - 30.0);
      path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
          firstEndPoint.dx, firstEndPoint.dy);

      var secondControlPoint =
          Offset(size.width - (size.width / 3.25), size.height - 65);
      var secondEndPoint = Offset(size.width, size.height - 40);
      path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
          secondEndPoint.dx, secondEndPoint.dy);

      path.lineTo(size.width, size.height - 40);
      path.lineTo(size.width, 0.0);
      path.close();
    } else if (!reverse && flip) {
      path.lineTo(0.0, size.height - 40);
      var firstControlPoint = Offset(size.width / 3.25, size.height - 65);
      var firstEndPoint = Offset(size.width / 1.75, size.height - 20);
      path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
          firstEndPoint.dx, firstEndPoint.dy);

      var secondCP = Offset(size.width / 1.25, size.height);
      var secondEP = Offset(size.width, size.height - 30);
      path.quadraticBezierTo(
          secondCP.dx, secondCP.dy, secondEP.dx, secondEP.dy);

      path.lineTo(size.width, size.height - 20);
      path.lineTo(size.width, 0.0);
      path.close();
    } else if (reverse && flip) {
      path.lineTo(0.0, 20);
      var firstControlPoint = Offset(size.width / 3.25, 65);
      var firstEndPoint = Offset(size.width / 1.75, 40);
      path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
          firstEndPoint.dx, firstEndPoint.dy);

      var secondCP = Offset(size.width / 1.25, 0);
      var secondEP = Offset(size.width, 30);
      path.quadraticBezierTo(
          secondCP.dx, secondCP.dy, secondEP.dx, secondEP.dy);

      path.lineTo(size.width, size.height);
      path.lineTo(0.0, size.height);
      path.close();
    } else {
      path.lineTo(0.0, 20);

      var firstControlPoint = Offset(size.width / 4, 0.0);
      var firstEndPoint = Offset(size.width / 2.25, 30.0);
      path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
          firstEndPoint.dx, firstEndPoint.dy);

      var secondControlPoint = Offset(size.width - (size.width / 3.25), 65);
      var secondEndPoint = Offset(size.width, 40);
      path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
          secondEndPoint.dx, secondEndPoint.dy);

      path.lineTo(size.width, size.height);
      path.lineTo(0.0, size.height);
      path.close();
    }

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
