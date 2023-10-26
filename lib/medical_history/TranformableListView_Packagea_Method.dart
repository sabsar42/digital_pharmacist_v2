
import 'package:flutter/cupertino.dart';
import 'package:transformable_list_view/transformable_list_view.dart';

Matrix4 getTransformMatrix(TransformableListItem item) {
  const endScaleBound = 0.7;
  final animationProgress = item.visibleExtent / item.size.height;
  final paintTransform = Matrix4.identity();

  if (item.position != TransformableListItemPosition.middle) {
    final scale = endScaleBound + ((1- endScaleBound) * animationProgress);

    paintTransform
      ..translate(item.size.width / 2)
      ..scale(scale)
      ..translate(-item.size.width / 2);
  }

  return paintTransform;
}