# PENJELASAN SOAL SHIFT MODUL 1

## Anggota Kelompok

1. Aryasatya Alaauddin 5027231082
2. Diandra Naufal Abror 5027231004
3. Muhamad Rizq Taufan 5027231021

## NOMOR 1

Cipung dan abe ingin mendirikan sebuah toko bernama “SandBox”, sedangkan kamu adalah manajer penjualan yang ditunjuk oleh Cipung dan Abe untuk melakukan pelaporan penjualan dan strategi penjualan kedepannya yang akan dilakukan.

Setiap tahun Cipung dan Abe akan mengadakan rapat dengan kamu untuk mengetahui laporan dan strategi penjualan dari “SandBox”. Buatlah beberapa kesimpulan dari data penjualan “Sandbox.csv” untuk diberikan ke cipung dan abe 

a. Karena Cipung dan Abe baik hati, mereka ingin memberikan hadiah kepada customer yang telah belanja banyak. Tampilkan nama pembeli dengan total sales paling tinggi
b. Karena karena Cipung dan Abe ingin mengefisienkan penjualannya, mereka ingin merencanakan strategi penjualan untuk customer segment yang memiliki profit paling 	 
   kecil. Tampilkan customer segment yang memiliki profit paling kecil
c. Cipung dan Abe hanya akan membeli stok barang yang menghasilkan profit paling tinggi agar efisien. Tampilkan 3 category yang memiliki total profit paling tinggi 
d. Karena ada seseorang yang lapor kepada Cipung dan Abe bahwa pesanannya tidak kunjung sampai, maka mereka ingin mengecek apakah pesanan itu ada. Cari purchase date 
   dan amount (quantity) dari nama adriaens

## Solusi

Untuk menyelesaikan soal ini saya akan membuat sebuah shell script bash yang akan membaca file database Sandbox.csv dan menampilkan data-data yang diinginkan Cipung dan
Abe.

## A. Tampilkan nama pembeli dengan total sales paling tinggi

```

database="Sandbox.csv"

```
Pertama program akan membaca isi database sandbox.csv dan menyimpannya ke dalam variabel database.

```
sales_name=$(awk -F ',' '{gsub(/[^0-9.]/, "", $17); print $6 "," $17}' $database | sort -t ',' -k2,2gr | head -n 1)
echo "Nama pembeli dengan total sales paling tinggi: $sales_name"
```
Untuk mencari pembeli dengan total sales paling tinggi, pertama program akan mencari kolom nama pembeli (kolom ke 6) dan kolom sales (kolom ke 17).

```
awk -F ',' '{gsub(/[^0-9.]/, "", $17); print $6 "," $17}
```

Perintah awk -F ',' '{gsub(/[^0-9.]/, "", $17); print $6 "," $17} digunakan untuk memproses dan mencetak data dari file menggunakan awk, yang mana dilakukan dengan beberapa langkah. Pertama, dengan opsi -F ',', kita menentukan bahwa pemisah antar kolom adalah tanda koma (,). Kemudian, dalam setiap baris, kita menggunakan fungsi gsub(/[^0-9.]/, "", $17) untuk mengganti karakter-karakter yang bukan angka atau titik (.) pada kolom ke-17 dengan string kosong, sehingga hanya angka atau titik yang tersisa. Setelah itu, kita mencetak kolom ke-6 dan kolom ke-17 yang telah dimodifikasi tersebut, dipisahkan oleh koma.

```
| sort -t ',' -k2,2gr
```
Selanjutnya, keluaran dari perintah awk tersebut dialirkan ke perintah sort. Di sini, kita menggunakan opsi sort -t untuk menentukan bahwa koma (,) adalah pemisah antara kolom, dan opsi -k untuk mengurutkan berdasarkan kolom kedua (nilai penjualan) dari yang tertinggi ke terendah (secara menurun). Ini berarti hasilnya akan diurutkan berdasarkan nilai penjualan, dengan yang tertinggi terlebih dahulu.
```
| head -n 1)
```

Pada langkah ini, hasil keluaran dari perintah sebelumnya yang telah diurutkan (dengan menggunakan perintah sort) akan ditangkap. Perintah head -n 1 digunakan untuk mengambil satu baris pertama dari keluaran tersebut. Jadi, kita hanya akan mendapatkan satu baris pertama dari hasil pengurutan sebelumnya, yang dalam konteks ini merupakan data penjualan tertinggi.

```
profit_name=$(awk -F ',' '{print $7, $20}' $database | sort -t ' ' -k2,2n | head -n 1)
echo "Customer segment yang memiliki profit paling kecil: $profit_name"
```
Pertama, kita menggunakan perintah awk untuk memproses file database. Dalam perintah ini, kita menggunakan opsi -F ',' untuk mengatur bahwa koma (,) adalah pemisah antar kolom dalam setiap baris. Kemudian, kita menggunakan perintah print untuk mencetak kolom ke-7 dan kolom ke-20 dari setiap baris. Kolom ke-7 mungkin berisi informasi terkait dengan jumlah penjualan atau pendapatan, sedangkan kolom ke-20 mungkin berisi informasi terkait dengan profit yang dihasilkan.

Selanjutnya, hasil dari perintah awk akan dialirkan ke perintah sort. Di sini, kita menggunakan opsi -t ' ' untuk menetapkan bahwa spasi (' ') adalah pemisah antara kolom. Lalu, opsi -k2,2n digunakan untuk mengurutkan data berdasarkan kolom kedua (kolom profit) secara numerik (n untuk numerik) dari yang terkecil ke terbesar.

Terakhir, hasil pengurutan tersebut akan disalurkan ke perintah head -n 1 untuk mengambil satu baris pertama dari hasil tersebut. Dengan demikian, variabel profit_name akan menyimpan informasi terkait dengan profit tertinggi yang ditemukan dalam database.

```
category_profit=$(awk -F ',' 'NR > 1 {profit[$14] += $20} END {for (i in profit) print i, profit[i]}' $database | sort -t ' ' -k2,2nr | head -n 3)
echo "3 Category yang memiliki total profit paling tinggi: $category_profit"
```
Pertama, kita menggunakan perintah awk untuk memproses file database. Dalam perintah ini, kita menggunakan opsi -F ',' untuk mengatur bahwa koma (,) adalah pemisah antar kolom dalam setiap baris. Ekspresi NR > 1 digunakan untuk memastikan bahwa kita mulai membaca data dari baris kedua (lewat baris header). Selanjutnya, kita menggunakan array profit[$14] += $20 untuk mengumpulkan total profit untuk setiap kategori. Di sini, $14 mungkin mengandung informasi terkait dengan kategori produk atau layanan, dan $20 mungkin mengandung informasi terkait dengan profit yang dihasilkan.

Setelah semua data diproses, kita menggunakan blok END untuk mengeksekusi perintah di dalamnya setelah selesai membaca semua baris dari file. Di dalam blok END, kita menggunakan loop for untuk mencetak kategori dan total profit untuk setiap kategori.

Selanjutnya, hasil dari perintah awk akan dialirkan ke perintah sort. Di sini, kita menggunakan opsi -t ' ' untuk menetapkan bahwa spasi (' ') adalah pemisah antara kolom. Lalu, opsi -k2,2nr digunakan untuk mengurutkan data berdasarkan kolom kedua (total profit) secara numerik (n untuk numerik) dari yang tertinggi ke terendah (r untuk reverse).

Terakhir, hasil pengurutan tersebut akan disalurkan ke perintah head -n 3 untuk mengambil tiga baris pertama dari hasil tersebut. Dengan demikian, variabel category_profit akan menyimpan informasi terkait dengan tiga kategori dengan profit tertinggi yang ditemukan dalam database.
```
adriaens=$(awk -F ',' '$6 ~ /Adriaens/ {print $2, $18}' $database)
echo "Purchase date dan amount (quantity) dari nama Adriaens: $adriaens"

```
Perintah di atas menggunakan perintah awk untuk memproses file database dan mencari entri yang terkait dengan penjual yang memiliki nama "Adriaens" pada kolom ke-6. Pertama-tama, kita menggunakan opsi -F ',' untuk menetapkan bahwa koma (,) adalah pemisah antar kolom dalam setiap baris. Kemudian, dengan menggunakan $6 ~ /Adriaens/, kita menyaring baris-baris di mana kolom ke-6 (mungkin berisi nama penjual) sesuai dengan pola "Adriaens". Setelah menyaring baris-baris yang sesuai, kita menggunakan print $2, $18 untuk mencetak kolom ke-2 (mungkin berisi informasi terkait dengan produk atau layanan) dan kolom ke-18 (mungkin berisi informasi terkait dengan jumlah penjualan atau profit).

## NOMOR 2

  Oppie merupakan seorang peneliti bom atom, ia ingin merekrut banyak peneliti lain untuk mengerjakan proyek bom atom nya, 
Oppie memiliki racikan bom atom rahasia yang hanya bisa diakses penelitinya yang akan diidentifikasi sebagai user, 
Oppie juga memiliki admin yang bertugas untuk memanajemen peneliti,  bantulah oppie untuk membuat program yang akan memudahkan 
tugasnya 

a. Buatlah 2 program yaitu login.sh dan register.sh

b. Setiap admin maupun user harus melakukan register terlebih dahulu menggunakan email, username, 
   pertanyaan keamanan dan jawaban, dan password

c. Username yang dibuat bebas, namun email bersifat unique. setiap email yang mengandung kata admin akan 
   dikategorikan menjadi admin 

d. Karena resep bom atom ini sangat rahasia Oppie ingin password nya memuat keamanan tingkat tinggi
   - Password tersebut harus di encrypt menggunakan base64
   - Password yang dibuat harus lebih dari 8 karakter
   - Harus terdapat paling sedikit 1 huruf kapital dan 1 huruf kecil
   - Harus terdapat paling sedikit 1 angka

e. Karena Oppie akan memiliki banyak peneliti dan admin ia berniat untuk menyimpan seluruh data register yang ia 
   lakukan ke dalam folder users file users.txt. Di dalam file tersebut, terdapat catatan seluruh email, username, 
   pertanyaan keamanan dan jawaban, dan password hash yang telah ia buat.

f. Setelah melakukan register, program harus bisa melakukan login. Login hanya perlu dilakukan menggunakan email dan password.

g. Karena peneliti yang di rekrut oleh Oppie banyak yang sudah tua dan pelupa maka Oppie ingin ketika login akan ada 
   pilihan lupa password dan akan keluar pertanyaan keamanan dan ketika dijawab dengan benar bisa memunculkan password

h. Setelah user melakukan login akan keluar pesan sukses, namun setelah seorang admin melakukan login Oppie ingin 
   agar admin bisa menambah, mengedit (username, pertanyaan keamanan dan jawaban, dan password), dan menghapus user 
   untuk memudahkan kerjanya sebagai admin. 

i. Ketika admin ingin melakukan edit atau hapus user, maka akan keluar input email untuk identifikasi user yang akan di 
   hapus atau di edit

j. Oppie ingin programnya tercatat dengan baik, maka buatlah agar program bisa mencatat seluruh log ke dalam folder users 
   file auth.log, baik login ataupun register.
   - Format: [date] [type] [message]
   - Type: REGISTER SUCCESS, REGISTER FAILED, LOGIN SUCCESS, LOGIN FAILED
   - Ex:
     [23/09/17 13:18:02] [REGISTER SUCCESS] user [username] registered successfully
     [23/09/17 13:22:41] [LOGIN FAILED] ERROR Failed login attempt on user with email [email]

## Solusi

Untuk menyelesaikan soal ini, saya akan membuat 2 file code bash yang bernama login.sh dan register.sh.

## 1. register.sh

Soal meminta untuk membuat sebuah code bash bernama register.sh yang bertujuan untuk menerima input 
data akun peneliti dan meletakkannya ke dalam file users.txt. Oleh karena itu pertama-tama program harus 
menerima input-input berikut:
1. Email
2. Username
3. Pertanyaan keamanan
4. Jawaban dari pertanyaan keamanan
5. Password

Berikut adalah cara kerja code register.sh yang kami buat

1. Menerima input email

Untuk input email, program hanya menerima input string yang sesuai dengan format
email pada umumnya (contoh@gmail.com). 

```
while true; do

  echo "Enter your email:"
  read email

  if [[ $email =~ ^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9]+\.[a-zA-Z]+$ ]]; then

    if grep -q "$email" users.txt; then

      echo "Email already exists. Try again."

    else

      break

    fi

  else
    
    echo "Invalid email address. Try again."

  fi

done
```

Jika user memberi input email yang sudah ada di database users.txt atau jika program 
memberikan input email dengan format yang tidak valid, maka program akan menanyakan kembali input hingga
user memberikan input yang benar.

2. Menerima input username

Untuk input username saya program supaya username yang diinput bersifat unique untuk mengantisipasi konflik data

```
while true; do

  echo "Enter your username:"
  read username

  if grep -q "^$username:" users.txt; then

    echo "Username already exists. Try again."

  else

    break

  fi

done
```

Program akan terus menanyakan input username hingga user memberikan username unique

3. input pertanyaan keamanan beserta jawabannya

```
echo "Enter a security question:"
read secquest

echo "Enter the answer to your security question:"
read answer
```

4. Input password

Karena soal memberikan beberapa kriteria untuk password yang bisa diinput oleh user maka saya membuat program untuk menanyakan
kembali password jika tidak memiliki minimal 1 huruf uppercase, lowercase, digit, dan symbol
( "$password" =~ [[:lower:]] && "$password" =~ [[:upper:]] && "$password" =~ [[:digit:]] && "$password" =~ [[:punct:]] )

dan juga mengandung setidaknya 8 karakter
( ${#password} -ge 8 )

```

while true; do
    echo "Enter a password (8 characters minimum, at least 1 uppercase letter, at least 1 lowercase letter, at least 1 digit, at least 1 symbol, and not the same as your username, birthdate, or email adress)"
    read -s password

    if [[ ${#password} -ge 8 && "$password" =~ [[:lower:]] && "$password" =~ [[:upper:]] && "$password" =~ [[:digit:]] && "$password" =~ [[:punct:]] ]]; then
      break
    else
      echo "Password is too weak. Try again."
    fi
done

password=$(echo -n "$password" | base64)
```

Program akan menanyakan kembali input password jika belum memenuhi semua kriteria hingga semuanya sudah terpenuhi.
Kemudian program akan mengenkripsi password menggunakan base 64.
( password=$(echo -n "$password" | base64) )

5. Menyimpan input di users.txt

Setelah semua input sudah diberikan dan diletakkan di variabelnya masing-masing, program akan menyimpan semua data tersebut
di users.txt dalam satu line dan dipisahkan oleh titik dua (:).

```
echo "$email:$username:$secquest:$answer:$password" >> users.txt
```

Kemudian program akan membuat laporan keberhasilan registrasi user dan menyimpannya dalam file auth.log

```
echo "$(date +'%d/%m/%y %H:%M:%S') REGISTER SUCCESS User $username registered successfully" >> auth.log
echo "User Registered Successfully!"
```

Program berakhir.

## 2. login.sh

Selain opsi untuk login, soal juga meminta agar program memiliki opsi untuk password recovery jika user melupakan password
mereka. Oleh karena itu, ini adalah tampilan menu awal dari login.sh

```
echo "Welcome to the login system"
echo "1. Login"
echo "2. Forgot Password"

read command
```
Kemudian program akan menerima input angka yang sesuai dengan command yang diinginkan.

## A. Login

Berikut adalah jalan kerja program jika user memilih opsi 1. Login.

1. Input Email dan password

Untuk login, pertama user harus memberikan input email untuk akun yang ingin mereka gunakan

```
echo "Enter your email:"
read inp_email
email_found=false

mapfile -t lines < users.txt
```
Setelah itu program akan membaca isi dari users.txt dan meletakkannya ke dalam variabel lines dalam bentuk array.
Setiap array akan berisi 1 line dari users.txt.

```
for line in "${lines[@]}"; do
     
    IFS=':' read -r db_email db_username db_question db_answer db_password <<< "$line"
```
Kemudian program akan menjalankan loop untuk membaca setiap line users.txt yang berupa data. Kemudian program
memisahkan setiap baris dari file users.txt berdasarkan karakter titik dua (:) dan menetapkan bagian-bagiannya 
ke variabel yang sesuai seperti db_email, db_username, dst.

```
    if [[ $inp_email == $db_email ]]; then

      email_found=true
      echo "Enter your password:"
      read -s inp_password
      decrypted_password=$(echo "$db_password" | base64 -d)
```
Kemudian program akan memeriksa apakah email yang diinput user sudah teregistrasi. Kemudian program akan menanyakan
password yang sesuai dengan email yang diinput.

```   
      if [[ $inp_password == $decrypted_password ]]; then

        echo "$(date +'%d/%m/%y %H:%M:%S') LOGIN SUCCESS User with email $inp_email logged in successfully" >> auth.log
        echo "Login successful!"
        break
```
Kemudian program akan membandingkan password yang diinput dengan password yang ada di database. Jika password
sesuai dengan email yang diinput, maka program akan membuat laporan bahwa login berhasil dan memasukkannya ke
file auth.log.

```
      else
        echo "$(date +'%d/%m/%y %H:%M:%S') LOGIN FAILED Failed login attempt on user with email $inp_email" >> auth.log
        echo "Wrong password. Login Failed."
        exit 1

      fi

    fi

  done
```
Jika user menginput password yang salah, maka program akan membuat laporan bahwa login gagal dan mencatatnya di auth.log.

```

  if [[ $email_found == false ]]; then
      echo "Email not registered."
      exit 1
  fi
```

dan terakhir, jika email yang diinputkan user tidak ada di database (tidak teregistrasi) maka program akan berhenti.

## A.1. Menu Admin

Jika email yang diinput user memiliki kata "admin", maka user tersebut teregistrasi sebagai admin dan memiliki 
akses khusus. 

```
if [[ $inp_email =~ .*"admin".* ]]; then

    while true; do
  
      echo "Admin Menu"
      echo "1. Add User"
      echo "2. Edit User"
      echo "3. Delete User"
      echo "4. Logout"
      read command2
```
Ini adalah tampilan menu admin. Admin memiliki akses untuk menambah user, mengedit data user, dan menghapus user.
Program akan meminta user admin untuk memberikan input angka yang sesuai dengan command yang mereka inginkan.

```   
      if [[ $command2 -eq 1 ]]; then
      
        echo "Add a new user."

        while true; do

          echo "Enter your email:"
          read email

          if [[ $email =~ ^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9]+\.[a-zA-Z]+$ ]]; then

            if grep -q "$email" users.txt; then

              echo "Email already exists. Try again."

            else

              break

            fi

          else
    
            echo "Invalid email address. Try again."

          fi

        done

        while true; do

          echo "Enter your username:"
          read username

          if grep -q "^$username:" users.txt; then

            echo "Username already exists. Try again."

          else

            break

          fi

        done

        echo "Enter a security question:"
        read secquest

        echo "Enter the answer to your security question:"
        read answer

        while true; do

          echo "Enter a password (8 characters minimum, at least 1 uppercase letter, at least 1 lowercase letter, at least 1 digit, at least 1 symbol, and not the same as your username, birthdate, or email adress)"
          read -s password

          if [[ ${#password} -ge 8 && "$password" =~ [[:lower:]] && "$password" =~ [[:upper:]] && "$password" =~ [[:digit:]] && "$password" =~ [[:punct:]] ]]; then
          
            break

          else

            echo "Password is too weak. Try again."

          fi

        done

        password=$(echo -n "$password" | base64)

        echo "$email:$username:$secquest:$answer:$password" >> users.txt
        echo "$(date +'%d/%m/%y %H:%M:%S') REGISTER SUCCESS User $username registered successfully" >> auth.log
        echo "User Registered Successfully!"
```
Jika user memilih command pertama (Add User). Maka program akan berjalan seperti program register.sh. Yaitu menerima input
data email, username, pertanyaan keamanan, jawaban, dan password. Dilanjutkan dengan meletakkan semua data tersebut ke
users.txt dan membuat laporan yang dicatat ke auth.log. Kemudian program akan mengembalikan user ke menu admin.

```
      
      elif [[ $command2 -eq 2 ]]; then
      
        echo "Edit an existing user"

        echo "Enter the email of the user you want to edit:"
        read ed_email
```
Jika user memilih opsi 2 (Edit User), pertama program akan menanyakan email dari user yang ingin diedit.

```
        mapfile -t users_array < users.txt

        for line in "${users_array[@]}"; do
            
          IFS=':' read -r db_email db_username db_question db_answer db_password <<< "$line"
```
Program akan membaca users.txt dan meletakkan isinya ke dalam variabel users_array

```
          if [[ $ed_email == $db_email ]]; then
```
Program memeriksa apakah email yang diinput ada di database.
```

            echo "Do you want to change your email address? [y/n]"
            read change_email

            if [[ $change_email == "y" ]]; then

              while true; do

                echo "Enter your email:"
                read new_email

                if [[ $new_email =~ ^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9]+\.[a-zA-Z]+$ ]]; then

                  if grep -q "$new_email" users.txt; then

                    echo "Email already exists. Try again."

                  else

                    break

                  fi

                else

                  echo "Invalid email address. Try again."

                fi

              done

           fi
```
Program menanyakan user apakah dia ingin mengubah emailnya atau tidak. Jika iya, maka program akan meminta
input email yang sesuai dengan format email pada umumnya (contoh@gmail.com) dan akan meminta input kembali
jika input belum sesuai.

```
            while true; do
            
              echo "Enter new username:"
              read new_username

              if grep -q "^$new_username:" users.txt; then

                echo "Username already exists. Try again."

              else

                break

              fi

            done

            echo "Enter a new security question:"
            read new_secquest

            echo "Enter the new answer to your security question:"
            read new_answer

            while true; do

              echo "Enter a new password (8 characters minimum, at least 1 uppercase letter, at least 1 lowercase letter, at least 1 digit, at least 1 symbol, and not the same as your username, birthdate, or email address)"

              read -s new_password

              if [[ ${#new_password} -ge 8 && "$new_password" =~ [[:lower:]] && "$new_password" =~ [[:upper:]] && "$new_password" =~ [[:digit:]] ]]; then
                
                break

              else
              
                echo "Password is too weak. Try again."

              fi

            done

            new_password=$(echo -n "$new_password" | base64)
```
Berikutnya program akan menanyakan untuk menginput data-data baru untuk username, pertanyaan keamanan, jawaban, dan password.
```

            if [[ $change_email == "y" ]]; then

              sed -i "/$ed_email/c\\$new_email:$new_username:$new_secquest:$new_answer:$new_password" users.txt
              echo "$(date +'%d/%m/%y %H:%M:%S') USER UPDATE SUCCESS User data with email $ed_email updated successfully." >> auth.log
              echo "User data updated successfully."

            else
```
Jika tadi user memilih untuk mengubah emailnya, maka program akan menukar seluruh line data yang berisi data lama dengan line data yang
berisi data baru. Setelah itu program akan melaporkan bahwa edit data user sukses dan mencatatnya di auth.log.

```

              sed -i "/$ed_email/c\\$ed_email:$new_username:$new_secquest:$new_answer:$new_password" users.txt
              echo "$(date +'%d/%m/%y %H:%M:%S') USER UPDATE SUCCESS User data with email $ed_email updated successfully." >> auth.log
              echo "User data updated successfully."

            fi
```
Jika tadi user memilih untuk tidak mengubah emailnya, maka program akan menukar line data yang berisi data lama dengan line data yang
berisi data baru kecuali emailnya. Setelah itu program akan melaporkan bahwa edit data user sukses dan mencatatnya di auth.log.

```

          else

            echo "Email not registered."

          fi

        done
```
Jika email yang diinput untuk memilih data user yang ingin diedit ternyata tidak ada di database (tidak teregistrasi),
maka program akan mengembalikan user ke menu admin.

Jika user memilih command 3 (Delete User). Maka pertama program akan menanyakan input email untuk memilih
akun user mana yang ingin dihapus.

```
      
      elif [[ $command2 -eq 3 ]]; then
      
        echo "Delete an existing user"
        echo "Enter the email of the user you want to delete:"
        read del_email

        mapfile -t lines < users.txt

        email_found=false

        for line in "${lines[@]}"; do
          
          IFS=':' read -r db_email db__username db__question db__answer db__password <<< "$line"
```
Kemudian program akan membaca users.txt dan meletakkan isinya ke dalam variabel lines.

```
          if [[ $del_email == $db_email ]]; then

            email_found=true
```
Program akan memeriksa apakah file yang diinput ada di database.
```
            
            if [[ $del_email =~ $inp_email ]]; then

              echo "You can't delete this user. You are logged in as this user."

              break

            elif [[ $del_email =~ .*"admin".* ]]; then

              echo "You can't delete this user. This is an admin account."

              break

            fi
```
Program akan menggagalkan perintah delete user jika user menginput email user admin atau user
yang sedang digunakan.

```
            
            sed -i "/$del_email/d" users.txt
            echo "$(date +'%d/%m/%y %H:%M:%S') USER DELETE SUCCESS User with email $del_email deleted successfully." >> auth.log
            echo "User deleted successfully."
           
            break

          fi

        done
```
Kemudian program akan menghapus seluruh line data yang bersesuaian dengan email yang diinput. Program kemudian
akan membuat laporan bahwa user telah dihapus dan mencatatnya di auth.log. Kemudian program akan mengembalikan
user ke menu admin

```

        if [[ $email_found == false ]]; then
          
          echo "Email not registered."

        fi
```
Jika email yang diinput tidak ditemukan di database (tidak teregistrasi), maka program akan mengembalikan
user ke menu admin.

```
      
      elif [[ $command2 -eq 4 ]]; then
      
        exit 1
```
Jika user memilih command 4 (Logout), maka program akan berhenti sepenuhnya. Jika user memberikan input
selain angka 1 - 4 maka program juga akan berhenti sepenuhnya.

```
      else 
      
        echo "Command not found."
        exit 1
      
      fi

    done  
    
  else

    echo "You don't have admin privileges. Welcome!"
    exit 1

  fi
```
Jika user login dengan email yang tidak mengandung kata "admin" maka user telah login
sebagai user biasa dan tidak memiliki akses untuk menjalankan perintah-perintah admin.

## B. Forgot Password

Jika pada menu utama program login.sh user memilih command 2 (Forgot Password), program
akan membantu user untuk mengembalikan password mereka.

Pertama program akan meminta input email untuk mencari akun user mana yang ingin ditampilkan
passwordnya.

```
elif [[ $command -eq 2 ]]; then

  echo "Forgot your password?"
  echo "Enter your email:"
  read inp_email

  mapfile -t lines < users.txt

  email_found=false

  for line in "${lines[@]}"; do
     
    IFS=':' read -r db_email db_username db_question db_answer db_password <<< "$line"
```
Setelah itu, program akan membaca users.txt dan meletakkan isinya ke dalam variabel lines.
```
    
    if [[ $inp_email == $db_email ]]; then
      email_found=true
      
      echo "Security question: $db_question"
      echo "Enter your answer: "
      read inp_answer
```
Jika email yang diinput ditemukan di database maka program akan melanjutkan dengan menampilkan pertanyaan
keamanan yang dimiliki akun dari email tersebut. Kemudian program akan meminta input jawaban dari user.

```

      if [[ $inp_answer == $db_answer ]]; then

        decrypted_password=$(echo "$db_password" | base64 -d)
        echo "Your password is: $decrypted_password"

        echo "Do you want to change your password? [y/n]"
        read change_password
```
Jika user menjawab benar, maka program akan mendekripsi dan menampilkan password mereka. Setelah itu program akan
menanyakan apakah user ingin mengubah passwordnya.
```

        if [[ $change_password == "y" ]]; then
          while true; do
            echo "Enter a new password (8 characters minimum, at least 1 uppercase letter, at least 1 lowercase letter, at least 1 digit, at least 1 symbol, and not the same as your username, birthdate, or email address)"
            read -s new_password

            if [[ ${#new_password} -ge 8 && "$new_password" =~ [[:lower:]] && "$new_password" =~ [[:upper:]] && "$new_password" =~ [[:digit:]] && "$new_password" =~ [[:punct:]] ]]; then
              break
            else
              echo "Password is too weak. Try again."
            fi
            
          done

          new_password=$(echo -n "$new_password" | base64)
          sed -i "/$inp_email/c\\$inp_email:$db_username:$db_question:$db_answer:$new_password" users.txt
          echo "$(date +'%d/%m/%y %H:%M:%S') PASSWORD UPDATE SUCCESS User with email $inp_email updated password successfully" >> auth.log
          echo "Password updated successfully."

        fi
```
Jika user memilih untuk merubah password akunnya, maka program akan meminta input password baru yang harus sesuai kriteria 
password kuat yang telah disebutkan sebelumnya. Program akan terus meminta input hingga user memberikan password yang kuat.
Setelah itu, program akan membuat laporan bahwa user dengan email yang diinput telah merubah passwordnya dan mencatatnya
di auth.log.
```

        echo "$(date +'%d/%m/%y %H:%M:%S') PASSWORD RECOVERY SUCCESS User with email $inp_email recovered password successfully" >> auth.log
        break
```
Jika user tidak memilih untuk merubah passwordnya maka program akan melaporkan bahwa password recovery telah berhasil di lakukan
dan akan mencatatnya di auth.log.
```

      else

        echo "Wrong answer. Password recovery failed."
        echo "$(date +'%d/%m/%y %H:%M:%S') PASSWORD RECOVERY FAILED Failed password recovery attempt on user with email $inp_email" >> auth.log
        exit 1

      fi

    fi

  done

```
Jika jawaban yang diinput user salah, maka program akan melaporkan bahwa password recovery tidak berhasil dan mencatatnya di
auth.log.

```

  if [[ $email_found == false ]]; then
      echo "Email not registered."
      exit 1
  fi

else

  echo "Command not found."
  exit 1

fi
```
Jika user menginput email yang tidak teregister maka program akan berhenti seluruhnya.
Jika user menginput angka untuk command selain 1 dan 2 maka program akan berhenti seluruhnya.

Program selesai.

## NOMOR 3

  Alyss adalah seorang gamer yang sangat menyukai bermain game Genshin Impact. Karena hobinya, dia ingin mengoleksi foto-foto karakter Genshin Impact. Suatu saat Yanuar memberikannya sebuah Link yang berisi koleksi kumpulan foto karakter dan sebuah clue yang mengarah ke penemuan gambar rahasia. Ternyata setiap nama file telah dienkripsi dengan menggunakan hexadecimal. Karena penasaran dengan apa yang dikatakan Yanuar, Alyss tidak menyerah dan mencoba untuk mengembalikan nama file tersebut kembali seperti semula.
Alyss membuat script bernama awal.sh, untuk download file yang diberikan oleh Yanuar dan unzip terhadap file yang telah diunduh dan decode setiap nama file yang terenkripsi dengan hex . Karena pada file list_character.csv terdapat data lengkap karakter, Alyss ingin merename setiap file berdasarkan file tersebut. Agar semakin rapi, Alyss mengumpulkan setiap file ke dalam folder berdasarkan region tiap karakter
    
    Format: Region - Nama - Elemen - Senjata.jpg
Karena tidak mengetahui jumlah pengguna dari tiap senjata yang ada di folder "genshin_character".Alyss berniat untuk menghitung serta menampilkan jumlah pengguna untuk setiap senjata yang ada
    
    Format: [Nama Senjata] : [jumlah]
	  Untuk menghemat penyimpanan. Alyss menghapus file - file yang tidak ia gunakan, yaitu genshin_character.zip, list_character.csv, dan genshin.zip

Namun sampai titik ini Alyss masih belum menemukan clue dari the secret picture yang disinggung oleh Yanuar. Dia berpikir keras untuk menemukan pesan tersembunyi tersebut. Alyss membuat script baru bernama search.sh untuk melakukan pengecekan terhadap setiap file tiap 1 detik. Pengecekan dilakukan dengan cara meng-ekstrak sebuah value dari setiap gambar dengan menggunakan command steghide. Dalam setiap gambar tersebut, terdapat sebuah file txt yang berisi string. Alyss kemudian mulai melakukan dekripsi dengan hex pada tiap file txt dan mendapatkan sebuah url. Setelah mendapatkan url yang ia cari, Alyss akan langsung menghentikan program search.sh serta mendownload file berdasarkan url yang didapatkan.
Dalam prosesnya, setiap kali Alyss melakukan ekstraksi dan ternyata hasil ekstraksi bukan yang ia inginkan, maka ia akan langsung menghapus file txt tersebut. Namun, jika itu merupakan file txt yang dicari, maka ia akan menyimpan hasil dekripsi-nya bukan hasil ekstraksi. Selain itu juga, Alyss melakukan pencatatan log pada file image.log untuk setiap pengecekan gambar
    
    Format: [date] [type] [image_path]
    Ex: 
    [24/03/20 17:18:19] [NOT FOUND] [image_path]
    [24/03/20 17:18:20] [FOUND] [image_path]
    Hasil akhir:
    genshin_character
    search.sh
    awal.sh
    image.log
    [filename].txt
    [image].jpg

##  Solusi

## awal.sh
``
#!/bin/bash
``
Ini adalah shebang line yang menunjukkan bahwa skrip ini akan dijalankan menggunakan Bash shell.
```
wget -O genshin.zip 'https://docs.google.com/uc?export=download&id=1oGHdTf4_76_RacfmQIV4i7os4sGwa9vN'
```
Baris ini menggunakan perintah wget untuk mengunduh file dari URL yang diberikan dan menyimpannya dengan nama "genshin.zip".
```
unzip genshin.zip
```
Ini adalah perintah untuk mengekstrak isi dari file "genshin.zip" yang baru saja diunduh.
```
unzip -o genshin_character.zip
```
Ini mengekstrak isi dari file "genshin_character.zip" yang ada di dalam file "genshin.zip".
```
declare -A weapon_count
```
Ini mendeklarasikan sebuah array asosiatif yang akan digunakan untuk menghitung jumlah senjata yang ada.
```
for file in /home/ziqi/pts1/genshin_character/*.jpg; do ... done
```
Ini adalah loop yang berjalan melalui setiap file dengan ekstensi ".jpg" di dalam folder "/home/ziqi/pts1/genshin_character/".

Di dalam loop, dilakukan ekstraksi nama file, region, elemen, dan senjata dari setiap file menggunakan perintah awk yang mendapatkan data dari file "list_character.csv". Kemudian file dipindahkan ke folder yang sesuai berdasarkan region dan direname sesuai dengan informasi yang diperoleh.
```
weapon_types=(Catalyst Bow Polearm Sword Claymore)
```
Ini mendefinisikan sebuah array dengan jenis senjata yang akan dihitung.
```
for weapon_type in "${weapon_types[@]}"; do ... done
```
Ini adalah loop yang berjalan melalui setiap jenis senjata yang telah didefinisikan sebelumnya.

Di dalam loop, dilakukan pencarian jumlah setiap jenis senjata menggunakan perintah awk yang mencocokkan jenis senjata dengan data yang ada di file "list_character.csv".
```
rm -f genshin.zip genshin_character.zip list_character.csv
```
Ini menghapus file "genshin.zip", "genshin_character.zip", dan "list_character.csv" setelah selesai melakukan operasi yang diperlukan.

KODE FULL:
```
#!/bin/bash

wget -O genshin.zip 'https://docs.google.com/uc?export=download&id=1oGHdTf4_76_RacfmQIV4i7os4sGwa9vN'
# Unzip file karakter
unzip genshin.zip
unzip -o genshin_character.zip 

declare -A weapon_count

for file in /home/ziqi/pts1/genshin_character/*.jpg; do
    decoded_name=$(basename "$file" | xxd -r -p)
    region=$(awk -F',' -v name="$decoded_name" '$1 == name {print $2}' /home/ziqi/pts1/list_character.csv)
    elemen=$(awk -F',' -v name="$decoded_name" '$1 == name {print $3}' /home/ziqi/pts1/list_character.csv)
    weapon=$(awk -F',' -v name="$decoded_name" '$1 == name {print $4}' /home/ziqi/pts1/list_character.csv)
    mkdir -p "/home/ziqi/pts1/genshin_character/$region"
    if [ -f "$file" ]; then
        mv "$file" "/home/ziqi/pts1/genshin_character/$region/$region-$decoded_name-$elemen-$weapon.jpg"
    else
        echo "File not found: $file"
    fi
    if [ -f "/home/ziqi/pts1/genshin_character/$region/$region-$decoded_name-$elemen-$weapon.jpg" ]; then
        cp "/home/ziqi/pts1/genshin_character/$region/$region-$decoded_name-$elemen-$weapon.jpg" "/home/ziqi/pts1/genshin_character/$region/"
    else
        echo "File not found: /home/ziqi/pts1/$region/$region-$decoded_name-$elemen-$weapon.jpg"
    fi
done

weapon_types=(Catalyst Bow Polearm Sword Claymore)

for weapon_type in "${weapon_types[@]}"; do
  count=$(awk -F',' '/'"$weapon_type"'/ { ++count } END { print count }' list_character.csv)
  echo "$weapon_type : $count"
done

# Hapus file yang tidak diperlukan
rm -f genshin.zip  genshin_character.zip list_character.csv
```


Kode ini pada dasarnya digunakan untuk mengelola dan mengatur ulang file-file dalam folder "genshin_character" berdasarkan informasi yang diperoleh dari file "list_character.csv", serta menghitung jumlah senjata yang ada dalam permainan Genshin Impact berdasarkan jenisnya.

## search.sh

Kode ini adalah sebuah skrip Bash yang melakukan beberapa tugas. Berikut adalah penjelasan langkah demi langkah:

```
#!/bin/bash
```
Ini adalah shebang line yang menunjukkan bahwa skrip ini akan dijalankan menggunakan Bash shell.
```
touch /home/ziqi/pts1/image.log
```
Membuat file kosong bernama "image.log" di direktori "/home/ziqi/pts1/".

```
process() { ... }
```
Ini adalah fungsi bash yang didefinisikan di dalam skrip. Fungsi ini bertujuan untuk melakukan pemrosesan pada file teks yang ada.

Di dalam fungsi `process`, dilakukan:
```
mkdir -p /home/ziqi/pts1/textfile
```
Membuat direktori "textfile" di "/home/ziqi/pts1/", jika belum ada.
```
mv /home/ziqi/pts1/*.txt /home/ziqi/pts1/textfile/
```
Memindahkan semua file dengan ekstensi ".txt" dari direktori utama ke direktori "textfile".
   - Loop
```
       for file in /home/ziqi/pts1/textfile/*.txt; do ... done
```
   - Setiap file di-decode dari base64 menggunakan
```
       base64 -d "$file" > secret.txt
```
   - Dilakukan pencarian URL dalam teks menggunakan ekspresi reguler.
   - Jika URL ditemukan, file dipindahkan ke "/home/ziqi/pts1/", dan log dibuat dengan status "FOUND".
   - Jika tidak, status "NOT FOUND" ditulis dalam log.
   - File teks asli dihapus setelah diproses.
```
sleep 1
```
Memberikan jeda 1 detik.

Loop utama 
```
for region in Mondstat Liyue Fontaine Inazuma Sumeru; do ... done
```
   - Setiap iterasi, variabel `region` diisi dengan salah satu nilai dalam daftar (Mondstat, Liyue, Fontaine, Inazuma, Sumeru).
   - Kemudian, sebuah loop
     ```
     for image in "/home/ziqi/pts1/genshin_character/$region"/*.jpg; do ... done
     ```
     dilakukan untuk setiap gambar JPG dalam direktori yang sesuai dengan variabel `region`.
   - Setiap gambar di-extract menggunakan steghide dengan menggunakan kata sandi `pass` yang saat ini kosong.
   - Setelah ekstraksi, fungsi `process` dipanggil untuk melakukan pemrosesan pada file tersebut.

```
secret_link=$(cat "secret.txt")
```
Isi dari file "secret.txt" (yang mungkin sudah berubah setelah pemrosesan di dalam fungsi `process`) disimpan dalam variabel `secret_link`.

```
wget -O gambar.jpg "$secret_link"
```
Dilakukan unduhan menggunakan `wget` dengan URL yang didapatkan dari file "secret.txt", dan disimpan dengan nama "gambar.jpg".

KODE FULL:
```
#!/bin/bash

touch /home/ziqi/pts1/image.log

process() { 
    mkdir -p /home/ziqi/pts1/textfile
    mv /home/ziqi/pts1/*.txt /home/ziqi/pts1/textfile/

    for file in /home/ziqi/pts1/textfile/*.txt; do
        base64 -d "$file" > secret.txt
        regex='(https?|ftp|file)://[-[:alnum:]\+&@#/%?=~_|!:,.;]*[-[:alnum:]\+&@#/%=~_|]'
        string=$(cat secret.txt)
        if [[ $string =~ $regex ]]; then
           mv secret.txt /home/ziqi/pts1
        echo "[$(date '+%Y/%M/%d %H:%M:%S')] [FOUND] [/home/ziqi/pts1/genshin_character/$file]" >> image.log
        break
    else
        echo "[$(date '+%Y/%M/%d %H:%M:%S')] [NOT FOUND] [/home/ziqi/pts1/genshin_character/$file]" >> image.log
    fi
    rm "$file"
done
    sleep 1
}

for region in Mondstat Liyue Fontaine Inazuma Sumeru; do
    pass=""
    for image in "/home/ziqi/pts1/genshin_character/$region"/*.jpg; do
        steghide extract -q -sf "$image" -p "$pass"
        process "$image"
    done
done

secret_link=$(cat "secret.txt")
wget -O gambar.jpg "$secret_link"
```

Dengan demikian, skrip ini bertujuan untuk mengekstrak pesan tersembunyi dari gambar JPEG dalam berbagai folder yang terkait dengan wilayah-wilayah dalam permainan Genshin Impact, kemudian mengunduh file dari URL yang ditemukan dalam teks tersembunyi tersebut.

## Nomor 4

Stitch sangat senang dengan PC di rumahnya. Suatu hari, PC nya secara tiba-tiba nge-freeze. Tentu saja, Stitch adalah seorang streamer yang harus setiap hari harus bermain game dan streaming. Akhirnya, dia membawa PC nya ke tukang servis untuk diperbaiki. Setelah selesai diperbaiki, ternyata biaya perbaikan sangat mahal sehingga dia harus menggunakan uang hasil tabungan nya untuk membayarnya. Menurut tukang servis,
masalahnya adalah pada CPU dan GPU yang overload karena gaming dan streaming sehingga mengakibatkan freeze pada PC nya. Agar masalah ini tidak terulang kembali, Stitch meminta kamu untuk membuat sebuah program monitoring resource yang tersedia pada komputer.

Buatlah program monitoring resource pada PC kalian. Cukup monitoring ram dan monitoring size suatu directory. Untuk ram gunakan command `free -m`. Untuk disk gunakan command `du -sh <target_path>`. Catat semua metrics yang didapatkan dari hasil `free -m`. Untuk hasil `du -sh <target_path>` catat size dari path directory tersebut. Untuk target_path yang akan dimonitor adalah /home/{user}/.

- Masukkan semua metrics ke dalam suatu file log bernama metrics_{YmdHms}.log. {YmdHms} adalah waktu disaat file script bash kalian dijalankan. Misal dijalankan pada 2024-03-20 15:00:00, maka file log 	yang akan tergenerate adalah metrics_20240320150000.log.
- Script untuk mencatat metrics diatas diharapkan dapat berjalan otomatis pada setiap menit.
- Kemudian, buat satu script untuk membuat agregasi file log ke satuan jam. Script agregasi akan memiliki info dari file-file yang tergenerate tiap menit. Dalam hasil file agregasi tersebut, terdapat 	nilai minimum, maximum, dan rata-rata dari tiap-tiap metrics. File agregasi akan ditrigger untuk dijalankan setiap jam secara otomatis. Berikut contoh nama file hasil agregasi metrics_agg_2024032015.log 	dengan format metrics_agg_{YmdH}.log.
- Karena file log bersifat sensitif pastikan semua file log hanya dapat dibaca oleh user pemilik file.

Note:
- Nama file untuk script per menit adalah minute_log.sh
- Nama file untuk script agregasi per jam adalah aggregate_minutes_to_hourly_log.sh
- Semua file log terletak di /home/{user}/log
- Semua konfigurasi cron dapat ditaruh di file skrip .sh nya masing-masing dalam bentuk comment

Berikut adalah contoh isi dari file metrics yang dijalankan tiap menit:
mem_total,mem_used,mem_free,mem_shared,mem_buff,mem_available,swap_total,swap_used,swap_free,path,path_size
15949,10067,308,588,5573,4974,2047,43,2004,/home/user/coba/,74M

Berikut adalah contoh isi dari file aggregasi yang dijalankan tiap jam:
type,mem_total,mem_used,mem_free,mem_shared,mem_buff,mem_available,swap_total,swap_used,swap_free,path,path_size
minimum,15949,10067,223,588,5339,4626,2047,43,1995,/home/user/coba/,50M
maximum,15949,10387,308,622,5573,4974,2047,52,2004,/home/user/coba/,74M
average,15949,10227,265.5,605,5456,4800,2047,47.5,1999.5,/home/user/coba/,62M

## Solusi
### minute_log.sh
Shell command-line berikut ditulis dengan obyektif untuk memantau sekaligus mencatat memori dan ukuran direktori */home* pengguna setiap menitnya ke dalam */home/$USER/log*.
```
#!/bin/bash

# Konfigurasi crontab
# * * * * * /home/$USER/minute_log.sh
```
- 5 bintang tersebut merepresentasikan *minute, hour, day of month, month,* dan *day of week*. Jika kelimanya *null*/simbol bintang maka dapat diartikan *every minute, every hour, every day of the month, every month, every day of the week*, yang bermakna setiap saat (setiap menit).

- Diikuti dengan *script path* yang akan dijalankan cron dalam direktori */home* pengguna. 

```
current_time=$(date +"%Y%m%d%H%M%S")
```
- Mendapatkan waktu terkini dengan format YYYY/MM/DD-HH:MM:SS

```
log_dir="/home/$USER/log"
mkdir -p "$log_dir"
```
- Menetapkan direktori */log*
- Jika belum ada, maka console akan membuat direktori tersebut di */home/$USER/log*

```
mem_metrics=$(free -m | awk 'NR==2{printf "%s,%s,%s,%s,%s,%s,%s,%s,%s", $2,$3,$4,$5,$6,$7,$3,$6,$4+$9}')
```
- Mengekstrak metrik memori dalam MB menggunakan `free -m` lalu menyimpannya dalam variabel `mem_metrics`
- `awk` berfungsi untuk memanipulasi serta menghasilkan laporan. Diikuti dengan `NR==2` yang bermakna menyambung operasi pada baris kedua setelah `free -m`.
- `printf "%s..."` bertugas untuk mencetak nilai tertentu pada baris kedua tersebut. Yang diikuti dengan variabel `$2...` yang merepresentasikan kolom kedua, ketiga, dan seterusnya dari baris tersebut.

```
path="/home/$USER/"
path_size=$(du -sh "$path" | awk '{print $1}')
```
- Menetapkan *path* ke direktori */home* pengguna sekaligus mendapatkan ukuran direktorinya untuk disimpan ke dalam `path_size`.

```
log_line="mem_total,mem_used,mem_free,mem_shared,mem_buff,mem_available,swap_total,swap_used,swap_free,path,path_size $mem_metrics,$>
```
- Membuat baris log dengan kumpulan metrik memori serta ukuran *path*.

```
log_file="$log_dir/metrics_$current_time.log"
echo "$log_line" > "$log_file"
```
- Merekonstruksi nama file log sesuai format yang sudah disepakati dengan *"metrics_"* yang diikuti dengan waktu.
- Mencetak isi variabel *log_line* dan mengarahkannya ke dalam *log_file*

```
chmod 600 "$log_file"
```
- Mengatur *permission* untuk *file_log*.
- 600 bermakna 6 (pemilik file berhak untuk membaca dan menulis file), 0 (grup tidak memiliki hak apapun), dan 0 (pengguna lain juga tidak memiliki hak apapun).

### aggregate_minutes_to_hourly_log.sh
