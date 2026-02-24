
; EXPERT SYSTEM PREDIKSI CUACA

; Muhammad Farrel Al Ghazy 
; 24/540589/TK/60022


; Rule Input: 

(defrule input_data
   (declare (salience 100))
   =>
   (printout t "Masukkan suhu (dalam Celsius): ")
   (bind ?s (read))
   (printout t "Kondisi langit (cerah/mendung): ")
   (bind ?l (read))
   (printout t "Tekanan udara (tinggi/rendah): ")
   (bind ?t (read))

   (assert (input_suhu ?s))
   (assert (input_langit ?l))
   (assert (input_tekanan ?t))
)


; Aturan Validasi Input:

(defrule validasi_input
   (declare (salience 90))
   (input_suhu ?s)
   (input_langit ?l)
   (input_tekanan ?t)
   =>
   (if (and (numberp ?s)
            (or (eq ?l cerah) (eq ?l mendung))
            (or (eq ?t tinggi) (eq ?t rendah)))
      then
         (assert (suhu ?s))
         (assert (kondisi_langit ?l))
         (assert (tekanan_udara ?t))
         (assert (data_valid))
      else
         (assert (data_invalid))
   )
)


; Aturan Prediksi:


(defrule prediksi_cerah
   (data_valid)
   (suhu ?s&:(> ?s 28))
   (kondisi_langit cerah)
   (tekanan_udara tinggi)
   =>
   (assert (cuaca cerah))
)

(defrule prediksi_hujan
   (data_valid)
   (kondisi_langit mendung)
   (tekanan_udara rendah)
   =>
   (assert (cuaca hujan))
)

(defrule prediksi_berawan
   (data_valid)
   (kondisi_langit mendung)
   (tekanan_udara tinggi)
   =>
   (assert (cuaca berawan))
)

(defrule prediksi_sejuk
   (data_valid)
   (suhu ?s&:(<= ?s 28))
   (kondisi_langit cerah)
   (tekanan_udara tinggi)
   =>
   (assert (cuaca sejuk))
)

(defrule prediksi_unpredicted
   (declare (salience -10))
   (data_valid)
   (suhu ?)
   (kondisi_langit ?)
   (tekanan_udara ?)
   (not (cuaca ?))
   =>
   (assert (cuaca tidak_dapat_ditentukan))
)

(defrule prediksi_error
   (data_invalid)
   =>
   (assert (cuaca error))
)


; Output:


(defrule output_cerah
   (cuaca cerah)
   =>
   (printout t crlf "Prediksi cuaca: CERAH" crlf)
)

(defrule output_hujan
   (cuaca hujan)
   =>
   (printout t crlf "Prediksi cuaca: HUJAN" crlf)
)

(defrule output_berawan
   (cuaca berawan)
   =>
   (printout t crlf "Prediksi cuaca: BERAWAN" crlf)
)

(defrule output_sejuk
   (cuaca sejuk)
   =>
   (printout t crlf "Prediksi cuaca: CERAH SEJUK" crlf)
)

(defrule output_tidak_dapat_ditentukan
   (cuaca tidak_dapat_ditentukan)
   =>
   (printout t crlf "Prediksi cuaca: TIDAK DAPAT DITENTUKAN" crlf)
   (printout t "Kombinasi kondisi tidak sesuai" crlf)
)

(defrule output_error
   (cuaca error)
   =>
   (printout t crlf "ERROR: Fakta tidak cukup!" crlf)
   (printout t "Input harus:" crlf)
   (printout t "- Suhu: angka" crlf)
   (printout t "- Langit: cerah/mendung" crlf)
   (printout t "- Tekanan: tinggi/rendah" crlf)
)