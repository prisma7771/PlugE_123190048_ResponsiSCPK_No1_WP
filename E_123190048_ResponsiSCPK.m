%penyelesaian kasus rela estate menggunakan metode WP(Weighted Problem)

clc;clear; %untuk membersihkan jendela command windows

k = [0,0,1,0];  % Atribut tiap-tiap kriteria, dimana nilai 1=atrribut keuntungan, dan  0= atribut biaya
                % X2HouseAge merupakan cost
                % DistanceToTheNearestMRTStation merupakan cost
                % X4NumberOfConvenienceStores merupakan benefit
                % YHousePriceOfUnitArea merupakan cost 

w = [3,5,4,1];%Nilai bobot tiap kriteria (1= sangat buruk, 2=buruk, 3= cukup, 4= tinggi, 5= sangat tinggi) 

opts = detectImportOptions('Real estate valuation data set.xlsx'); %Mengambil nilai option import data dari file xlsx
opts.SelectedVariableNames = ([3:5,8]);                            %Sesuai ketentuan, hanya mengambil nilai kolom 3 hingga 5 dan kolom 8, yaitu houseage, distance, store, and price
opts.DataRange = '2:51';                                           %Mengambil data range dari baris 2 hingga 50, karena baris pertama adalah nama kolom 
data = readtable('Real estate valuation data set.xlsx',opts);      %Membaca file xlsx sebagai tabel dengan opts sebagai import optionnya dan menyimpan di variabel data
datarealestate = table2array(data);                                %Mengubah nilai data yang awalnya tabel menjadi array

opts1 = detectImportOptions('Real estate valuation data set.xlsx');%Mengambil option import data
opts1.SelectedVariableNames = (1);                                 %Hanya Mengambil data pada kolom 1, yaitu nama rumah
opts1.DataRange = '2:51';                                          %Mengambil data range dari baris 2 hingga 50, karena baris pertama adalah nama kolom 
data1 = readtable('Real estate valuation data set.xlsx',opts1);    %Membaca file xlsx sebagai tabel dengan opts sebagai import optionnya dan menyimpan di variabel data1
namarumah = table2array(data1);                                    %Mengubah nilai data1 yang awalnya tabel menjadi array

%tahapan pertama, perbaikan bobot
[m,n]=size(datarealestate); %inisialisasi ukuran datarealestate
w=w./sum(w); %membagi bobot per kriteria dengan jumlah total seluruh bobot

%tahapan kedua, melakukan perhitungan vektor(S) per baris (alternatif)
for j=1:n
    if k(j)==0, w(j)=-1*w(j);
    end
end
for i=1:m
    S(i)=prod(datarealestate(i,:).^w); 
end

%tahapan ketiga, proses perangkingan
V = S/sum(S);
V = V.'; %Mengubah bentuk V yang aslinya array 1x50 menjadi array 50x1 


hasil = {namarumah; V}; %menggabungkan variabel namarumah dan V menjadi satu array berisi 2x1 cell array dengan isi {50x1 double} dan {50x1 double}
hasil = horzcat(hasil{:}); %mengubah hasil menjadi array 50x2 
hasilsort = sortrows(hasil,2,'descend'); %Mengurutkan hasil secara menurun berdasarkan nilai pada kolom 2(hasil perhitungan) ke variabel hasilsort
hasilsort = num2cell(hasilsort); %Mengubah hasilsort yang awalnya array ke cell agar terlihat rapi

disp('Hasil Perangngkingan Dataset Real Estate');
disp('     NO   |   SKOR   ');
disp(hasilsort);
