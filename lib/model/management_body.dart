class ManagementBody {
  String? autoBio;
  String? staffPosition;
  String? yearOfInception;
  String? regionOfOrigin;
  String? nationality;
  String? hobbies;
  String? bestMoment;
  String? worstMoment;
  String? philosophy;
  String? email;
  String? facebook;
  String? linkedIn;
  String? id;
  String? image;
  String? imageTwo;
  String? instagram;
  String? name;
  String? phone;
  String? twitter;
  String? whyLoveCoachingOrFCManagement;
  String? favSportingIcon;

  ManagementBody.fromMap(Map<String?, dynamic> data) {
    id = data['id'];
    autoBio = data['autobio'];
    email = data['email'];
    facebook = data['facebook'];
    image = data['image'];
    imageTwo = data['image_two'];
    instagram = data['instagram'];
    name = data['name'];
    phone = data['phone'];
    twitter = data['twitter'];
    linkedIn = data['linkedIn'];
    yearOfInception = data['year_of_inception'];
    regionOfOrigin = data['region_of_origin'];
    nationality = data['nationality'];
    hobbies = data['hobbies'];
    bestMoment = data['best_moment'];
    worstMoment = data['worst_moment'];
    staffPosition = data['staff_position'];
    philosophy = data['philosophy'];
    whyLoveCoachingOrFCManagement =
        data['why_you_love_coaching_or_fc_management'];
    favSportingIcon = data['fav_sporting_icon'];
  }
}
