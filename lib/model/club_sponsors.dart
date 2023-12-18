class ClubSponsors {
  String? id;
  String? sponsorIcon;
  String? image;
  String? imageTwo;
  String? imageThree;
  String? imageFour;
  String? imageFive;
  String? name;
  String? phone;
  String? twitter;
  String? instagram;
  String? facebook;
  String? snapchat;
  String? youtube;
  String? website;
  String? email;
  String? aboutUs;
  String? ourServices;
  String? address;
  String? category;

  ClubSponsors.fromMap(Map<String?, dynamic> data) {
    id = data['id'];
    sponsorIcon = data['sponsor_icon'];
    image = data['image'];
    imageTwo = data['image_two'];
    imageThree = data['image_three'];
    imageFour = data['image_four'];
    imageFive = data['image_five'];
    name = data['name'];
    phone = data['phone'];
    twitter = data['twitter'];
    instagram = data['instagram'];
    facebook = data['facebook'];
    snapchat = data['snapchat'];
    youtube = data['youtube'];
    website = data['website'];
    email = data['email'];
    aboutUs = data['about_us'];
    ourServices = data['our_services'];
    address = data['address'];
    category = data['category'];
  }

  @override
  bool operator == (Object other) {
    if (identical(this, other)) return true;

    return other is ClubSponsors &&
        other.id == id &&
        other.sponsorIcon == sponsorIcon &&
        other.image == image &&
        other.imageTwo == imageTwo &&
        other.imageThree == imageThree &&
        other.imageFour == imageFour &&
        other.imageFive == imageFive &&
        other.name == name &&
        other.phone == phone &&
        other.twitter == twitter &&
        other.instagram == instagram &&
        other.facebook == facebook &&
        other.snapchat == snapchat &&
        other.youtube == youtube &&
        other.website == website &&
        other.email == email &&
        other.aboutUs == aboutUs &&
        other.ourServices == ourServices &&
        other.address == address &&
        other.category == category;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        sponsorIcon.hashCode ^
        image.hashCode ^
        imageTwo.hashCode ^
        imageThree.hashCode ^
        imageFour.hashCode ^
        imageFive.hashCode ^
        name.hashCode ^
        phone.hashCode ^
        twitter.hashCode ^
        instagram.hashCode ^
        facebook.hashCode ^
        snapchat.hashCode ^
        youtube.hashCode ^
        website.hashCode ^
        email.hashCode ^
        aboutUs.hashCode ^
        ourServices.hashCode ^
        address.hashCode ^
        category.hashCode;
  }
}
