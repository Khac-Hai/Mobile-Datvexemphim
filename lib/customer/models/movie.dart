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
    Movie(
      title: 'CHÓ CƯNG ĐỪNG SỢ',
      poster:
      'https://www.cgv.vn/media/catalog/product/cache/1/image/c5f0a1eff4c394a251036189ccddaacd/g/o/good_boy_-_payoff_poster_-_kc_24102025.jpg',
      rating: '8.0',
      duration: '73 Phút',
      date: '24/10/2025',
    ),
    Movie(
      title: 'PHÁ ĐÁM SINH NHẬT MẸ',
      poster:
      'https://www.cgv.vn/media/catalog/product/cache/1/image/1800x/71252117777b696995f01934522c402d/3/5/350x495-snme.jpg',
      rating: '0.0',
      duration: '91 Phút',
      date: '31/10/2025',
    ),
    Movie(
      title: 'BỊT MẮT BẮT NAI',
      poster:
      'https://www.cgv.vn/media/catalog/product/cache/1/image/c5f0a1eff4c394a251036189ccddaacd/t/m/tmdb-poster-2000x3000.jpg',
      rating: '0.0',
      duration: '92 Phút',
      date: '31/10/2025',
    ),
    Movie(
      title: 'NHÀ MA XÓ',
      poster:
      'https://www.cgv.vn/media/catalog/product/cache/1/image/c5f0a1eff4c394a251036189ccddaacd/3/5/350x495-nhamaxo.jpg',
      rating: '8.7',
      duration: '108 Phút',
      date: '24/10/2025',
    ),
    Movie(
      title: 'ĐIỆN THOẠI ĐEN',
      poster:
      'https://www.cgv.vn/media/catalog/product/cache/1/image/c5f0a1eff4c394a251036189ccddaacd/4/7/470x700-tbp2.jpg',
      rating: '10.0',
      duration: '114 Phút',
      date: '31/10/2025',
    ),
    Movie(
      title: 'TEE YOD: QUỶ ĂN TẠNG PHẦN 3',
      poster:
      'https://www.cgv.vn/media/catalog/product/cache/1/image/c5f0a1eff4c394a251036189ccddaacd/t/y/ty3-sneak-main_poster-2-layered.jpg',
      rating: '6.9',
      duration: '104 Phút',
      date: '10/10/2025',
    ),
    Movie(
      title: 'PHIM SHIN CẬU BÉ BÚT CHÌ: NÓNG BỎNG TAY!',
      poster:
      'https://www.cgv.vn/media/catalog/product/cache/1/image/c5f0a1eff4c394a251036189ccddaacd/1/_/1.20wx1.80h.jpg',
      rating: '10.0',
      duration: '105 Phút',
      date: '22/08/2025',
    ),
    Movie(
      title: 'CẬU BÉ CÁ HEO VÀ BÍT MẬT 7 ĐẠI DƯƠNG',
      poster:
      'https://www.cgv.vn/media/catalog/product/cache/1/image/c5f0a1eff4c394a251036189ccddaacd/c/a/ca_u_be_ca_heo_2_-_payoff_poster_-_kc_03.10.2025.jpg',
      rating: '0.0',
      duration: '96 Phút',
      date: '03/10/2025',
    ),
    Movie(
      title: 'TỚ VÀ ROBOCO: SIÊU CẤP ĐA VŨ TRỤ',
      poster:
      'https://cms.megagscinemas.vn//media/77651/roboco_m_kv_0131.jpg',
      rating: '0.0',
      duration: '64 Phút',
      date: '24/10/2025',
    ),
  ];
}

