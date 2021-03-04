"Kita menduga bahwa ada korelasi antara pendidikan ibu dan pendidikan ayah."
cor(data$Medu, data$Fedu)

"Hasilnya adalah 0.62. Ini korelasi yang cukup tinggi."

"Bikin plot yang menunjukkan proporsi kombinasi tingkat pendidikan"
ggplot(data, aes(x = Medu)) +
  geom_bar(aes(fill = as.factor(Fedu)))

ggplot(data, aes(x = Fedu)) +
  geom_bar(aes(fill = as.factor(Medu)))

"Dari sini kelihatan bahwa untuk semua tingkat pendidikan, seorang wanita
paling mungkin mendapat pasangan yang pendidikannya sama. Hal yang sama juga
berlaku untuk pria. seorang pria paling mungkin mendapat pasangan dgn tingkat
pendidikan yang sama. Jadi kita bisa mengambil kesimpulan bahwa kalau ada
org yang pengen punya pasangan yang berpendidikan tinggi, hal yang bisa dia
lakukan adalah cari pendidikan tinggi!"

"Jadi orang kan cenderung untuk menikah dengan orang yang pendidikannya kurang
lebih sama. Sebenernya hal ini tidak berarti bahwa orang secara aktif memilih
pasangan berdasarkan pendidikannya. Bisa jadi orang cenderung untuk memilih
orang lain yang sering mereka temui untuk menjadi pasangannya. Dengan demikian
orang yang kuliah S1 akan cenderung memilih org yg kuliah S1 juga karena mereka
sering bertemu dengan org tersebut (Org2 yg menikah dengan pasangan yang mereka
temui saat kuliah). Hal yang sama bisa terjadi pada semua jenjang perkuliahan.

Bisa jadi juga karena ketika sudah masuk kerja, orang akan berinteraksi dengan
orang lain yang pendidikannya kurang lebih sama. Karena kalau dibutuhkan
pendidikan tinggi untuk diterima kerja di suatu posisi, kemungkinan besar rekan
kerja kita juga adalah orang yang sudah melalui proses seleksi yang sama, jdi
mereka juga pasti memiliki tingkat pendidikan yang sama atau kurang lebih sama
dengan kita. Kemudian krn sering berinteraksi mereka jatuh cinta dan menikah.
Singkat kata, hal ini tidak berarti orang gengsi dan memilih pasangan yang
pendidikannya kurang lebih setara dengan mereka."

"It is interesting to know the probability of father/mother education given 
the mother/father education. We are going to create a dataframe consisting of
exactly these probabilities. The resulting table can always be rounded and
expressed as a percentage"

Fedu.given.Medu <- data.frame(row.names = c("Fedu 0", "Fedu 1", "Fedu 2", "Fedu 3", "Fedu 4"))
columnnames <- c("Medu 0", "Medu 1", "Medu 2", "Medu 3", "Medu 4")
prop <- c()
for (i in 0:4){
  temp <- filter(data, Medu == i)
  for (n in 0:4){
    prop[n + 1] <- sum(temp$Medu == n)
  }
  Fedu.given.Medu[,columnnames[i + 1]] <- prop/length(temp$Fedu)
}
rm(temp, i, prop, columnnames)

Medu.given.Fedu <- data.frame(row.names = c("Medu 0", "Medu 1", "Medu 2", "Medu 3", "Medu 4"))
columnnames <- c("Fedu 0", "Fedu 1", "Fedu 2", "Fedu 3", "Fedu 4")
prop <- c()
for (i in 0:4){
  temp <- filter(data, Fedu == i)
  for (n in 0:4){
    prop[n + 1] <- sum(temp$Medu == n)
  }
  Medu.given.Fedu[,columnnames[i + 1]] <- prop/length(temp$Medu)
}
rm(temp, i, prop, columnnames)

"The data can be tidied"

Fedu.given.Medu <- data.frame(Fedu = c(0,1,2,3,4))
columnnames <- c("0", "1", "2", "3", "4")
prop <- c()
for (i in 0:4){
  temp <- filter(data, Medu == i)
  for (n in 0:4){
    prop[n + 1] <- sum(temp$Medu == n)
  }
  Fedu.given.Medu[,columnnames[i + 1]] <- prop/length(temp$Fedu)
}
rm(temp, i, prop, columnnames)
Fedu.given.Medu <- gather(Fedu.given.Medu,
                          key = Medu,
                          value = Probability,
                          -Fedu)

Medu.given.Fedu <- data.frame(Medu = c(0,1,2,3,4))
columnnames <- c("0", "1", "2", "3", "4")
prop <- c()
for (i in 0:4){
  temp <- filter(data, Fedu == i)
  for (n in 0:4){
    prop[n + 1] <- sum(temp$Medu == n)
  }
  Medu.given.Fedu[,columnnames[i + 1]] <- prop/length(temp$Medu)
}
rm(temp, i, n, prop, columnnames)
Medu.given.Fedu <- gather(Medu.given.Fedu,
                          key = Fedu,
                          value = Probability,
                          -Medu)

"It is also interesting to find out the probabilities of all possible
education level"

edu <- matrix(nrow = 5, ncol = 5)
for (i in 0:4){
  for (j in 0:4){
    edu[i + 1, j + 1] <- sum(data$Fedu == i & data$Medu == j) / 395
  }
}
rownames(edu) <- c("Fedu 0", "Fedu 1", "Fedu 2", "Fedu 3", "Fedu 4")
colnames(edu) <- c("Medu 0", "Medu 1", "Medu 2", "Medu 3", "Medu 4")
rm(i,j)
edu_percent <- round(edu * 100, 2)