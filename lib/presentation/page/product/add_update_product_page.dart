import 'package:d_info/d_info.dart';
import 'package:d_input/d_input.dart';
import 'package:d_view/d_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/model/product.dart';
import '../../../data/source/source_product.dart';

class AddUpdateProductPage extends StatefulWidget {
  const AddUpdateProductPage({super.key, this.product});
  final Product? product;

  @override
  State<AddUpdateProductPage> createState() => _AddUpdateProductPageState();
}

class _AddUpdateProductPageState extends State<AddUpdateProductPage> {
  final TextEditingController controllerCode = TextEditingController();
  final TextEditingController controllerName = TextEditingController();
  final TextEditingController controllerPrice = TextEditingController();
  final TextEditingController controllerStock = TextEditingController();
  final TextEditingController controllerUnit = TextEditingController();
  final TextEditingController controllerExp = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    if (widget.product != null) {
      controllerCode.text = widget.product!.code ?? '';
      controllerName.text = widget.product!.name ?? '';
      controllerStock.text = widget.product!.stock.toString();
      controllerUnit.text = widget.product!.unit ?? '';
      controllerPrice.text = widget.product!.price ?? '';
      controllerExp.text = widget.product!.exp ?? '';
    }
  }

  @override
  void dispose() {
    controllerCode.dispose();
    controllerName.dispose();
    controllerPrice.dispose();
    controllerStock.dispose();
    controllerUnit.dispose();
    controllerExp.dispose();
    super.dispose();
  }

  void addProduct() async {
    bool ? confirmation = await DInfo.dialogConfirmation(
      context,
      'Agregar Producto',
      '¿Estás seguro de que deseas agregar un nuevo producto?',
    );
    if (confirmation ?? false) {
      bool success = await SourceProduct.add(Product(
        code: controllerCode.text,
        name: controllerName.text,
        price: controllerPrice.text,
        stock: int.parse(controllerStock.text),
        unit: controllerUnit.text,
        exp: controllerExp.text,
      ));
      if (success) {
        DInfo.dialogSuccess('Producto agregado exitosamente');
        DInfo.closeDialog(actionAfterClose: () {
          Get.back(result: true);
        });
      } else {
        DInfo.dialogError('Error al agregar el producto');
        DInfo.closeDialog();
      }
    }
  }

  void updateProduct() async {
    bool ? confirmation = await DInfo.dialogConfirmation(
      context,
      'Actualizar Producto',
      '¿Estás seguro de que deseas actualizar el producto?',
    );
    if (confirmation ?? false) {
      bool success = await SourceProduct.update(
        widget.product!.code!,
        Product(
          code: controllerCode.text,
          name: controllerName.text,
          price: controllerPrice.text,
          stock: int.parse(controllerStock.text),
          unit: controllerUnit.text,
          exp: controllerExp.text,
        ),
      );
      if (success) {
        DInfo.dialogSuccess('Producto actualizado exitosamente');
        DInfo.closeDialog(actionAfterClose: () {
          Get.back(result: true);
        });
      } else {
        DInfo.dialogError('Error al actualizar el producto');
        DInfo.closeDialog();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.product == null ? 'Agregar Producto' : 'Actualizar Producto'),
      ),
      body: Form(
        key: formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            DInput(
              controller: controllerCode,
              hint: 'JAGS676',
              title: 'Código',
              validator: (value) => value?.isEmpty ?? true ? 'No dejar vacío' : null,
              isRequired: true,
            ),
            DView.spaceHeight(),
            DInput(
              controller: controllerName,
              hint: 'Tu Nombre',
              title: 'Nombre',
              validator: (value) => value?.isEmpty ?? true ? 'No dejar vacío' : null,
              isRequired: true,
            ),
            DView.spaceHeight(),
            DInput(
              controller: controllerPrice,
              hint: '2000000',
              title: 'Precio',
              validator: (value) => value?.isEmpty ?? true ? 'No dejar vacío' : null,
              isRequired: true,
              inputType: TextInputType.number,
            ),
            DView.spaceHeight(),
            DInput(
              controller: controllerStock,
              hint: '50',
              title: 'Existencia',
              validator: (value) => value?.isEmpty ?? true ? 'No dejar vacío' : null,
              isRequired: true,
              inputType: TextInputType.number,
            ),
            DView.spaceHeight(),
            DInput(
              controller: controllerUnit,
              hint: 'Artículo',
              title: 'Unidad',
              validator: (value) => value?.isEmpty ?? true ? 'No dejar vacío' : null,
              isRequired: true,
            ),
            DView.spaceHeight(),
            DInput(
              controller: controllerExp,
              hint: 'Fecha',
              title: 'Caduca',
              validator: (value) => value?.isEmpty ?? true ? 'No dejar vacío' : null,
              isRequired: true,
            ),
            DView.spaceHeight(),
            ElevatedButton(
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  if (widget.product == null) {
                    addProduct();
                  } else {
                    updateProduct();
                  }
                }
              },
              child: Text(widget.product == null ? 'Agregar Producto' : 'Actualizar Producto'),
            ),
          ],
        ),
      ),
    );
  }
}

