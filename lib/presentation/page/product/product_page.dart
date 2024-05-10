import 'package:d_info/d_info.dart';
import 'package:d_view/d_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/model/product.dart';
import '../../controller/c_product.dart';
import 'add_update_product_page.dart';
import '../../../data/source/source_product.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  final cProduct = Get.put(CProduct());

  Future<void> deleteProduct(String code) async {
    bool? yes = await DInfo.dialogConfirmation(
      context, 
      'Eliminar Producto', 
      '¿Estás seguro de que deseas eliminar el producto?'
    );
    if (yes == true) {
      bool success = await SourceProduct.delete(code);
      if (success) {
        DInfo.dialogSuccess('Producto eliminado exitosamente');
        DInfo.closeDialog(actionAfterClose: () {
          cProduct.setList();
        });
      } else {
        DInfo.dialogError('Error al eliminar el producto');
        DInfo.closeDialog();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Producto'),
        titleSpacing: 0,
        actions: [
          IconButton(
            onPressed: () {
              Get.to(() => const AddUpdateProductPage())?.then((value) {
                if (value == true) {
                  cProduct.setList();
                }
              });
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: Obx(() {
        if (cProduct.loading) return DView.loadingCircle();
        if (cProduct.list.isEmpty) return DView.empty();
        return ListView.separated(
          itemCount: cProduct.list.length,
          separatorBuilder: (context, index) {
            return const Divider(
              height: 1,
              color: Colors.white60,
              indent: 16,
              endIndent: 16,
            );
          },
          itemBuilder: (context, index) {
            Product product = cProduct.list[index];
            return Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 0, 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 30,
                    width: 30,
                    child: Text('${index + 1}'),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          product.name ?? '',
                          style: textTheme.headline6!.copyWith(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          product.code ?? '',
                          style: textTheme.subtitle2!.copyWith(color: Colors.white70),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Rp ${product.price ?? '0'}',
                          style: textTheme.subtitle1!.copyWith(color: Colors.green, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 16),
                        child: Text(
                          product.stock.toString(),
                          style: textTheme.headline6!.copyWith(fontWeight: FontWeight.w300),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Padding(
                        padding: const EdgeInsets.only(right: 16),
                        child: Text(
                          product.unit ?? '',
                          style: textTheme.subtitle2!.copyWith(color: Colors.white70),
                        ),
                      ),
                      PopupMenuButton(
                        onSelected: (value) {
                          if (value == 'update') {
                            Get.to(() => AddUpdateProductPage(product: product))?.then((value) {
                              if (value == true) cProduct.setList();
                            });
                          } else {
                            deleteProduct(product.code!);
                          }
                        },
                        icon: const Icon(Icons.more_horiz),
                        itemBuilder: (context) => [
                          const PopupMenuItem(
                            value: 'update',
                            child: Text('Actualizar'),
                          ),
                          const PopupMenuItem(
                            value: 'delete',
                            child: Text('Eliminar'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      }),
    );
  }
}

