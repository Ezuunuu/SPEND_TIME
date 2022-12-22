import 'package:flutter/material.dart';

class CustomShimmerList extends StatefulWidget {
  const CustomShimmerList(
      {
        Key? key,
        this.mode = ShimmerMode.text,
        required this.width,
        required this.height,
        required this.borderRadius,
        this.count = 5,
        this.image,
        required this.paddingSize,
      }) : super(key: key);

  final ShimmerMode mode;

  final double width;
  final double height;

  final BorderRadiusGeometry borderRadius;

  final int count;

  final Widget? image;

  final double paddingSize;

  @override
  State<CustomShimmerList> createState() => _CustomShimmerListState();
}

class _CustomShimmerListState extends State<CustomShimmerList> with SingleTickerProviderStateMixin {
  late AnimationController _shimmerController;

  @override
  void initState() {
    _shimmerController = AnimationController.unbounded(vsync: this)..repeat(min: -0.5, max: 1.5, period: const Duration(milliseconds: 1500));
    _shimmerController.addListener(() { setState(() { }); });
    super.initState();
  }

  @override
  void dispose() {
    _shimmerController.dispose();
    super.dispose();
  }

  LinearGradient get gradient => LinearGradient(
    colors: _shimmerGradient.colors,
    stops: _shimmerGradient.stops,
    begin: _shimmerGradient.begin,
    end: _shimmerGradient.end,
    transform: _SlidingGradientTransform(slidePercent: _shimmerController.value),
  );

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      blendMode: BlendMode.srcATop,
      shaderCallback: (bounds) {
        return gradient.createShader(
          Rect.fromLTWH(
            -0.0,
            -1.0,
            widget.width,
            widget.height,
          )
        );
      },
      child: widget.mode == ShimmerMode.text ? _buildText() : _buildImage()
    );
  }

  Widget _buildImage() {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: Container(
        width: widget.width,
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: widget.borderRadius,
        ),
        child: ClipRRect(
            borderRadius: widget.borderRadius,
            child: widget.image
        ),
      ),
    );
  }

  Widget _buildText() {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: widget.count,
      itemBuilder: (context, index) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: widget.width,
              height: widget.height,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: widget.borderRadius,
              ),
            ),
            SizedBox(height: widget.paddingSize),
          ],
        );
      },
    );
  }
}

enum ShimmerMode {
  image,
  text
}

const _shimmerGradient = LinearGradient(
  colors: [
    Color(0xFFEBEBF4),
    Color(0xFFF4F4F4),
    Color(0xFFEBEBF4),
  ],
  stops: [
    0.1,
    0.3,
    0.4,
  ],
  begin: Alignment(-1.0, -0.3),
  end: Alignment(1.0, 0.3),
  tileMode: TileMode.clamp,
);

class _SlidingGradientTransform extends GradientTransform {
  const _SlidingGradientTransform({
    required this.slidePercent,
  });

  final double slidePercent;

  @override
  Matrix4? transform(Rect bounds, {TextDirection? textDirection}) {
    return Matrix4.translationValues(bounds.width * slidePercent, 0.0, 0.0);
  }
}