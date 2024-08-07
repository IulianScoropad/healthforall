
class AvailableDoctor {
  final String? key, username,experience, time, region, phone, numarpacienti, mail, hospitalname, categorie, adresa, despre, image;



  AvailableDoctor({
    required this.key,
    this.experience,
    this.username,
    this.time,
    this.region,
    this.phone,
    this.numarpacienti,
    this.mail,
    this.hospitalname,
    this.categorie,
    this.adresa,
    this.despre,
    this.image
  });


  factory AvailableDoctor.fromMap(String key,Map<dynamic, dynamic> data) {

    return AvailableDoctor(
      key: key,
      username: data['username'],
      region: data['region'],
      experience: data['experienceyears'],
      numarpacienti: data['numberpatienti'],
      time: data['time'],
      phone: data['phone'],
      mail: data['mail'],
      hospitalname: data['hospitalname'],
      adresa: data['adress'],
      despre: data['about'],
      image: "assets/images/doctor_photo.png",
      categorie: data["category"]
    );
  }
}

