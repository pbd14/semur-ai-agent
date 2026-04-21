import 'package:flutter/material.dart';

// Define screen breakpoints based on Material Design 3 guidelines
enum ScreenSize {
  compact, // 0-599dp (phones)
  medium, // 600-839dp (tablets, folded foldables)
  expanded, // 840-1199dp (tablets, unfolded foldables)
  large, // 1200-1599dp (laptops, desktops)
  extraLarge, // 1600+dp (desktops, TVs)
}

// Configuration for how items should be laid out on different screen sizes
class AdaptiveLayoutConfig {
  final int compactColumns;
  final int mediumColumns;
  final int expandedColumns;
  final int largeColumns;
  final int extraLargeColumns;

  final double spacing;
  final double runSpacing;
  final EdgeInsets screenPadding;
  final EdgeInsets padding;
  final double? maxContentWidth;

  final WrapAlignment wrapAlignment;
  final WrapAlignment runWrapAlignment;

  const AdaptiveLayoutConfig({
    this.compactColumns = 1,
    this.mediumColumns = 2,
    this.expandedColumns = 3,
    this.largeColumns = 4,
    this.extraLargeColumns = 5,
    this.spacing = 16.0,
    this.runSpacing = 16.0,
    this.screenPadding = const EdgeInsets.fromLTRB(0, 16, 0, 16),
    this.padding = const EdgeInsets.fromLTRB(16, 0, 16, 0),
    this.maxContentWidth,
    this.wrapAlignment = WrapAlignment.start,
    this.runWrapAlignment = WrapAlignment.start,
  });

  // factory for one column for every screen size
  factory AdaptiveLayoutConfig.allOneColumn() {
    return const AdaptiveLayoutConfig(
      compactColumns: 1,
      mediumColumns: 1,
      expandedColumns: 1,
      largeColumns: 1,
      extraLargeColumns: 1,
    );
  }

  // copyWith
  AdaptiveLayoutConfig copyWith({
    int? compactColumns,
    int? mediumColumns,
    int? expandedColumns,
    int? largeColumns,
    int? extraLargeColumns,
    double? spacing,
    double? runSpacing,
    EdgeInsets? padding,
    double? maxContentWidth,
    WrapAlignment? wrapAlignment,
    WrapAlignment? runWrapAlignment,
  }) {
    return AdaptiveLayoutConfig(
      compactColumns: compactColumns ?? this.compactColumns,
      mediumColumns: mediumColumns ?? this.mediumColumns,
      expandedColumns: expandedColumns ?? this.expandedColumns,
      largeColumns: largeColumns ?? this.largeColumns,
      extraLargeColumns: extraLargeColumns ?? this.extraLargeColumns,
      spacing: spacing ?? this.spacing,
      runSpacing: runSpacing ?? this.runSpacing,
      padding: padding ?? this.padding,
      maxContentWidth: maxContentWidth ?? this.maxContentWidth,
      wrapAlignment: wrapAlignment ?? this.wrapAlignment,
      runWrapAlignment: runWrapAlignment ?? this.runWrapAlignment,
    );
  }
}

// The main adaptive layout manager class
class AdaptiveLayoutManager extends StatelessWidget {
  final List<Widget> children;
  final AdaptiveLayoutConfig config;
  final bool centerContent;
  final bool centerVertically;
  final ScrollController? scrollController;

  const AdaptiveLayoutManager({
    super.key,
    required this.children,
    this.config = const AdaptiveLayoutConfig(),
    this.centerContent = true,
    this.centerVertically = true,
    this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final screenSize = _getScreenSize(constraints.maxWidth);
        final columns = _getColumnsForScreenSize(screenSize);

        double maxContentWidth =
            config.maxContentWidth ?? _getMaxContentWidth(screenSize);
        // Calculate if we should constrain the width
        final shouldConstrain = constraints.maxWidth > maxContentWidth;

        Widget content = _buildContent(columns, centerVertically, constraints);

        if (shouldConstrain && centerContent) {
          content = Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: maxContentWidth),
              child: content,
            ),
          );
        }

        return SafeArea(
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: content,
          ),
        );
      },
    );
  }

  Widget _buildContent(
    int columns,
    bool centerVertically,
    BoxConstraints constraints,
  ) {
    if (children.isEmpty) return const SizedBox.shrink();

    // For single column, use ListView for better scrolling performance
    if (columns == 1) {
      // Check if content height is less than available height
      List<Widget> elements = [];
      for (Widget child in children) {
        if (child is SpecifiedNumberOfColumnsWrapper) {
          for (Widget grandChild in child.children) {
            if (grandChild is NoPaddingWidgetWrapper) {
              elements.add(grandChild);
            } else {
              elements.add(Padding(padding: config.padding, child: grandChild));
            }
          }
        } else if (child is NoPaddingWidgetWrapper) {
          elements.add(child);
        } else {
          elements.add(Padding(padding: config.padding, child: child));
        }
      }

      elements.add(const SizedBox(height: 500));

      return LayoutBuilder(
        builder: (context, constraints) {
          return centerVertically
              ? Center(
                child: ListView.separated(
                  controller: scrollController,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: config.screenPadding,
                  itemCount: elements.length,
                  separatorBuilder:
                      (context, index) => SizedBox(height: config.runSpacing),
                  itemBuilder: (context, index) => elements[index],
                ),
              )
              : ListView.separated(
                controller: scrollController,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: config.screenPadding,
                itemCount: elements.length,
                separatorBuilder:
                    (context, index) => SizedBox(height: config.runSpacing),
                itemBuilder: (context, index) => elements[index],
              );
        },
      );
    }

    List<Widget> elements = [];
    List<Widget> elementsQueue = [];
    for (Widget child in children) {
      if (child is SpecifiedNumberOfColumnsWrapper) {
        // Free the queue
        if (elementsQueue.isNotEmpty) {
          elements.add(
            Wrap(
              alignment: config.wrapAlignment,
              crossAxisAlignment:
                  centerVertically
                      ? WrapCrossAlignment.center
                      : WrapCrossAlignment.start,
              runAlignment: config.runWrapAlignment,
              spacing: config.spacing,
              runSpacing: config.runSpacing,
              children: elementsQueue.toList(),
            ),
          );
          elementsQueue.clear();
          // Add spacing
          elements.add(SizedBox(height: config.runSpacing));
        }

        // Add a flexible grid for the specified number of columns
        elements.add(
          _buildFlexibleGrid(
            child.children,
            child.columns,
            constraints.maxWidth,
          ),
        );

        // Add spacing
        elements.add(SizedBox(height: config.runSpacing));
      } else {
        elementsQueue.add(child);
      }
    }

    // Free the queue
    if (elementsQueue.isNotEmpty) {
      elements.add(
        Wrap(
          alignment: config.wrapAlignment,
          crossAxisAlignment:
              centerVertically
                  ? WrapCrossAlignment.center
                  : WrapCrossAlignment.start,
          runAlignment: config.runWrapAlignment,
          spacing: config.spacing,
          runSpacing: config.runSpacing,
          children: elementsQueue.toList(),
        ),
      );
      elementsQueue.clear();
    }

    elements.add(const SizedBox(height: 500));
    
    return Padding(
      padding: config.screenPadding,
      child: Column(
        mainAxisAlignment:
            centerVertically
                ? MainAxisAlignment.center
                : MainAxisAlignment.start,
        children: elements,
      ),
    );
  }

  Widget _buildFlexibleGrid(
    List<Widget> children,
    int columns,
    double maxWidth,
  ) {
    // Build a flexible grid that respects children's natural heights
    List<Widget> rows = [];

    for (int i = 0; i < children.length; i += columns) {
      List<Widget> rowChildren = [];

      for (int j = 0; j < columns && (i + j) < children.length; j++) {
        Widget child = children[i + j];
        Widget processedChild;

        if (child is NoPaddingWidgetWrapper) {
          processedChild = child;
        } else {
          processedChild = Padding(padding: config.padding, child: child);
        }

        rowChildren.add(Expanded(child: processedChild));
      }

      // Fill remaining spaces in incomplete rows
      while (rowChildren.length < columns) {
        rowChildren.add(const Expanded(child: SizedBox.shrink()));
      }

      rows.add(
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children:
              rowChildren
                  .expand(
                    (widget) => [
                      widget,
                      if (widget != rowChildren.last)
                        SizedBox(width: config.spacing),
                    ],
                  )
                  .where(
                    (widget) =>
                        !(widget is SizedBox && widget != rowChildren.last),
                  )
                  .toList(),
        ),
      );
    }

    return Column(
      crossAxisAlignment:
          centerVertically
              ? CrossAxisAlignment.center
              : CrossAxisAlignment.start,
      children:
          rows
              .expand(
                (row) => [
                  row,
                  if (row != rows.last) SizedBox(height: config.runSpacing),
                ],
              )
              .where((widget) => !(widget is SizedBox && widget != rows.last))
              .toList(),
    );
  }

  ScreenSize _getScreenSize(double width) {
    if (width < 600) return ScreenSize.compact;
    if (width < 840) return ScreenSize.medium;
    if (width < 1200) return ScreenSize.expanded;
    if (width < 1600) return ScreenSize.large;
    return ScreenSize.extraLarge;
  }

  double _getMaxContentWidth(ScreenSize screenSize) {
    switch (screenSize) {
      case ScreenSize.compact:
        return 600;
      case ScreenSize.medium:
        return 800;
      case ScreenSize.expanded:
        return 1000;
      case ScreenSize.large:
        return 1200;
      case ScreenSize.extraLarge:
        return 1400;
    }
  }

  int _getColumnsForScreenSize(ScreenSize screenSize) {
    switch (screenSize) {
      case ScreenSize.compact:
        return config.compactColumns;
      case ScreenSize.medium:
        return config.mediumColumns;
      case ScreenSize.expanded:
        return config.expandedColumns;
      case ScreenSize.large:
        return config.largeColumns;
      case ScreenSize.extraLarge:
        return config.extraLargeColumns;
    }
  }
}

// Helper widget for responsive values
class ResponsiveValue<T> extends StatelessWidget {
  final T compact;
  final T? medium;
  final T? expanded;
  final T? large;
  final T? extraLarge;
  final Widget Function(BuildContext context, T value) builder;

  const ResponsiveValue({
    super.key,
    required this.compact,
    this.medium,
    this.expanded,
    this.large,
    this.extraLarge,
    required this.builder,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final screenSize = _getScreenSize(constraints.maxWidth);
        final value = _getValueForScreenSize(screenSize);
        return builder(context, value);
      },
    );
  }

  ScreenSize _getScreenSize(double width) {
    if (width < 600) return ScreenSize.compact;
    if (width < 840) return ScreenSize.medium;
    if (width < 1200) return ScreenSize.expanded;
    if (width < 1600) return ScreenSize.large;
    return ScreenSize.extraLarge;
  }

  T _getValueForScreenSize(ScreenSize screenSize) {
    switch (screenSize) {
      case ScreenSize.compact:
        return compact;
      case ScreenSize.medium:
        return medium ?? compact;
      case ScreenSize.expanded:
        return expanded ?? medium ?? compact;
      case ScreenSize.large:
        return large ?? expanded ?? medium ?? compact;
      case ScreenSize.extraLarge:
        return extraLarge ?? large ?? expanded ?? medium ?? compact;
    }
  }
}

// Extension to easily get current screen size anywhere
extension AdaptiveContext on BuildContext {
  ScreenSize get screenSize {
    final width = MediaQuery.of(this).size.width;
    if (width < 600) return ScreenSize.compact;
    if (width < 840) return ScreenSize.medium;
    if (width < 1200) return ScreenSize.expanded;
    if (width < 1600) return ScreenSize.large;
    return ScreenSize.extraLarge;
  }

  bool get isCompact => screenSize == ScreenSize.compact;
  bool get isMedium => screenSize == ScreenSize.medium;
  bool get isExpanded => screenSize == ScreenSize.expanded;
  bool get isLarge => screenSize == ScreenSize.large;
  bool get isExtraLarge => screenSize == ScreenSize.extraLarge;
}

class SpecifiedNumberOfColumnsWrapper extends StatelessWidget {
  final int columns;
  final List<Widget> children;

  const SpecifiedNumberOfColumnsWrapper({
    super.key,
    required this.columns,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Column(children: children);
  }
}

class NoPaddingWidgetWrapper extends StatelessWidget {
  final Widget child;

  const NoPaddingWidgetWrapper({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return child;
  }
}

// // Example usage in a screen
// class ExampleScreen extends StatelessWidget {
//   const ExampleScreen({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     // Your screen's cards/elements
//     final elements = List.generate(
//       20,
//       (index) => Card(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             children: [
//               Icon(Icons.star, size: 48),
//               SizedBox(height: 8),
//               Text('Item ${index + 1}'),
//               SizedBox(height: 8),
//               Text('This is some content for the card'),
//             ],
//           ),
//         ),
//       ),
//     );

//     return Scaffold(
//       appBar: AppBar(title: const Text('Adaptive Layout Example')),
//       body: AdaptiveLayoutManager(
//         children: elements,
//         config: const AdaptiveLayoutConfig(
//           compactColumns: 1,
//           mediumColumns: 2,
//           expandedColumns: 3,
//           largeColumns: 4,
//           extraLargeColumns: 5,
//           spacing: 16.0,
//           runSpacing: 16.0,
//           maxContentWidth: 1400.0,
//         ),
//       ),
//     );
//   }
// }

// // For more complex adaptive layouts, you can create specialized versions
// class AdaptiveCardLayout extends StatelessWidget {
//   final List<Widget> cards;
//   final double cardHeight;
  
//   const AdaptiveCardLayout({
//     Key? key,
//     required this.cards,
//     this.cardHeight = 200.0,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return ResponsiveValue<AdaptiveLayoutConfig>(
//       compact: const AdaptiveLayoutConfig(
//         compactColumns: 1,
//         spacing: 12.0,
//         runSpacing: 12.0,
//         padding: EdgeInsets.all(12.0),
//       ),
//       medium: const AdaptiveLayoutConfig(
//         mediumColumns: 2,
//         spacing: 16.0,
//         runSpacing: 16.0,
//         padding: EdgeInsets.all(16.0),
//       ),
//       expanded: const AdaptiveLayoutConfig(
//         expandedColumns: 3,
//         spacing: 20.0,
//         runSpacing: 20.0,
//         padding: EdgeInsets.all(20.0),
//       ),
//       builder: (context, config) => AdaptiveLayoutManager(
//         children: cards,
//         config: config,
//       ),
//     );
//   }
// }