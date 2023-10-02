class UpdateItemCmd {
  final int id;
  final String category;
  final String itemType;
  final String brand;
  final String description;
  final bool isClaimed;

  UpdateItemCmd(this.id, this.category, this.itemType, this.brand,
      this.description, this.isClaimed);
}
