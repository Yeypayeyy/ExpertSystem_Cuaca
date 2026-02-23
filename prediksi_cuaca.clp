
; EXPERT SYSTEM PREDIKSI CUACA

; Muhammad Farrel Al Ghazy 
; 24/540589/TK/60022


; Rule Input: 

(defrule input-data
   (declare (salience 100))
   =>
   (printout t "Masukkan suhu (dalam Celsius): ")
   (bind ?s (read))
   (printout t "Kondisi langit (cerah/mendung): ")
   (bind ?l (read))
   (printout t "Tekanan udara (tinggi/rendah): ")
   (bind ?t (read))

   (assert (input-suhu ?s))
   (assert (input-langit ?l))
   (assert (input-tekanan ?t))
)


; Aturan Validasi Input:

(defrule validasi-input
   (declare (salience 90))
   (input-suhu ?s)
   (input-langit ?l)
   (input-tekanan ?t)
   =>
   (if (and (numberp ?s)
            (or (eq ?l cerah) (eq ?l mendung))
            (or (eq ?t tinggi) (eq ?t rendah)))
      then
         (assert (suhu ?s))
         (assert (kondisi-langit ?l))
         (assert (tekanan-udara ?t))
         (assert (data-valid))
      else
         (assert (data-invalid))
   )
)


; Aturan Prediksi:


(defrule prediksi-cerah
   (data-valid)
   (suhu ?s&:(> ?s 28))
   (kondisi-langit cerah)
   (tekanan-udara tinggi)
   =>
   (assert (cuaca cerah))
)

(defrule prediksi-hujan
   (data-valid)
   (kondisi-langit mendung)
   (tekanan-udara rendah)
   =>
   (assert (cuaca hujan))
)

(defrule prediksi-berawan
   (data-valid)
   (kondisi-langit mendung)
   (tekanan-udara tinggi)
   =>
   (assert (cuaca berawan))
)

(defrule prediksi-sejuk
   (data-valid)
   (suhu ?s&:(<= ?s 28))
   (kondisi-langit cerah)
   (tekanan-udara tinggi)
   =>
   (assert (cuaca sejuk))
)

(defrule prediksi-tidak-dapat-ditentukan
   (declare (salience -10))
   (data-valid)
   (suhu ?)
   (kondisi-langit ?)
   (tekanan-udara ?)
   (not (cuaca ?))
   =>
   (assert (cuaca tidak-dapat-ditentukan))
)

(defrule prediksi-error
   (data-invalid)
   =>
   (assert (cuaca error))
)


; Output:


(defrule output-cerah
   (cuaca cerah)
   =>
   (printout t crlf "==========================" crlf)
   (printout t "Prediksi cuaca: CERAH" crlf)
   (printout t "==========================" crlf)
)

(defrule output-hujan
   (cuaca hujan)
   =>
   (printout t crlf "==========================" crlf)
   (printout t "Prediksi cuaca: HUJAN" crlf)
   (printout t "==========================" crlf)
)

(defrule output-berawan
   (cuaca berawan)
   =>
   (printout t crlf "==========================" crlf)
   (printout t "Prediksi cuaca: BERAWAN" crlf)
   (printout t "==========================" crlf)
)

(defrule output-sejuk
   (cuaca sejuk)
   =>
   (printout t crlf "==========================" crlf)
   (printout t "Prediksi cuaca: CERAH SEJUK" crlf)
   (printout t "==========================" crlf)
)

(defrule output-tidak-dapat-ditentukan
   (cuaca tidak-dapat-ditentukan)
   =>
   (printout t crlf "==========================" crlf)
   (printout t "Prediksi cuaca: TIDAK DAPAT DITENTUKAN" crlf)
   (printout t "Kombinasi kondisi tidak sesuai" crlf)
   (printout t "==========================" crlf)
)

(defrule output-error
   (cuaca error)
   =>
   (printout t crlf "==========================" crlf)
   (printout t "ERROR: Fakta tidak cukup!" crlf)
   (printout t "Input harus:" crlf)
   (printout t "- Suhu: angka" crlf)
   (printout t "- Langit: cerah/mendung" crlf)
   (printout t "- Tekanan: tinggi/rendah" crlf)
   (printout t "==========================" crlf)
)