class Movie {
  final String title;
  final String poster;
  final String rating;
  final String duration;
  final String date;

  Movie({
    required this.title,
    required this.poster,
    required this.rating,
    required this.duration,
    required this.date,
  });

  static List<Movie> sampleMovies = [
    Movie(
      title: 'CỤC VÀNG CỦA NGOẠI',
      poster:
      'https://www.cgv.vn/media/catalog/product/cache/1/image/c5f0a1eff4c394a251036189ccddaacd/4/7/470wx700h-cvcn_1.jpg',
      rating: '7.5',
      duration: '119 Phút',
      date: '17/10/2025',
    ),
    Movie(
      title: 'CHỊ NGÃ EM NÂNG',
      poster:
      'https://api-website.cinestar.com.vn/media/wysiwyg/Posters/10-2025/CNEN_MAIN2_1500x1200.jpg',
      rating: '7.2',
      duration: '122 Phút',
      date: '03/10/2025',
    ),
    Movie(
      title: 'NĂM CỦA ANH, NGÀY CỦA EM',
      poster:
      'https://api-website.cinestar.com.vn/media/wysiwyg/Posters/10-2025/nam-cua-anh-ngay-cua-em-poster.jpg',
      rating: '7.8',
      duration: '126 Phút',
      date: '25/10/2025',
    ),
    Movie(
      title: 'TỬ CHIẾN TRÊN KHÔNG',
      poster:
      'https://iguov8nhvyobj.vcdn.cloud/media/catalog/product/cache/1/image/c5f0a1eff4c394a251036189ccddaacd/m/a/main_tctk_social.jpg',
      rating: '9.6',
      duration: '118 Phút',
      date: '19/09/2025',
    ),
  ];
}
