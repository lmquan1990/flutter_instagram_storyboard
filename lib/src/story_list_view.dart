import 'package:flutter/material.dart';
import 'package:flutter_instagram_storyboard/src/story_button.dart';
import 'package:flutter_instagram_storyboard/src/story_page_transform.dart';

import 'story_route.dart';

class StoryListView extends StatefulWidget {
  final List<StoryButtonData> buttonDatas;
  final double buttonSpacing;
  final double paddingLeft;
  final double paddingRight;
  final double paddingTop;
  final double paddingBottom;
  final ScrollPhysics? physics;
  final IStoryPageTransform? pageTransform;
  final bool safeAreaTop;
  final bool safeAreaBottom;
  final double listHeight;
  final double buttonWidth;

  const StoryListView({
    Key? key,
    required this.buttonDatas,
    this.buttonSpacing = 10.0,
    this.paddingLeft = 10.0,
    this.listHeight = 120.0,
    this.paddingRight = 10.0,
    this.paddingTop = 10.0,
    this.paddingBottom = 10.0,
    this.physics,
    this.pageTransform,
    this.buttonWidth = 100.0,
    this.safeAreaTop = true,
    this.safeAreaBottom = true,
  }) : super(key: key);

  @override
  State<StoryListView> createState() => _StoryListViewState();
}

class _StoryListViewState extends State<StoryListView> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
  }

  void _onButtonPressed(StoryButtonData buttonData) {
    Navigator.of(context).push(
      StoryRoute(
        storyContainerSettings: StoryContainerSettings(
          buttonData: buttonData,
          tapPosition: buttonData.buttonCenterPosition!,
          curve: buttonData.pageAnimationCurve,
          allButtonDatas: widget.buttonDatas,
          pageTransform: widget.pageTransform,
          storyListScrollController: _scrollController,
        ),
        duration: buttonData.pageAnimationDuration,
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final buttonDatas = widget.buttonDatas.where((b) {
      return b.isVisibleCallback();
    }).toList();
    if (buttonDatas.isEmpty) {
      return const SizedBox.shrink();
    }

    return SizedBox(
      height: widget.listHeight,
      child: Padding(
          padding: EdgeInsets.only(
            top: widget.paddingTop,
            bottom: widget.paddingBottom,
          ),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxHeight: 200),
              child: CarouselView(
                itemExtent: 330,
                shrinkExtent: 200,
                children:
                    List<Widget>.generate(buttonDatas.length, (int index) {
                  return ContainedLayoutCard(
                      buttonDatas: widget.buttonDatas,
                      index: index,
                      buttonSpacing: widget.buttonSpacing,
                      paddingLeft: widget.paddingLeft,
                      paddingRight: widget.paddingRight,
                      buttonWidth: widget.buttonWidth,
                      pageTransform: widget.pageTransform,
                      scrollController: _scrollController,
                      onButtonPressed: _onButtonPressed);
                }),
              ),
            ),
          )
          // ListView.builder(
          //       controller: _scrollController,
          //       physics: widget.physics,
          //       scrollDirection: Axis.horizontal,
          //       itemBuilder: (c, int index) {
          //         return ContainedLayoutCard(
          //             buttonDatas: widget.buttonDatas,
          //             index: index,
          //             buttonSpacing: widget.buttonSpacing,
          //             paddingLeft: widget.paddingLeft,
          //             paddingRight: widget.paddingRight,
          //             buttonWidth: widget.buttonWidth,
          //             pageTransform: widget.pageTransform,
          //             scrollController: _scrollController,
          //             onButtonPressed: _onButtonPressed);
          //       },
          //       itemCount: buttonDatas.length,
          //     ),
          ),
    );
  }
}

class ContainedLayoutCard extends StatelessWidget {
  const ContainedLayoutCard({
    super.key,
    required this.index,
    required this.buttonDatas,
    required this.paddingLeft,
    required this.paddingRight,
    required this.buttonSpacing,
    required this.buttonWidth,
    required this.pageTransform,
    required this.scrollController,
    required this.onButtonPressed,
  });

  final int index;
  final List<StoryButtonData> buttonDatas;
  final double paddingLeft;
  final double paddingRight;
  final double buttonSpacing;
  final double buttonWidth;
  final IStoryPageTransform? pageTransform;
  final ScrollController scrollController;
  final Function(StoryButtonData storyButtonData) onButtonPressed;

  @override
  Widget build(BuildContext context) {
    final isLast = index == buttonDatas.length - 1;
    final isFirst = index == 0;
    final buttonData = buttonDatas[index];
    return Padding(
      padding: EdgeInsets.only(
        left: isFirst ? paddingLeft : 0.0,
        right: isLast ? paddingRight : buttonSpacing,
      ),
      child: SizedBox(
        width: buttonWidth,
        child: StoryButton(
          buttonData: buttonData,
          allButtonDatas: buttonDatas,
          pageTransform: pageTransform,
          storyListViewController: scrollController,
          onPressed: onButtonPressed,
        ),
      ),
    );
  }
}
