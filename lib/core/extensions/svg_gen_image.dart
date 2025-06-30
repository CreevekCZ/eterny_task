import 'package:eterny_task/gen/assets.gen.dart';
import 'package:flutter/material.dart';

extension SvgGenImageX on SvgGenImage {
  Widget whiteSvg({
    double? height,
    double? width,
  }) => coloredSvg(
    height: height,
    width: width,
    color: Colors.white,
  );

  Widget coloredSvg({required Color color, double? height, double? width}) => svg(
    height: height,
    width: width,
    colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
  );
}
