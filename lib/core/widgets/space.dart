
import 'package:flutter/material.dart';


// El enum define la dirección del espacio.
enum SpaceDirection { vertical, horizontal }

class Space extends StatelessWidget {
  final double size;
  final SpaceDirection direction;

  const Space(this.size, this.direction, {Key? key}) : super(key: key);

  // Constructores de fábrica para facilitar su uso.
  const factory Space.vertical(double size) = _VerticalSpace;
  const factory Space.horizontal(double size) = _HorizontalSpace;

  @override
  Widget build(BuildContext context) {
    if (direction == SpaceDirection.vertical) {
      return SizedBox(height: size);
    } else {
      return SizedBox(width: size);
    }
  }
}

// Clases privadas para los constructores de fábrica
class _VerticalSpace extends Space {
  const _VerticalSpace(double size) : super(size, SpaceDirection.vertical);
}

class _HorizontalSpace extends Space {
  const _HorizontalSpace(double size) : super(size, SpaceDirection.horizontal);
}