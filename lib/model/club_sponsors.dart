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
}
