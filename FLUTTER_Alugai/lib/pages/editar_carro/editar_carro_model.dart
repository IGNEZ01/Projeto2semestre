import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import 'editar_carro_widget.dart' show EditarCarroWidget;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class EditarCarroModel extends FlutterFlowModel<EditarCarroWidget> {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // State field(s) for textFild_Nome widget.
  FocusNode? textFildNomeFocusNode;
  TextEditingController? textFildNomeTextController;
  String? Function(BuildContext, String?)? textFildNomeTextControllerValidator;
  // State field(s) for textFild_Matricula widget.
  FocusNode? textFildMatriculaFocusNode;
  TextEditingController? textFildMatriculaTextController;
  String? Function(BuildContext, String?)?
      textFildMatriculaTextControllerValidator;
  // State field(s) for DropDown_Marca widget.
  String? dropDownMarcaValue;
  FormFieldController<String>? dropDownMarcaValueController;
  // State field(s) for DropDown_Modelo widget.
  String? dropDownModeloValue;
  FormFieldController<String>? dropDownModeloValueController;
  // State field(s) for DropDown_Tipo widget.
  String? dropDownTipoValue;
  FormFieldController<String>? dropDownTipoValueController;
  // State field(s) for DropDown_Ano widget.
  String? dropDownAnoValue;
  FormFieldController<String>? dropDownAnoValueController;
  // State field(s) for DropDown_Combustivel widget.
  String? dropDownCombustivelValue;
  FormFieldController<String>? dropDownCombustivelValueController;
  // State field(s) for DropDown_Cor widget.
  String? dropDownCorValue;
  FormFieldController<String>? dropDownCorValueController;
  // State field(s) for DropDown_Portas widget.
  String? dropDownPortasValue;
  FormFieldController<String>? dropDownPortasValueController;
  // State field(s) for DropDown_Lugares widget.
  String? dropDownLugaresValue;
  FormFieldController<String>? dropDownLugaresValueController;
  // State field(s) for Switch widget.
  bool? switchValue;
  // State field(s) for textFild_ValorDia widget.
  FocusNode? textFildValorDiaFocusNode;
  TextEditingController? textFildValorDiaTextController;
  String? Function(BuildContext, String?)?
      textFildValorDiaTextControllerValidator;
  // State field(s) for textFild_CodPostalCarro widget.
  FocusNode? textFildCodPostalCarroFocusNode;
  TextEditingController? textFildCodPostalCarroTextController;
  String? Function(BuildContext, String?)?
      textFildCodPostalCarroTextControllerValidator;
  // State field(s) for textFild_MoradaCarro widget.
  FocusNode? textFildMoradaCarroFocusNode;
  TextEditingController? textFildMoradaCarroTextController;
  String? Function(BuildContext, String?)?
      textFildMoradaCarroTextControllerValidator;
  // State field(s) for textFild_Descricao widget.
  FocusNode? textFildDescricaoFocusNode;
  TextEditingController? textFildDescricaoTextController;
  String? Function(BuildContext, String?)?
      textFildDescricaoTextControllerValidator;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    unfocusNode.dispose();
    textFildNomeFocusNode?.dispose();
    textFildNomeTextController?.dispose();

    textFildMatriculaFocusNode?.dispose();
    textFildMatriculaTextController?.dispose();

    textFildValorDiaFocusNode?.dispose();
    textFildValorDiaTextController?.dispose();

    textFildCodPostalCarroFocusNode?.dispose();
    textFildCodPostalCarroTextController?.dispose();

    textFildMoradaCarroFocusNode?.dispose();
    textFildMoradaCarroTextController?.dispose();

    textFildDescricaoFocusNode?.dispose();
    textFildDescricaoTextController?.dispose();
  }
}
