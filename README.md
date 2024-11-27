# 🍽️ RasaPalembangMobile 🍽️
![rasapalembang](https://github.com/user-attachments/assets/317469a4-de19-450f-94ec-28102dd20121)

## Anggota Kelompok

- [Athallah Damar Jiwanto](https://www.github.com/AthallahD)
- [Muhammad Fawwaz Edsa Fatin Setiawan](https://www.github.com/bemosumo)
- [Muhammad Fazil Tirtana](https://www.github.com/fazirta)
- [Madeline Clairine Gultom](https://www.github.com/mdlnecg)
- [Syauqi Muhammad Yasman](https://www.github.com/syauqiyasman)
- [Andi Aqsa Mappatunru Marzuki](https://www.github.com/andiaqsa)

## 💁 Deskripsi dan Manfaat Aplikasi 💁

RasaPalembang adalah aplikasi berbasis web dan android yang dirancang untuk membantu wisatawan dan penduduk lokal menemukan berbagai produk kuliner di Palembang. Dengan antarmuka yang intuitif, pengguna dapat menjelajahi kuliner khas Palembang, membaca ulasan, serta berbagi pengalaman mereka.

Terkadang wisatawan yang berkunjung ke Palembang merasa bingung untuk mencari tempat makan yang sesuai dengan selera mereka. Banyaknya pilihan kuliner di Palembang bisa membuat wisatawan kesulitan menentukan restoran mana yang sebaiknya dikunjungi, terutama jika mereka baru pertama kali datang. Tak terbatas untuk wisatawan saja, penduduk lokal juga dapat menemukan restoran-restoran atau makanan-makanan baru yang ada di Palembang.

Dalam mencari restoran, wisatawan cenderung bertanya atau mengunjungi restoran yang dilewatinya saja. Alhasil, pengalaman yang didapatkan oleh wisatawan kebanyakan tidak membuat mereka puas. Oleh karena itu, RasaPalembang hadir untuk menyajikan informasi yang dapat membantu, seperti ulasan, rekomendasi, dan lokasi kuliner terbaik yang ada di Palembang. Tidak hanya itu, RasaPalembang juga mendukung pemilik restoran untuk memasarkan usaha mereka dengan menambahkan restoran milik mereka ke dalam aplikasi RasaPalembang. Sehingga, restoran mereka dapat dengan mudah ditemukan baik oleh para wisatawan maupun penduduk lokal pencinta kuliner.

## 📃 Daftar Modul 📃

1. **Makanan 🍲 (Damar)**: Menyediakan berbagai pilihan makanan beserta kategorinya, seperti makanan pembuka, hidangan utama, dan makanan penutup. Pengguna dapat menjelajahi dan menemukan hidangan khas Palembang yang lezat.
2. **Minuman 🍹 (Syauqi)**: Menampilkan berbagai pilihan minuman seperti minuman tradisional dari Palembang dan modern.
3. **Restoran 🍴 (Fawwaz)**: Modul ini memberikan informasi lengkap tentang berbagai restoran di Palembang, termasuk menu, harga, jam operasional, dan lokasi.
4. **Ulasan dan Rating 📝 (Fazil)**: Setiap restoran dilengkapi dengan fitur ulasan dan rating, memungkinkan pengguna untuk memberikan feedback yang konstruktif. Ulasan ini membantu orang lain dalam membuat keputusan dan menemukan restoran terbaik berdasarkan pengalaman pengguna sebelumnya.
5. **Forum Diskusi 💡 (Madeline)**: Modul ini menciptakan ruang interaktif bagi pengguna untuk berdiskusi tentang setiap restoran. Pengguna dapat mengajukan pertanyaan, berbagi pengalaman, dan memberikan rekomendasi, membangun komunitas yang saling mendukung dan penuh informasi.
6. **Favorit 🩷 (Andi Aqsa)**: Modul untuk menyimpan dan menampilkan makanan dan minuman yang disukai serta daftar restoran yang ingin dikunjungi oleh pengguna. Pengguna dapat menambahkan catatan ke makanan, minuman, dan restoran yang masuk ke daftar favorit mereka. Pengguna juga dapat mengubah catatan dan menghapus daftar favorit yang telah mereka simpan sebelumnya.

## 👤 Peran Pengguna 👤
Aplikasi ini memiliki beberapa jenis pengguna dengan peran sebagai berikut:

1. **Pengguna Umum**: Dapat menjelajahi berbagai pilihan kuliner, restoran, dan kafe yang ada di Palembang, serta menemukan rekomendasi terbaik untuk pengalaman kuliner mereka.
2. **Pengulas**: Dapat memberikan ulasan yang mendetail tentang pengalaman kuliner dan kunjungan mereka, membantu orang lain dalam membuat pilihan yang lebih baik.
3. **Pemilik Restoran**: Dapat mendaftarkan restoran atau kafe mereka, mengelola profil bisnis.

## ⛓️ Alur Pengintegrasian dengan Web Service ⛓️

Berikut adalah langkah-langkah yang kami lakukan untuk mengintegrasikan aplikasi dengan server web:

1. Membuat wrapper class dengan menggunakan library HTTP dan map untuk mendukung autentikasi berbasis cookie dalam aplikasi.
2. Mengimplementasikan REST API di setiap modul Django (views.py) dengan menggunakan JsonResponse atau Django JSON Serializer untuk pertukaran data.
3. Mendesain tampilan aplikasi berdasarkan desain website yang telah dibuat pada proyek tengah semester sebelumnya.
4. Melakukan integrasi antara frontend dan backend menggunakan konsep asynchronous HTTP untuk meningkatkan kecepatan dan responsivitas aplikasi.

![gambar-diagram-alur-pengintegrasian-rasa-palembang-mobile-dengan-rasa-palembang-django](https://github.com/user-attachments/assets/b83ae2ed-fdc5-4e85-9155-1cac28691f47)

Berikut adalah penjelasan dari diagram alur pengintegrasian RasaPalembangMobile dengan web service (RasaPalembang Django):

1. Pengguna membuat permintaan dari aplikasi RasaPalembangMobile ke internet, misalnya saat ingin melihat minuman. Internet kemudian meneruskan permintaan tersebut ke aplikasi web RasaPalembang (Django).

2. Aplikasi Django menerima permintaan dari internet dan memproses di file views.py untuk menentukan fungsi yang tepat untuk menangani permintaan.

3. File views.py berkomunikasi dengan file models.py untuk melakukan operasi database yang diperlukan.

4. File models.py berinteraksi dengan database untuk memproses operasi terkait database, seperti memuat minuman.

5. Data objek model yang berasal dari file models.py dikirim menuju serializer.

6. Serializer digunakan untuk menerjemahkan objek model ke format lain, dalam hal ini JSON.

7. File views.py menyediakan data JSON, yang kemudian dikirim oleh Django melalui internet ke aplikasi RasaPalembangMobile.

8. Aplikasi RasaPalembangMobile menerima data dalam format JSON dan menampilkannya di aplikasi sehingga dapat dilihat oleh pengguna.

## 📄 Dokumentasi API 📄

### Authentication
| **Method** |                **Path**                 |                     **Detail**                     |  **Login Required**  |      **Privilege Owner**      |
|:----------:|:----------------------------------------|----------------------------------------------------|:--------------------:|:-----------------------------:|
| POST       | /v1/signup/                             | Mendaftar user                                     | ❌                    | -                             |
| POST       | /v1/login/                              | Login user                                         | ❌                    | -                             |
| POST       | /v1/logout/                             | Logout user                                        | ✅                    | `pengulas` `pemilik_restoran` |
| GET        | /v1/profile/{username}/                 | Profile user                                       | ❌                    | -                             |
| POST       | /v1/profile/{username}/                 | Update user                                        | ✅                    | `pengulas` `pemilik_restoran` |

### Makanan

| **Method** |                **Path**                 |                     **Detail**                     |  **Login Required**  |      **Privilege Owner**      |
|:----------:|:----------------------------------------|:---------------------------------------------------|:--------------------:|:-----------------------------:|
| GET        | /v1/makanan/                            | Menampilkan seluruh makanan                        | ❌                    | -                             |
| GET        | /v1/makanan/{id_makanan}/               | Menampilkan makanan berdasarkan id                 | ❌                    | -                             |
| PUT        | /v1/makanan/{id_makanan}/               | Update makanan                                     | ✅                    | `pemilik_restoran`            |
| DELETE     | /v1/makanan/{id_makanan}/               | Delete makanan                                     | ✅                    | `pemilik_restoran`            |
| GET        | /v1/restoran/{id_restoran}/makanan/     | Menampilkan makanan berdasarkan restoran           | ❌                    | -                             |
| POST       | /v1/restoran/{id_restoran}/makanan/     | Menambahkan makanan ke sebuah restoran             | ✅                    | `pemilik_restoran`            |

### Minuman

| **Method** |                **Path**                 |                     **Detail**                     |  **Login Required**  |      **Privilege Owner**      |
|:----------:|:----------------------------------------|----------------------------------------------------|:--------------------:|:-----------------------------:|
| GET        | /v1/minuman/                            | Menampilkan seluruh minuman                        | ❌                    | -                             |
| GET        | /v1/minuman/{id_minuman}/               | Menampilkan minuman berdasarkan id                 | ❌                    | -                             |
| PUT        | /v1/minuman/{id_minuman}/               | Update minuman                                     | ✅                    | `pemilik_restoran`            |
| DELETE     | /v1/minuman/{id_minuman}/               | Delete minuman                                     | ✅                    | `pemilik_restoran`            |
| GET        | /v1/restoran/{id_restoran}/minuman/     | Menampilkan minuman berdasarkan restoran           | ❌                    | -                             |
| POST       | /v1/restoran/{id_restoran}/minuman/     | Menambahkan minuman ke sebuah restoran             | ✅                    | `pemilik_restoran`            |

### Restoran
| **Method** |                **Path**                 |                     **Detail**                     |  **Login Required**  |      **Privilege Owner**      |
|:----------:|:----------------------------------------|----------------------------------------------------|:--------------------:|:-----------------------------:|
| GET        | /v1/restoran/                           | Menampilkan seluruh restoran                       | ❌                    | -                             |
| POST       | /v1/restoran/                           | Menambahkan restoran                               | ✅                    | `pemilik_restoran`            |
| GET        | /v1/restoran/{username}/                | Menampilkan restoran berdasarkan user              | ❌                    | -                             |
| GET        | /v1/restoran/{id_restoran}/             | Menampilkan restoran berdasarkan id                | ❌                    | -                             |
| PUT        | /v1/restoran/{id_restoran}/             | Update restoran                                    | ✅                    | `pemilik_restoran`            |
| DELETE     | /v1/restoran/{id_restoran}/             | Delete restoran                                    | ✅                    | `pemilik_restoran`            |

### Ulasan dan Rating
| **Method** |                **Path**                                           |                     **Detail**                     |  **Login Required**  |      **Privilege Owner**      |
|:----------:|:------------------------------------------------------------------|----------------------------------------------------|:--------------------:|:-----------------------------:|
| GET        | /v1/ulasan/{username}/                                            | Menampilkan ulasan berdasarkan user                | ❌                    | -                             |
| GET        | /v1/restoran/{id_restoran}/ulasan/                                | Menampilkan ulasan berdasarkan restoran            | ❌                    | -                             |
| POST       | /v1/restoran/{id_restoran}/ulasan/                                | Menambahkan ulasan ke sebuah restoran              | ✅                    | `pengulas`                    |
| PUT        | /v1/ulasan/{id_ulasan}/                                           | Update ulasan                                      | ✅                    | `pengulas`                    |
| DELETE     | /v1/ulasan/{id_ulasan}/                                           | Delete ulasan                                      | ✅                    | `pengulas`                    |

### Forum Diskusi
| **Method** |                **Path**                                           |                     **Detail**                     |  **Login Required**  |      **Privilege Owner**      |
|:----------:|:------------------------------------------------------------------|----------------------------------------------------|:--------------------:|:-----------------------------:|
| GET        | /v1/restoran/{id_restoran}/forum/                                 | Menampilkan forum berdasarkan restoran             | ❌                    | -                             |
| POST       | /v1/restoran/{id_restoran}/forum/                                 | Menambahkan forum ke sebuah restoran               | ✅                    | `pengulas`                    |
| GET        | /v1/forum/{id_forum}/                                             | Menampilkan forum berdasarkan id                   | ❌                    | -                             |
| PUT        | /v1/forum/{id_forum}/                                             | Update forum                                       | ✅                    | `pengulas`                    |
| DELETE     | /v1/forum/{id_forum}/                                             | Delete forum                                       | ✅                    | `pengulas`                    |
| GET        | /v1/forum/{id_forum}/balasan/                                     | Menampilkan balasan di sebuah forum                | ❌                    | -                             |
| POST       | /v1/forum/{id_forum}/balasan/                                     | Menambahkan balasan ke sebuah forum                | ✅                    | `pengulas` `pemilik_restoran` |
| PUT        | /v1/balasan/{id_balasan}/                                         | Update balasan                                     | ✅                    | `pengulas` `pemilik_restoran` |
| DELETE     | /v1/balasan/{id_balasan}/                                         | Delete balasan                                     | ✅                    | `pengulas` `pemilik_restoran` |

### Favorit
| **Method** |                **Path**                 |                     **Detail**                     |  **Login Required**  |      **Privilege Owner**      |
|:----------:|:----------------------------------------|----------------------------------------------------|:--------------------:|:-----------------------------:|
| GET        | /v1/favorit/                            | Menampilkan seluruh favorit yang dimiliki user     | ✅                    | `pengulas` `pemilik_restoran` |
| GET        | /v1/favorit/{id_favorit}/               | Menampilkan favorit berdasarkan id                 | ✅                    | `pengulas` `pemilik_restoran` |
| PUT        | /v1/favorit/{id_favorit}/               | Update favorit                                     | ✅                    | `pengulas` `pemilik_restoran` |
| DELETE     | /v1/favorit/{id_favorit}/               | Delete favorit                                     | ✅                    | `pengulas` `pemilik_restoran` |
| POST       | /v1/makanan/{id_makanan}/favorit/       | Menambahkan makanan ke favorit                     | ✅                    | `pengulas` `pemilik_restoran` |
| POST       | /v1/minuman/{id_minuman}/favorit/       | Menambahkan minuman ke favorit                     | ✅                    | `pengulas` `pemilik_restoran` |
| POST       | /v1/restoran/{id_restoran}/favorit/     | Menambahkan restoran ke favorit                    | ✅                    | `pengulas` `pemilik_restoran` |
