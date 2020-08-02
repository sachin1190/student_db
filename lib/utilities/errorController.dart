import 'package:flare_flutter/flare.dart';
import 'package:flare_dart/math/mat2d.dart';
import 'package:flare_dart/math/vec2d.dart';
import 'dart:math';
import 'dart:ui';
import 'package:flare_flutter/flare_controls.dart';

class ErrorController extends FlareControls {
  ActorNode _faceControl;

  Mat2D _globalToFlareWorld = Mat2D();

  // Caret in Flutter global coordinates.
  Vec2D _caretGlobal = Vec2D();

  Vec2D _caretWorld = Vec2D();

  Vec2D _faceOrigin = Vec2D();
  Vec2D _faceOriginLocal = Vec2D();

  bool _hasFocus = false;

  static const double _projectGaze = 60.0;

  @override
  bool advance(FlutterActorArtboard artboard, double elapsed) {
    super.advance(artboard, elapsed);
    Vec2D targetTranslation;
    if (_hasFocus) {
      Vec2D.transformMat2D(_caretWorld, _caretGlobal, _globalToFlareWorld);

      _caretWorld[1] +=
          sin(new DateTime.now().millisecondsSinceEpoch / 300.0) * 70.0;

      // Compute direction vector.
      Vec2D toCaret = Vec2D.subtract(Vec2D(), _caretWorld, _faceOrigin);
      Vec2D.normalize(toCaret, toCaret);
      Vec2D.scale(toCaret, toCaret, _projectGaze);

      Mat2D toFaceTransform = Mat2D();
      if (Mat2D.invert(toFaceTransform, _faceControl.worldTransform)) {
        Vec2D.transformMat2(toCaret, toCaret, toFaceTransform);
        targetTranslation = Vec2D.add(Vec2D(), toCaret, _faceOriginLocal);
      }
    } else {
      targetTranslation = Vec2D.clone(_faceOriginLocal);
    }
    Vec2D diff =
        Vec2D.subtract(Vec2D(), targetTranslation, _faceControl.translation);
    Vec2D frameTranslation = Vec2D.add(Vec2D(), _faceControl.translation,
        Vec2D.scale(diff, diff, min(1.0, elapsed * 5.0)));

    _faceControl.translation = frameTranslation;

    return true;
  }

  @override
  void initialize(FlutterActorArtboard artboard) {
    super.initialize(artboard);
    _faceControl = artboard.getNode("eyes");
    if (_faceControl != null) {
      _faceControl.getWorldTranslation(_faceOrigin);
      Vec2D.copy(_faceOriginLocal, _faceControl.translation);
    }
  }

  @override
  void setViewTransform(Mat2D viewTransform) {
    Mat2D.invert(_globalToFlareWorld, viewTransform);
  }

  void lookAt(Offset caret) {
    if (caret == null) {
      _hasFocus = false;
      return;
    }
    _caretGlobal[0] = caret.dx;
    _caretGlobal[1] = caret.dy;
    _hasFocus = true;
  }
}
