class MedicineModel {
  final String brandId;
  final String brandName;
  final String type;
  final String slug;
  final String dosageForm;
  final String generic;
  final String strength;
  final String manufacturer;
  final String packageContainer;
  final String packageSize;

  MedicineModel({
    required this.brandId,
    required this.brandName,
    required this.type,
    required this.slug,
    required this.dosageForm,
    required this.generic,
    required this.strength,
    required this.manufacturer,
    required this.packageContainer,
    required this.packageSize,
  });
}
