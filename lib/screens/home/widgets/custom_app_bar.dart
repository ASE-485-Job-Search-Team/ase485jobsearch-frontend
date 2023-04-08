import 'package:flutter/material.dart';
import 'package:jobsearchmobile/services/auth_shared_service.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String title;
  final String logoAssetPath = "assets/images/logo.png";

  CustomAppBar({required this.title});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  _CustomAppBarState createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  bool _isLoggedIn = false;

  Future<void> _checkLoginStatus() async {
    bool isLoggedIn = await SharedService.isLoggedIn();
    setState(() => _isLoggedIn = isLoggedIn);
  }

  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      titleSpacing: 0.0,
      automaticallyImplyLeading: false, // Disable the automatic back button
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(6.0),
            child: Container(
              color: Colors.white,
              child: Image.asset(
                widget.logoAssetPath,
                fit: BoxFit.contain,
                height: 45,
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(6.0),
            child: Text(
              'JobHive',
              style: TextStyle(
                color: Color(0xFF2c3a6d),
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
      actions: _isLoggedIn
          ? [
        IconButton(
          icon: Icon(Icons.exit_to_app),
          color: Colors.black,
          onPressed: () => {
            SharedService.logout(context)
          },
        ),
      ]
          : [],
    );
  }
}
