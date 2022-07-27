class ManagementBody {
  String? autoBio;
  String? staffPosition;
  String? yearOfInception;
  String? regionOfOrigin;
  String? nationality;
  String? hobbies;
  String? philosophy;
  String? email;
  String? facebook;
  String? id;
  String? image;
  String? imageTwo;
  String? instagram;
  String? name;
  String? phone;
  String? twitter;

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
    yearOfInception = data['year_of_inception'];
    staffPosition = data['staff_position'];
    regionOfOrigin = data['region_of_origin'];
    nationality = data['nationality'];
    hobbies = data['hobbies'];
    philosophy = data['philosophy'];
  }

}