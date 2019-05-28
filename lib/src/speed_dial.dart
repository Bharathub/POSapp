import 'dart:async';

import 'package:flutter/material.dart';

import 'animated_floating_button.dart';
import 'background_overlay.dart';
import 'animated_child.dart';
import 'speed_dial_child.dart';

/// Builds the Speed Dial
class SpeedDial extends StatefulWidget {
  /// Children buttons, from the lowest to the highest.
  final List<SpeedDialChild> children;

  /// Used to get the button hidden on scroll. See examples for more info.
  final bool visible;

  /// The curve used to animate the button on scrolling.
  final Curve curve;

  final String tooltip;
  final String heroTag;
  final Color backgroundColor;
  final Color foregroundColor;
  final double elevation;
  final ShapeBorder shape;

  /// The color of the background overlay.
  final Color overlayColor;

  /// The opacity of the background overlay when the dial is open.
  final double overlayOpacity;

  /// The animated icon to show as the main button child. If this is provided the [child] is ignored.
  final AnimatedIconData animatedIcon;

  /// The theme for the animated icon.
  final IconThemeData animatedIconTheme;

  /// The child of the main button, ignored if [animatedIcon] is non [null].
  final Widget child;

  /// Executed when the dial is opened.
  final VoidCallback onOpen;

  /// Executed when the dial is closed.
  final VoidCallback onClose;

  SpeedDial({
    this.children = const [],
    this.visible = true,
    this.backgroundColor,
    this.foregroundColor,
    this.elevation = 6.0,
    this.overlayOpacity = 0.8,
    this.overlayColor = Colors.white,
    this.tooltip,
    this.heroTag,
    this.animatedIcon,
    this.animatedIconTheme,
    this.child,
    this.onOpen,
    this.onClose,
    this.shape = const CircleBorder(),
    this.curve = Curves.linear,
  });

  @override
  _SpeedDialState createState() => _SpeedDialState();
}

class _SpeedDialState extends State<SpeedDial> with TickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _animation;

  List<AnimationController> _childrenControllers = [];
  List<Animation<double>> _childrenAnimations = [];

  bool _open = false;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: Duration(milliseconds: 200),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);

    List.generate(widget.children.length, (_) {
      var controller = AnimationController(
        duration: Duration(milliseconds: 200),
        vsync: this,
      );
      var animation = Tween(begin: 0.0, end: 62.0).animate(controller);
      _childrenControllers.add(controller);
      _childrenAnimations.add(animation);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _childrenControllers
        .forEach((childController) => childController.dispose());
    super.dispose();
  }

  void _performAnimation() {
    if (_open) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
    _childrenControllers.forEach((childController) {
      var index = _childrenControllers.indexOf(childController);
      if (_open) {
        Timer(
          Duration(milliseconds: index * 40),
          () => childController.forward(),
        );
      } else {
        Timer(
          Duration(
              milliseconds: (index - (widget.children.length - 1)).abs() * 30),
          () => childController.reverse(),
        );
      }
    });
  }

  void _toggleChildren() {
    var newValue = !_open;
    // setState(() {
    //   _open = newValue;
    // });
    if (newValue && widget.onOpen != null) widget.onOpen();
    _performAnimation();
    if (!newValue && widget.onClose != null) widget.onClose();
  }

  List<Widget> _getChildrenList() {
    return widget.children
        .map((SpeedDialChild child) {
          int index = widget.children.indexOf(child);


          if(!_childrenAnimations.contains(index))
            {
              //dynamically added child
              var controller = AnimationController(
                duration: Duration(milliseconds: 200),
                vsync: this,
              );
              var animation = Tween(begin: 0.0, end: 62.0).animate(controller);
              _childrenControllers.add(controller);
              _childrenAnimations.add(animation);

            }

          return AnimatedChild(
            animation: _childrenAnimations[index],
            index: index,
            visible: _open,
            backgroundColor: child.backgroundColor,
            foregroundColor: child.foregroundColor,
            elevation: child.elevation,
            child: child.child,
            label: child.label,
            labelStyle: child.labelStyle,
            labelBackgroundColor: child.labelBackgroundColor,
            onTap: child.onTap,
            toggleChildren: _toggleChildren,
            shape: child.shape,
            heroTag: 'speed-dial-child-$index',
          );
        })
        .toList()
        .reversed
        .toList();
  }

  Widget _renderOverlay() {
    return Positioned(
      right: -16.0,
      bottom: -16.0,
      top: _open ? 0.0 : null,
      left: _open ? 0.0 : null,
      child: GestureDetector(
        onTap: _toggleChildren,
        child: BackgroundOverlay(
          animation: _animation,
          color: widget.overlayColor,
          opacity: widget.overlayOpacity,
        ),
      ),
    );
  }

  Widget _renderButton() {
    var child = widget.animatedIcon != null
        ? AnimatedIcon(
            icon: widget.animatedIcon,
            progress: _animation,
            color: widget.animatedIconTheme?.color,
            size: widget.animatedIconTheme?.size,
          )
        : widget.child;

    var fabChildren = _getChildrenList();
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: List.from(fabChildren)
          ..add(
            Container(
              margin: EdgeInsets.only(top: 8.0, right: 2.0),
              child: AnimatedFloatingButton(
                visible: widget.visible,
                tooltip: widget.tooltip,
                backgroundColor: widget.backgroundColor,
                foregroundColor: widget.foregroundColor,
                elevation: widget.elevation,
                callback: _toggleChildren,
                child: child,
                heroTag: widget.heroTag,
                shape: widget.shape,
                curve: widget.curve,
              ),
            ),
          ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomRight,
      fit: StackFit.expand,
      overflow: Overflow.visible,
      children: [
        _renderOverlay(),
        _renderButton(),
      ],
    );
  }
}
