import 'package:draggable_widget/draggable_widget.dart';
import 'package:movie_playlist/common_import/ui_common_import.dart';

class Fluto extends StatefulWidget {
  const Fluto({
    Key? key,
    required this.child,
    required this.navigatorKey,
  }) : super(key: key);
  final Widget child;

  final GlobalKey<NavigatorState> navigatorKey;

  @override
  State<Fluto> createState() => _FlutoState();
}

class _FlutoState extends State<Fluto> {
  @override
  void initState() {
    super.initState();

    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   showOverlay();
    //   Timer.periodic(
    //     const Duration(seconds: 2),
    //     (timer) {
    //       try {
    //         showOverlay();
    //       } catch (e) {
    //         print(e);
    //       }
    //     },
    //   );
    // });
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }

  OverlayEntry? _entry;
  Offset _offset = const Offset(20, 40);

  void showOverlay() {
    print("showOverlay");
    final currentContext = widget.navigatorKey.currentContext;

    _entry = OverlayEntry(
      opaque: true,
      builder: (context) {
        return Positioned(
          left: _offset.dx,
          top: _offset.dy,
          child: GestureDetector(
            onPanUpdate: ((details) {
              _offset += details.delta;
              _entry?.markNeedsBuild();
            }),
            child: ElevatedButton(
              child: const Text('Show Overlay'),
              onPressed: () {},
            ),
          ),
        );
      },
    );

    Overlay.of(currentContext!)?.insert(_entry!);
  }
}

class TopWidget extends StatelessWidget {
  const TopWidget({super.key, required this.child});

  final Widget child;
  @override
  Widget build(BuildContext context) {
    /// A drag controller to show/hide or move the widget around the screen
    final DragController dragController = DragController();

    return Scaffold(
      floatingActionButton: FloatingActionButton.small(onPressed: () => {}),
      body: Stack(
        children: [
          child,
          DraggableWidget(
            bottomMargin: 80,
            topMargin: 80,
            intialVisibility: true,
            horizontalSpace: 20,
            shadowBorderRadius: 50,
            initialPosition: AnchoringPosition.bottomRight,
            dragController: dragController,
            child: ElevatedButton(
                child: const Text("Launch Fluto"), onPressed: () {}),
          ),
        ],
      ),
      // bottomNavigationBar: BottomNavigationBar(
      //   items: const [
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.read_more),
      //       label: "Read More",
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.read_more),
      //       label: "Read More",
      //     )
      //   ],
      // ),
    );
  }
}
