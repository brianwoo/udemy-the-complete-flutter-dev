# Flutter Widget Essentials
- https://www.youtube.com/playlist?list=PLybADvIp2cxiVOEHi9ooCHP2tAAihHQPX

## Center 
- Center will take height and width of its parent
- The child widget will sit in the vertically and horizontally center of the parent
- Attribute: heightFactor 
  - Take the height of the child's dimension * the heightFactor, then center the child in this new dimension
- Attribute: widthFactor
  - Take the width of the child's dimension * the widthFactor, then center the child in this new dimension

## Container
- NOTE: Container takes up all the parent's place when there is no child
- NOTE: Container only takes up minimium space of the child when there is a child
- Change Container's size with width and height properties
- Attribute: padding
  - e.g. EdgeInsets.all(8.0)
- Attribute: constraints
  - Controls the max and min dimension of the Container
  - e.g. BoxConstraints.expand() - expands and take up all the space of this Container's parent
  - e.g. BoxConstraints(minWidth: 100, maxWidth: 150)
- Attribute: alignment
  - e.g. Alignment.center - (horizontally & vertically)
    - when using with BoxConstraints.expand(), this will bring the child widget back in the center
  - e.g. Alignment.leftcenter
- Attribute: width, height
  - when BoxConstraints.expand() is used, width and height will have no effect
- Attribute: transform
  - e.g. Matrix4.rotationZ(0.5) - turn the Container 30 deg
- Attribute: decoration
  - e.g. BoxDecoration(
    - color: Colors.blue,
    - border: Border.all(
      color: Colors.black, 
      width: 2.0, 
      style: BorderStyle.solid
    ),
    - borderRadius: BorderRadius.all(Radus.circular(20.0)),
    - boxShadow: [
      BoxShadow(color: Colors.grey, blueRadius: 4.0, spreadRadius: 2.0)]
    - gradient: LinearGradient(colors: [Colors.blue, Colors.lightBlue], begin: Alignment.centerLeft, end: Alignment.centerRight)
    - shape: BoxShape.circle  
  )
  
## Row & Column
- Row
  - Attribute: mainAxisSize can change the default width behaviour (within the parent, e.g. Container)
    - e.g. MainAxisSize.min & MainAxisSize.max (default)
  - Attribute: mainAxisAlignment, default set to start
    - e.g. MainAxisAlignment.center, spaceBetween, spaceAround
  - Attribute: CrossAxisAlignment, default is start
  - Attribute: verticalDirection
    - VerticalDirection.up, start now means from the bottom, because direction starts from bottom to go up
  - Attribute: textDirection
    - change horizontal direction.
    - e.g. TextDirection.rtl (elements changes order, rtl: right to left)
- Column
  - The same attributes used in Row can be applied to Column

## Wrap
- Usually used when there isn't enough space horizontally
- Wrap will force the overflown Widget the next line
- Wrap is like a Row / Column, but wrap when it does not have enough space
- Wrap takes a children like Row / Column
- Wrap can have custom direction
  - Attribute: direction: Axis.vertical, Axis.horizontal
  - Attribute: alignment: WrapAlignment.center, end, etc.
    - parent of Wrap needs to be bigger to show center
  - Attribute: runAlignment
    - WrapAlignment.start, spacearound, etc.
    - alignment applied to crossAxis.
  - Attribute: verticalDirection
    - default is top to bottom
  - Attribute: spacing
    - e.g. 20.0
    - spacing adds a 20.0 spacing to left and right of each element
  - Attribute: runSpacing
    - vertical spacing to each element
  - Attribute: textDirection
    - change horizontal direction.
    - e.g. TextDirection.rtl (elements changes order, rtl: right to left)

## Stack
  - Make Widgets sit on top of each other
  - Stack has children property
  - Stack children order matters! child n will be on top of child n - 1
  - NOTE: Stack's size is determined by its children (if no bigger size parent)
  - NOTE: Stack's size is determined by its parent (if there is a bigger size parent)
  - Attribute: alignment
    - e.g. Alignment.topRight - children sitting top right corner
    - default is topLeft
  - Attribute: fit
    - StackFit.expand, loose
      - NOTE: expand - forces any non-Position Widget to expand to the stack's width and height
  - Attribute: overflow
    - a Position is set e.g. bottom: -20, it's overflown and clipped off the bottom of the screen
    - Overflow.visible can bring the clipped part visible, even it's outside the bound of the Stack
    - overflow default is set to Overflow.clip

## Position (usually use with Stack)
  - Position Widget sets the position within the parent Widget
  - Attribute: bottom, right, top, left
    - set position space according to these attributes
  - Attribute: width and height
    - set width and height of the Position Widght
    - NOTE: the child's width and height will be ignored and width and height are according to the Position's width and height

## Padding
  - Attribute: padding
    - EdgeInset.all(), symmetric(), only(), etc

## MediaQuery
  - MediaQuery.of(context).xxxxx
    - size
      - width and height
      - shortestSide, longestSide
      - we can use these in SizedBox or Container
    - orientation (used for responsive design or use LayoutBuilder)
      - check if Landscape: 
        - orientation.index == Orientation.landscape.index
      
## SafeArea
  - Make sure Widgets don't get into menu bar or bottom navigation


## Text
  - Attribute: style
    - TextStyle
      - fontSize
      - color
      - fontWeight
      - backgroundcolor
      - decoration
        - TextDecoration.underLine
        - TextDecoration.combine([TextDecoration.underLine, TextDecoration.overline])
      - decorationThickness: 2.0 - change the underline and overline's thickness
      - decorationColor: Colors.red - change these lines to red
      - decorationStyle: TextDecorationStyle.wavy
      - letterSpacing: 2.0 - letter spacing
      - wordSpacing: 20.0 - word spacing
      - shadows: [Shadow(color: Colors.black, blurRadius: 2.0, offset: Offset(4,1))]
      - fontFamily: "Raleway" - corresponds to pubspecs.yaml
        - foreground: Paint() ..color=Colors.red ..strokeWidth=2.0 ..style=PaintingStyle.stroke
  - Attribute: textAlign: TextAlign.justify, 
  - Attribute: maxLines: 2, 
  - Attribute: overflow: TextOverflow.ellipsis
  - Attribute: textScaleFactor: 2

## RichText
  - RichText handles different styling of each word within a Text Widget
  - Or add an Icon within a Text Widget
  - Attribute: text
    - TextSpan
      - text: "xxxxxxxx" - default is white, so may not show
      - style: TextStyle(color: Colors.black)
      - children: [
        - TextSpan(text: "Register", 
          - style: TextStyle(...), 
          - recognizer: 
            - TapGestureRecognizer()..onTap = () {})
        - WidgetSpan(
          - child: Icon(Icons.share), 
          - alignment: PlaceholderAlignment.middle)        
      ]

## Align
  - Align is used to align a child widget to its parent
  - e.g. Container - Align - Text
  - Attribute: alignment: Alignment.center, top, etc...
  - or with alignment: FractionalOffset(0.5, 0.5)
    - NOTE:
      - Alignment() - (0,0) - starts at middle of Container
      - FractionalOffset - (0,0) - starts at top right corner

## Expanded
  - Expanded expands a child to use up remaining space of its parent
  - Expanded calculates remaining space then assign the remaining space to the child
  - If Expanded is placed in a infinite size view (e.g. SingleChildScrollView), Expanded WILL fail.
  - Attribute: flex
    - if the remaining space has 2 Expanded widgets
      - flex: 2 means 2x of the remaining space
      - flex: 1 means 1x