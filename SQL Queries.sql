--SOAL 1
select nama, email, bulan_lahir, tanggal_registrasi
from rakamin_customer
where bulan_lahir in ('Januari','Februari','Maret')
	and tanggal_registrasi between '2012-01-01' and '2012-03-31'
	or email like '%yahoo.com''%roketmail.com';

--SOAL 2

select distinct id_order, id_pelanggan, harga, ppn, harga*ppn+harga as harga_setelah_ppn,
	case when harga*ppn+harga <= 20000 then 'low'
		when harga*ppn+harga <= 50000 then 'medium'
		when harga*ppn+harga >50000 then 'high'
	end as spending_bucket
from rakamin_order
order by harga_setelah_ppn desc;

--SOAL 3
select id_merchant,
	count(kuantitas) as jumlah_order, 
	count(harga) as total_pendapatan
from rakamin_order
group by id_merchant
order by total_pendapatan desc;

--SOAL 4
select 
	CASE WHEN metode_bayar like 'ovo' then 'ovo_payment'
		when metode_bayar like 'link aja' then 'linkaja_payment'
		when metode_bayar like 'gopay' then 'gopay_payment' 
		when metode_bayar like 'shopeepay' then 'shopee_payment'
		when metode_bayar like 'cash' then 'cash_payment'
		when metode_bayar like 'dana' then 'dana_payment'
	END AS metode_pembayaran,
count(1) as frekuensi_pembayaran
from rakamin_order
group by 1
having count (1)>10
order by frekuensi_pembayaran desc;

--SOAL 5

select * from 
(
	select distinct id_pelanggan, 
	count(kota) as total_kota
	from rakamin_customer_address
	group by id_pelanggan
)
as rca
order by total_kota desc

--SOAL 6
select *
from (
	select metode_bayar,  
	count(metode_bayar) as frekuensi
	from rakamin_order
	group by metode_bayar
	order by frekuensi desc
)
as ro
left join rakamin_customer as rc on ro.id_pelanggan = rc.id_pelanggan;

--SOAL 7
with reward as
(
	select kuantitas, sum (kuantitas) as total_kuantitas
	from rakamin_order
	group by kuantitas
	having sum (kuantitas) > 5
),
select rc.id_pelanggan, rc.total_kuantitas, rc.nama, rc.email
from rewards as rc
left join rakamin_customer as rr on rc.id_pelanggan = rr.id_pelanggan, rr.total_kuantitas;