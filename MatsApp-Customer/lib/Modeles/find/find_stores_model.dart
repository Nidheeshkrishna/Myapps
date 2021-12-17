import 'package:matsapp/utilities/app_json_parser.dart';

class FindStoresModel {
  final int businessId;
  final String businessName;
  final String imageUrl;
  final String provideOffers;
  final bool isMall;
  final double rating;
  final int wishListId;
  final String distanceKm;

  final int reviewCount;

  FindStoresModel._({
    this.businessId,
    this.businessName,
    this.imageUrl,
    this.provideOffers,
    this.isMall,
    this.rating,
    this.wishListId,
    this.distanceKm,
    this.reviewCount,
  });

  copyWith({
    int businessId,
    String businessName,
    String imageUrl,
    String provideOffers,
    bool isMall,
    double rating,
    int wishListId,
    String distanceKm,
  }) {
    return FindStoresModel._(
      businessId: businessId ?? this.businessId,
      businessName: businessName ?? this.businessName,
      imageUrl: imageUrl ?? this.imageUrl,
      provideOffers: provideOffers ?? this.provideOffers,
      isMall: isMall ?? this.isMall,
      rating: rating ?? this.rating,
      wishListId: wishListId ?? this.wishListId,
      distanceKm: distanceKm ?? this.distanceKm,
      reviewCount: reviewCount ?? this.reviewCount,
    );
  }

  factory FindStoresModel.fromJson(Map<String, dynamic> json) {
    return FindStoresModel._(
      businessId: AppJsonParser.goodInt(json, 'PK_BusinessID'),
      businessName: AppJsonParser.goodString(json, 'BusinessName'),
      imageUrl: AppJsonParser.goodString(json, 'CoverImageUrl'),
      provideOffers: AppJsonParser.goodString(json, 'ProvideOffers'),
      isMall: AppJsonParser.goodBoolean(json, 'IsMall'),
      rating: AppJsonParser.goodDouble(json, 'Rating'),
      wishListId: AppJsonParser.goodInt(json, 'WishListID'),
      reviewCount: AppJsonParser.goodInt(json, 'ReviewCount') ?? 0,
      distanceKm: AppJsonParser.goodString(json, 'DistanceinKm'),
    );
  }

  @override
  String toString() {
    return 'FindStoresModel{businessId: $businessId, businessName: $businessName, imageUrl: $imageUrl, provideOffers: $provideOffers, isMall: $isMall, rating: $rating, wishListId: $wishListId, distanceKm: $distanceKm, reviewCount: $reviewCount}';
  }
}
