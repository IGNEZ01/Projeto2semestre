import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'editar_cliente_widget.dart' show EditarClienteWidget;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class EditarClienteModel extends FlutterFlowModel<EditarClienteWidget> {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // State field(s) for textFild_Nome widget.
  FocusNode? textFildNomeFocusNode;
  TextEditingController? textFildNomeTextController;
  String? Function(BuildContext, String?)? textFildNomeTextControllerValidator;
  // State field(s) for textFild_Nif widget.
  FocusNode? textFildNifFocusNode;
  TextEditingController? textFildNifTextController;
  String? Function(BuildContext, String?)? textFildNifTextControllerValidator;
  // State field(s) for textFild_Carta widget.
  FocusNode? textFildCartaFocusNode;
  TextEditingController? textFildCartaTextController;
  String? Function(BuildContext, String?)? textFildCartaTextControllerValidator;
  // State field(s) for textField_Email widget.
  FocusNode? textFieldEmailFocusNode;
  TextEditingController? textFieldEmailTextController;
  String? Function(BuildContext, String?)?
      textFieldEmailTextControllerValidator;
  // State field(s) for textField_Telefone widget.
  FocusNode? textFieldTelefoneFocusNode;
  TextEditingController? textFieldTelefoneTextController;
  String? Function(BuildContext, String?)?
      textFieldTelefoneTextControllerValidator;
  // State field(s) for textFild_Morada widget.
  FocusNode? textFildMoradaFocusNode;
  TextEditingController? textFildMoradaTextController;
  String? Function(BuildContext, String?)?
      textFildMoradaTextControllerValidator;
  // State field(s) for textFild_CodPostal widget.
  FocusNode? textFildCodPostalFocusNode;
  TextEditingController? textFildCodPostalTextController;
  String? Function(BuildContext, String?)?
      textFildCodPostalTextControllerValidator;
  // State field(s) for textFild_Localidade widget.
  FocusNode? textFildLocalidadeFocusNode;
  TextEditingController? textFildLocalidadeTextController;
  String? Function(BuildContext, String?)?
      textFildLocalidadeTextControllerValidator;
  // State field(s) for textFild_Pais widget.
  FocusNode? textFildPaisFocusNode;
  TextEditingController? textFildPaisTextController;
  String? Function(BuildContext, String?)? textFildPaisTextControllerValidator;
  // State field(s) for password widget.
  FocusNode? passwordFocusNode;
  TextEditingController? passwordTextController;
  late bool passwordVisibility;
  String? Function(BuildContext, String?)? passwordTextControllerValidator;
  // State field(s) for passwordConfirm widget.
  FocusNode? passwordConfirmFocusNode;
  TextEditingController? passwordConfirmTextController;
  late bool passwordConfirmVisibility;
  String? Function(BuildContext, String?)?
      passwordConfirmTextControllerValidator;

  @override
  void initState(BuildContext context) {
    passwordVisibility = false;
    passwordConfirmVisibility = false;
  }

  @override
  void dispose() {
    unfocusNode.dispose();
    textFildNomeFocusNode?.dispose();
    textFildNomeTextController?.dispose();

    textFildNifFocusNode?.dispose();
    textFildNifTextController?.dispose();

    textFildCartaFocusNode?.dispose();
    textFildCartaTextController?.dispose();

    textFieldEmailFocusNode?.dispose();
    textFieldEmailTextController?.dispose();

    textFieldTelefoneFocusNode?.dispose();
    textFieldTelefoneTextController?.dispose();

    textFildMoradaFocusNode?.dispose();
    textFildMoradaTextController?.dispose();

    textFildCodPostalFocusNode?.dispose();
    textFildCodPostalTextController?.dispose();

    textFildLocalidadeFocusNode?.dispose();
    textFildLocalidadeTextController?.dispose();

    textFildPaisFocusNode?.dispose();
    textFildPaisTextController?.dispose();

    passwordFocusNode?.dispose();
    passwordTextController?.dispose();

    passwordConfirmFocusNode?.dispose();
    passwordConfirmTextController?.dispose();
  }
}
