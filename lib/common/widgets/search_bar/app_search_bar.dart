import 'package:drip_out/authentication/presentation/widgets/my_textfield.dart';
import 'package:drip_out/core/configs/assets/app_vectors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppSearchBar extends StatefulWidget {
  final TextEditingController? searchTextController;
  final void Function(String)? onChanged;
  const AppSearchBar({super.key, this.onChanged, this.searchTextController});

  @override
  _AppSearchBarState createState() => _AppSearchBarState();
}

class _AppSearchBarState extends State<AppSearchBar> {
  late final FocusNode _searchFocusNode;
  @override
  void initState() {
    _searchFocusNode = FocusNode();
    _searchFocusNode.addListener(() {
      setState(() {

      });
    });
    super.initState();
  }
  @override
  void dispose() {
    _searchFocusNode.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return MyTextField(
      controller: widget.searchTextController,
      focusNode: _searchFocusNode,
      onChanged: widget.onChanged,
      hintText: 'Search for clothes...',
      prefixIcon: Padding(
        padding: EdgeInsets.symmetric(vertical: 15.r),
        child: _searchFocusNode.hasFocus
            ? SvgPicture.asset(AppVectors.searchIcon)
            : SvgPicture.asset(AppVectors.searchIconInactive),
      ),
      suffixIcon: IconButton(
        onPressed: () {},
        icon: SvgPicture.asset(AppVectors.micIcon),
      ),
    );
  }
}
