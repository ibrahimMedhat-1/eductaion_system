class OfferModel {
  String? image;

  OfferModel.fromJson(Map<String, dynamic>? json) {
    image = json!['image'];
  }
}
