import 'package:bloc_to_do/utils/colors.dart';
import 'package:flutter/material.dart';

class BodyFormWidget extends StatelessWidget {
  const BodyFormWidget({
    Key? key,
    required Size size,
    required TextEditingController controller,
  })  : _size = size,
        _descriptionController = controller,
        super(key: key);

  final Size _size;
  final TextEditingController _descriptionController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      selectionControls: MaterialTextSelectionControls(),
      controller: _descriptionController,
      keyboardType: TextInputType.multiline,
      maxLines: null,
      decoration: InputDecoration(
        hintText: 'Inserta tu texto',
        hintStyle: Theme.of(context).textTheme.headline1!.copyWith(
              color: AppColors.lightGray,
              fontSize: _size.width * 0.06,
            ),
        contentPadding: EdgeInsets.symmetric(
          vertical: _size.width * 0.02,
          horizontal: _size.width * 0.02,
        ),
        border: InputBorder.none,
      ),
      style: Theme.of(context).textTheme.bodyText1!.copyWith(
            fontSize: _size.width * 0.05,
          ),
    );
  }
}
