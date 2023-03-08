import 'package:flutter/material.dart';

class HomeSearchBar extends StatefulWidget {
  const HomeSearchBar({Key? key}) : super(key: key);

  @override
  State<HomeSearchBar> createState() => _HomeSearchBarState();
}

class _HomeSearchBarState extends State<HomeSearchBar> {
  TextEditingController _searchController = TextEditingController();
  String _searchText = '';
  bool _isSearchActive = false;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(0.0, 12.0, 0.0, 0.0),
      child: Stack(
        children: [
          Container(
            height: 46.0,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey[200]!),
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _searchController,
                  style: TextStyle(fontSize: 14.0),
                  decoration: const InputDecoration(
                    hintText: 'Explore job opportunities',
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(horizontal: 16),
                  ),
                  onChanged: (value) {
                    setState(() {
                      _isSearchActive = value.isNotEmpty;
                    });
                  },
                ),
              ),
              AnimatedSwitcher(
                duration: Duration(milliseconds: 100),
                child: _isSearchActive
                    ? IconButton(
                        key: ValueKey(1),
                        icon: Icon(Icons.close),
                        onPressed: () {
                          _searchController.clear();
                          setState(() {
                            _isSearchActive = false;
                          });
                        },
                      )
                    : IconButton(
                        key: ValueKey(2),
                        icon: Icon(Icons.search),
                        onPressed: () {
                          setState(() {
                            _isSearchActive = true;
                          });
                        },
                      ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
