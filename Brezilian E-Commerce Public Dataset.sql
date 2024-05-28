--Brazilian E-Commerce Public Dataset by Olist - ERD Görseli


--Case 1 : Sipariş Analizi
--Question 1 : 
--Aylık olarak order dağılımını inceleyiniz. Tarih verisi için order_approved_at kullanılmalıdır.

--SQL Query:

SELECT
    (date_trunc('month',o.order_approved_at))::date AS order_month,
    COUNT(distinct order_id) AS siparis_sayisi
FROM 
	orders as o
WHERE
	o.order_approved_at IS NOT NULL
GROUP BY 
	1
ORDER BY 
	order_month 

--2016 yılına ait veriler oldukça az ve muhtemelen eksik olduğu için elde ettiğimiz sonuçlar 2016 yılı 
--için anlamlı ve yorumlanabilir değildir. 2017 yılına ait order dağılıma baktığımızda ise ilerleyen aylar 
--boyunca devamlı artış gösteren bir seyir izlemektedir ve yorumlanabilir anlamlı bir çıktı elde edilmiştir. 
--2018 yılına baktığımızda 2017 yılına kıyasla order sayısında artışlar olduğunu görmekteyiz. 
--Şirket veya işletmeler , yeni pazarlara açılmış, müşteri tabanını genişletmiş veya ürün yelpazesini 
--artırmış olabilir. Bu durum daha fazla müşteriye ulaşılmasını ve daha fazla sipariş alınmasını teşvik etmiş 
--olabilir.  Ya da 2018’de müşteri memnuniyeti artmış veya müşteri sadakati güçlenmiş olabilir. 
--Memnun müşteriler daha fazla alışveriş yapma eğiliminde olabilirler. 
--Özel günler ve promosyon dönemleri gibi zamanlarda işletmeler indirimler ve özel kampanyalar sunarak 
--sipariş artışı elde etmiş olabilir.

--Question 2 : 
--Aylık olarak order status kırılımında order sayılarını inceleyiniz.
--Sorgu sonucunda çıkan outputu excel ile görselleştiriniz. Dramatik bir düşüşün ya da yükselişin olduğu aylar var mı? Veriyi inceleyerek yorumlayınız.

--SQL Query:

SELECT
    (date_trunc('month',o.order_approved_at))::date AS order_month,
	order_status,
    COUNT(distinct order_id) AS siparis_sayisi
FROM 
	orders as o
WHERE
	o.order_approved_at IS NOT NULL
GROUP BY 
	1,2
ORDER BY 
	order_month 

--Sorgu sonucunda elde ettiğim çıktı da order status sütunu altında shipped, unavailable, invoiced, created, 
--approved, processing, delivered, canceled aşamalarının bulunduğu bir sonuç aldım. 
--Fakat inceledikten sonra approved,delivered gibi bazı aşamaların verilerinin çok anlamlı bir sonuç 
--vermemesinden dolayı, sizlere görsel olarakta daha net ifade edebilmek adına ve daha mantıklı olduğunu 
--düşündüğüm  “processing, shipped, canceled” aşamalarını görselleştirdim. Burada “processing” aşaması 
--genellikle; alışveriş platformu veya satıcılar tarafından siparişlerinizin artık onaylanarak hazırlanma 
--ve sevkiyat aşamasında olduğu anlamına gelmektedir. “Shipped” kargolanmış siparişleri, “canceled” is
--iade edilen siparişlerin miktarını göstermektedir. Üç aşamayı baz alarak yaptığımız incelemede 
--“canceled” edilen sipariş sayısının fazlalığı dikkatimi çekmektedir.  
--Grafiği incelediğimizde “processing” olarak ifade ettiğimiz onaylanan ve sevkiyata hazırlanan siparişlerin 
--genel itibariyle  canceled olanlara oranla daha az olduğunu görmekteyiz. 
--Bu durumu şu şekilde yorumlamak mümkün olabilir;
--●	Müşteri memnuniyetsizliği veya müşteri hizmetleriyle iletişimde yaşanan eksiklikler nedeniyle 
--siparişlerin iptal edilmesi gibi bir durum söz konusu olabilir. Bu noktada, müşteri memnuniyetini artırmak 
--ve iletişim sorunlarına çözüm bulmak için işletmenin müşteri hizmetleri süreçlerini gözden geçirmeleri gerekebilir.
--●	Ürünlerin temin edilmesi veya stok yönetimi ile ilgili sorunlar da siparişlerin iptal ile sonuçlanmasına 
--neden olabilir. Bu nedenle, tedarik zinciri süreçlerini gözden geçirmek ve iyileştirmek, 
--bu tür sorunların azalmasına yardımcı olabilir.
--●	Siparişlerin yanlış işlenmesi veya hatalı ürünlerin gönderilmesi, müşteri memnuniyetsizliğine ve dolayısıyla
--iptallere yol açanbilir. O nedenle sipariş işleme süreçlerini gözden geçirerek ve iyileştirerek bu sorunun 
--önüne geçilmesi mümkün olabilir.
--Dolayısıyla problemin çözümü için bütün bu durumların göz önünde bulundurulup ona göre aksiyon  
--alınması gerekmektedir. 
--Diğer taraftan “shipped” aşamadında görülen kargolarda genel olarak olumsuz bir durum görünmemektedir. 
--Bazı tarihlerde shipped aşamasının nispeten fazla olduğunu ve dramatik bir yükselişin olduğunu görmekteyiz. 
--Özellikle 2017 yılında tüm dünyada gerçekleştirilen Black Friday buradaki shipped’ların dramatik yükselişinde 
--etkili olmuş olabilir. 2018 yılına baktığımızda Ocak ayında da dramatik bir artış söz konusu, 
--burada da yeni yıl etkisinin olduğu yorumunu yapabiliriz.
--Genel itibariyle 2016 yılı için verimiz çok kısıtlı olduğundaan dolayı herhangi bir yorum yapamamaktayız. 
--Yine 2018’e baktığımızda yılın son aylarını içermemesi nedeniyle 2018 kasım ayında da  blackfriday  
--etkisinin görünüp görünmediği, siparişlerin artıp artmadığı durumları görememekteyiz.
 

--Bunun dışında anlamsız bir sonuç aldığımı göstermek adına aşağıdaki grafiğe “delivered” aşamasını da 
--ekleyerek yorum yapmak istedim. Çünkü bu kısımda çok göze çarpan dramatik bir yükseliş söz konusu diğer 
--bahsi geçen aşamalarla kıyaslandığında. Burada verimiz tam bir gerçek hayat verisi olmadığı ve 
--bazı eksiklikleri olduğu için bundan kaynaklı bir durum olabilir. Veya veriler doğru olup 
--“procesing”, “shipped” ve “canceled” aşamaları ile arasında bu şekilde büyük bir uçurum var ise;
--●	Belirli bir dönemde talep dalgalanmaları, delivered aşmasındaki sipariş miktarşarını etkileyebilir. 
--Özellikle kampanyalar, tatil sezonları ve özel etkinlikler sırasında yaşanan talep artışından dolayı da 
--bu şekilde bir sonuç ortaya çıkmış olabilir.  
--●	Müşterilerin iade veya değişim talepleri de, daha fazla ürünün “delivered” aşamasında gelmesine neden olabilir. Yani bu kısımda müşterinin iade edip ulaşmasını beklediği ürünler olabilir, “canceled” olana kadar “delivered” olarak  bekliyordur ürünler. Iade veya değişim işlemleri bu farkın bir kısmını açıklayabilir.
--Toparlayacak olursam, ortaya çıkan problemlerde öncelikle işletmelerin iç süreçlerini ve veri kaynaklarını 
--incelemek daha doğru olur. Bu inceleme sonucunda, nedenlere yönelik daha kesin bir yorumda bulunabilir ve 
--gerekli düzeltmeler gerçekleştirilebilir. Işletmenin büyüklüğü, sektörü ve iş modeli de bu tür farkların 
--nedenlerini etkileyebilir, bu nedenle daha spesifik koşulları dikkate almakta fayda vardır.


--Question 3 : 
--Ürün kategorisi kırılımında sipariş sayılarını inceleyiniz. Özel günlerde öne çıkan kategoriler nelerdir? Örneğin yılbaşı, sevgililer günü…

--SQL Query:
--2017 YILI ANALİZİ

WITH special_days AS 
(
    SELECT 'Yılbaşı' AS event, DATE '2017-12-31' AS date
    UNION ALL
    SELECT 'Sevgililer Günü' AS event, DATE '2017-06-12' AS date
	union all
	select 'Anneler Günü' as event, date '2017-05-13' as date
	union all
	select 'Babalar Günü' as event, date '2017-08-12' as date
)
,
urun_kategori_siparisi AS
(
    SELECT
        p.product_category_name,
        COUNT(DISTINCT oi.order_id) AS siparis_sayisi
    FROM
        products p
    JOIN
        order_items oi ON oi.product_id = p.product_id
    GROUP BY
        p.product_category_name
)
SELECT 
	date as tarih,
    event,
    product_category_name,
    siparis_sayisi
FROM 
(
    SELECT
        sd.event,
        sd.date,
        p.product_category_name,
        COUNT(*) AS siparis_sayisi,
        ROW_NUMBER() OVER (PARTITION BY sd.event ORDER BY COUNT(*) DESC) AS siralama
    FROM
        special_days sd
    JOIN
        orders o ON DATE_TRUNC('day', o.order_approved_at) = sd.date
    JOIN
        order_items oi ON oi.order_id = o.order_id
    JOIN
        products p ON oi.product_id = p.product_id
    GROUP BY
        sd.event, sd.date, p.product_category_name
) AS ranked_data
WHERE 
    siralama <= 5 AND product_category_name IS NOT NULL
ORDER BY
    event, siparis_sayisi DESC
;
--2017 yılı için özel günlerde öne çıkan ilk 3 kategori şu şekildedir:
--Anneler günü
--1.bed_bath_table
--2.furniture_decor
--3.healthy_beathy
--Babalar günü
--1.bed_bath_table
--2.cool_stuff
--3.spotrs_leisure
--Sevgililer Günü:
--1.house_wares
--2.bed_bath_table
--3.telephony
--Yılbaşı:
--1.stationery
--2.telephony
--3.wacthes_gifts


--2018 YILI ANALİZİ

WITH special_days AS 
(
    SELECT 'Sevgililer Günü' AS event, DATE '2018-06-12' AS date
    UNION ALL
    SELECT 'Anneler Günü' AS event, DATE '2018-05-13' AS date
    UNION ALL
    SELECT 'Babalar Günü' AS event, DATE '2018-08-12' AS date
)
,
urun_kategori_siparisi AS
(
    SELECT
        p.product_category_name,
        COUNT(DISTINCT oi.order_id) AS siparis_sayisi
    FROM
        products p
    JOIN
        order_items oi ON oi.product_id = p.product_id
    GROUP BY
        p.product_category_name
)
SELECT 
	date as tarih,
    event,
    product_category_name,
    siparis_sayisi
FROM 
(
    SELECT
        sd.event,
        sd.date,
        p.product_category_name,
        COUNT(*) AS siparis_sayisi,
        ROW_NUMBER() OVER (PARTITION BY sd.event ORDER BY COUNT(*) DESC) AS siralama
    FROM
        special_days sd
    JOIN
        orders o ON DATE_TRUNC('day', o.order_approved_at) = sd.date
    JOIN
        order_items oi ON oi.order_id = o.order_id
    JOIN
        products p ON oi.product_id = p.product_id
    GROUP BY
        sd.event, sd.date, p.product_category_name
) AS ranked_data
WHERE 
    siralama <= 5 AND product_category_name IS NOT NULL
ORDER BY
    event, siparis_sayisi DESC

--2018 yılı için özel günlerde öne çıkan ilk 3 kategori şu şekildedir:
--Anneler günü
--1. housewares 
--2.sports_leisure
--3.watch_gifts
--Babalar günü
--1 healthy_beathy
--2.furniture_decor
--3. housewares
--Sevgililer Günü:
--1.healthy_beathy
--2.bed_bath_table
--3.housewares

--2017 ve 2018 yıllarında elde ettiğim çıktıları incelediğimde genel olarak her iki yılda da; 
--ev dekorasyon, banyo ürünleri, güzellik ve bakım,giyim gibi kategorilerin ön plana çıktığını söyleyebiliriz. 



--Question 4 : 
--Haftanın günleri(pazartesi, perşembe, ….) ve ay günleri (ayın 1’i,2’si gibi) bazında 
--order sayılarını inceleyiniz. Yazdığınız sorgunun outputu ile excel’de bir görsel oluşturup yorumlayınız.


SQL Query:

--HAFTANIN GÜNLERİ BAZINDA ORDER SAYILARI

SELECT
	EXTRACT(YEAR FROM order_approved_at) AS yil,
   	EXTRACT(DOW FROM order_approved_at) AS gun,
    COUNT(distinct order_id) AS siparis_sayisi
FROM
    orders
WHERE
    EXTRACT(YEAR FROM order_approved_at) IN (2016, 2017, 2018)
GROUP BY
    1,2
ORDER BY
    1,2 


 

--Elde ettiğimiz çıktımızı incelediğimizde, 0 ile ifade edilen Pazar gününün diğer günlerden daha düşük 
--sipariş sayılarına sahip olduğunu ve özellikle Salı(2 ile ifade edilen), Çarşamba(3 ile ifade edilen) ve 
--Perşembe(4ile ifade edilen) günlerinin daha fazla sipariş aldığını görüyoruz. 
--Bu tür bir veri analizi işletmeler veya e-ticaret platformları için önemli bilgilere işaret edebilir. 
--Elde ettiğimiz bu çıktılarla ilgili olarak şu değerlendirmeleri yapabiliriz;
--1. Pazar günü siparişlerin az olması, belirli bir talep dalgalanması veya müşteri davranışı değişikliklerine 
--işaret edebilir. Müşterilerin haftanın farklı günlerinde farklı alışveriş alışkanlıklarına sahip olabileceğini
--gösteriyor olabilir.
--2. Salı, Çarşamba ve Perşembe günleri daha fazla sipariş alınıyorsa, bu günlerde özellikle etkili pazarlama 
--kampanyaları veya promosyonlar düzenlenmiş olabilir. Müşterilere çeşitli nedenlerle bu günlerde daha fazla 
--alışveriş yapma teşviki sağlanmış olabilir. Ve gördüğümüz gibi olumlu sonuçlar verdiği içinde yapılan reklam,
--kampanyalara vs. gibi durumlara devam edilip daha da geliştirilmesi, iyileştirilmesi sağlanabilir. Aynı zamanda haftasonu siparişlerini artıracak kampanyalarda düşünülebilir, düzenlemeler yapılabilir.
--3. Müşterilerin sipariş verme alışkanlıkları, işletmenin çalışma saatlerine veya sipariş alınabilirlik 
--sürelerine bağlı olabilir. Müşterilerin Pazar günü daha az sipariş vermesi, işletmenin bu günlerde 
--kısmen kapalı olabileceğini veya sınırlı hizmet sunabileceğini gösterebilir.
--4. Müşterilerin sipariş verme alışkanlıkları en çok hafta içi olduğu için firmaların kurye hizmeyti mevcutsa 
--mesela bu kuryelerinin izinlerini daha çok haftasonuna kaydırarak haftaiçi teslimat sirkülasyonun daha yoğun 
--olmasını sağlayabilir.
--5. Bu durum sadece kısa süreli bir dalgalanmadan kaynaklı da olabilir. Dolayısıylar rakiplerin veya içinde 
--bulunulan endüstri standartlarının da bu tür bir haftalık dalgalanmaları etkileyebileceği göz önünde bulundurmalı. Endüstri trendleri ve rekabet koşulları, siparişlerin dağılımını etkileyebilir.
--6. Böyle bir analizde veri doğruluğu önemlidir. Verilerin düzgün bir şekilde kaydedildiğinden ve 
--analiz edildiğinden emin olunmalıdır Veri kayıtlarının eksik veya hatalı olması sonuçları yanıltıcı 
--hale getirebilir.
--Daha fazla ayrıntı ve yorum için bu çıktıları daha fazla veri ve analizle desteklemek önemlidir. 
--Bu analiz, işletmenizin stratejilerini geliştirmek veya daha etkili pazarlama kampanyaları planlamak 
--için kullanışlı bilgiler sunabilir.

;

--AYIN GÜNLERİ BAZINDA ORDER SAYILARI

SELECT
    TO_CHAR(order_approved_at, 'YYYY-MM-DD') AS tarih,
    COUNT(*) AS siparis_sayisi
FROM
    orders
WHERE
    EXTRACT(YEAR FROM order_approved_at) IN (2016, 2017, 2018)
GROUP BY
  	1
ORDER BY
    1 
   

--Çalışmamda 2016 yılına ait verilerin kesin sonuçlar çıkarmamız için yeterli olmadığını gözlemledim, 
--bu nedenle bu yıla dair yorumlarımı sınırlı tutuyorum. Ancak 2017 ve 2018 yıllarına ait verilere baktığımda, 
--sipariş sayılarının özellikle 2018 yılında artış gösterdiğini görüyorum. 
--Bu artış, yapılan stratejik geliştirmelerin ve kampanyaların işe yaradığını gösteriyor gibi görünüyor.

--Ayrıca, her iki yılda da dikkat çeken bir eğilim var: Ayın belirli günlerinde sipariş yoğunluğunun 
--arttığı görülüyor. Genel olarak, her ayın başlarında (1., 2. ve 3. günler) ve 
--ortasına yakın tarihlerde (10., 11. ve 12. gün gibi) sipariş sayılarında artışlar meydana    geliyor. 
--Ayrıca, her ayın sonlarına doğru sipariş sayılarında bir artış yaşanıyor gibi görünüyor.

--Bu eğilimler, Brezilya'da benzer özel durumlar veya sosyo-ekonomik faktörlerin etkisiyle de açıklanabilir. 
--İşletmelerin bu dönemde uyguladığı stratejiler, özellikle belirli tarih aralıklarında siparişleri 
--teşvik ediyor olabilir. Bu bilgiler, işletme stratejilerini daha da geliştirmek veya belirli dönemlerdeki 
--talep artışlarına hazırlıklı olmanız için önemli bir yol haritası sunuyor gibi görünüyor.

--Ek olarak, 2017 ve 2018 yıllarının ortak grafiklerine baktığımızda, her iki yılda da gözle görünür 
--bir sipariş artışı olduğunu net bir şekilde gözlemliyoruz. Ve 2017 ye göre 2018 yılında genel bir iyileşme 
--ve sipariş sayılarında artış olduğunu da ifade edebiliriz. Bu, işletmenin büyümesini ve başarısını işaret edebilir.


--Case 2 : Müşteri Analizi 
--Question 1 : 
--Hangi şehirlerdeki müşteriler daha çok alışveriş yapıyor? Müşterinin şehrini en çok sipariş verdiği 
--şehir olarak belirleyip analizi ona göre yapınız. 

SQL Query:

WITH customer_city AS
(
    SELECT 
        c.customer_unique_id,
        c.customer_city,
        COUNT(c.customer_unique_id) AS toplam_musteri_sayisi,
        SUM(op.payment_value) AS toplam_odeme_mik
    FROM customers c
    JOIN orders o ON o.customer_id = c.customer_id
    JOIN order_payments op ON op.order_id = o.order_id
	--where o.order_status='delivered'
    GROUP BY c.customer_unique_id, c.customer_city
),
row_num AS
(
    SELECT 
        customer_unique_id,
        customer_city,
        toplam_musteri_sayisi,
        toplam_odeme_mik,
        ROW_NUMBER() OVER (PARTITION BY customer_unique_id ORDER BY toplam_musteri_sayisi DESC, toplam_odeme_mik DESC) AS rn
    FROM customer_city
)
SELECT customer_unique_id, customer_city
FROM row_num
WHERE rn = 1 
Case 3: Satıcı Analizi
Question 1 : 
-Siparişleri en hızlı şekilde müşterilere ulaştıran satıcılar kimlerdir? Top 5 getiriniz. Bu satıcıların order sayıları ile ürünlerindeki yorumlar ve puanlamaları inceleyiniz ve yorumlayınız.

SQL Query:

WITH Top5Sellers AS
(
    SELECT
        s.seller_id,
        s.seller_city,
        AVG(EXTRACT(EPOCH FROM (o.order_delivered_customer_date - o.order_approved_at))) / 3600 AS ort_teslimat_suresi_saat
    FROM
        orders o
    JOIN
        order_items oi ON o.order_id = oi.order_id
    JOIN
        sellers s ON oi.seller_id = s.seller_id
    GROUP BY
        s.seller_id, s.seller_city
    ORDER BY
        AVG(EXTRACT(EPOCH FROM (o.order_delivered_customer_date - o.order_approved_at))) / 3600
    LIMIT 5
)
SELECT
    ts.seller_id,
    ts.seller_city,
    ts.ort_teslimat_suresi_saat,
    ord.review_comment_message,
    ord.review_score,
    COUNT(distinct ord.order_id) AS toplam_siparis_sayisi,
    COUNT(ord.review_comment_message) AS toplam_yorum_sayisi,
    ROUND(AVG(ord.review_score), 2) AS ortalama_puan -- ROUND eklenen kısım
FROM
    Top5Sellers ts
JOIN
    order_items ori ON ori.seller_id = ts.seller_id
LEFT JOIN
    order_reviews ord ON ord.order_id = ori.order_id
GROUP BY
    ts.seller_id, ts.seller_city, ts.ort_teslimat_suresi_saat, ord.review_comment_message, ord.review_score
ORDER BY
    ort_teslimat_suresi_saat DESC

;

--Üstte siparişi en hızlı şekilde müşterilere ulaştıran satıcıları bulduğumuz sorgunun outputu sağlıklı 
--bir sonuç vermeyince, order sayısının en yüksek olduğu satıcıları incelemek istedim
--ve bence böyle çok daha anlamlı ve yorumlanabilir bir çıktı elde ettim. 
--o yüzden bu sorgu üzerinden yorum yaptım.

WITH TopSellers AS
(
    SELECT
        s.seller_id,
        s.seller_city,
        COUNT(DISTINCT o.order_id) AS siparis_sayisi
    FROM
        orders o
    JOIN
        order_items oi ON o.order_id = oi.order_id
    JOIN
        sellers s ON oi.seller_id = s.seller_id
    GROUP BY
        s.seller_id, s.seller_city
    ORDER BY
        siparis_sayisi DESC
    LIMIT 5
)
SELECT
    ts.seller_id,
    ts.seller_city,
    ts.siparis_sayisi,
    COUNT(ord.review_comment_message) AS toplam_yorum_sayisi,
    ROUND(AVG(ord.review_score), 2) AS ortalama_puan, -- 2 ondalık basamak ile yuvarladım.
    ROUND(AVG(EXTRACT(EPOCH FROM (o.order_delivered_customer_date - o.order_approved_at)) / 86400)::numeric, 2) AS ortalama_teslimat_suresi_gun -- 2 ondalık basamak ile yuvarladım.
FROM
    TopSellers ts
JOIN
    order_items oi ON ts.seller_id = oi.seller_id
JOIN
    orders o ON oi.order_id = o.order_id
LEFT JOIN
    order_reviews ord ON o.order_id = ord.order_id
GROUP BY
    ts.seller_id, ts.seller_city, ts.siparis_sayisi
ORDER BY
    ortalama_teslimat_suresi_gun 


--Siparişlerin hızlı bir şekilde müşterilere ulaştırılması üzerine yaptığım analizde, 
--sonuçlar biraz düşündürücüydü. Ortalama teslimat süreleri saatlerle ifade edilecek kadar hızlı gibi görünse de,
--elde edilen sonuçlar pek anlamlı ve gerçekçi değildi. İncelediğim firmaların sadece iki tanesinde yorumlar 
--vardı ve bu yorumlar sadece bir defa yapılmıştı. Üstelik, kötü puan veya olumsuz yorum bulunmuyordu. 
--Ayrıca, sipariş sayısı, yorum sayısı ve iletişim sayısı sadece bir olarak görünüyordu. 
--Bu nedenle, bu çıktının gerçekten anlamlı bir sonuç vermediğini düşünüyorum.

--Bu nedenle, sipariş sayısının en yüksek olduğu satıcıları incelemeye karar verdim ve bu analiz daha anlamlı 
--ve yorumlanabilir sonuçlar verdi. Toplam sipariş sayısı, toplam yorum sayısı ve ortalama puanlar oldukça 
--anlamlıydı. Ortalama puanlar genellikle 5 üzerinden 4 puan civarındaydı. 
--Bu da yapılan yorumların büyük bir kısmının olumlu olduğunu gösteriyor.

--Ortalama teslimat süreleri de daha gerçekçi bir şekilde gün bazında hesaplanmıştı. 
--En hızlı teslimat yapan satıcıların müşterilere ortalama 9 günde ulaştığını gördüm ve 
--bu satıcı aynı zamanda en fazla sipariş sayısına sahipti. Bu, başarılı bir satıcı olduğunu düşündürüyor.

--Ortalama puanlar ve sipariş sayıları arasında çok büyük bir fark olmamasına rağmen, 
--en fazla sipariş alan satıcının aynı zamanda en hızlı teslimatı gerçekleştiren satıcı olduğunu gördüm. 
--Veriler üzerinden daha fazla ayrıntılı yorumlar yapabiliriz, ancak sınırlı süre nedeniyle 
--ilk gözüme çarpanları paylaşmak istedim.


--Question 2 : 
--Hangi satıcılar daha fazla kategoriye ait ürün satışı yapmaktadır? 
--Fazla kategoriye sahip satıcıların order sayıları da fazla mı? 

SQL Query:

--İLK 10 SATICIYI İNCELEDİM

WITH SellerCategoryOrderCounts AS (
    SELECT
        s.seller_id,
        s.seller_city,
        COUNT(DISTINCT p.product_category_name) AS category_count,
        COUNT(DISTINCT oi.order_id) AS order_count
    FROM
        sellers as s
    LEFT JOIN
        order_items oi ON s.seller_id = oi.seller_id
	 LEFT JOIN
        products p ON oi.product_id = p.product_id
    GROUP BY
        s.seller_id, s.seller_city
)
SELECT
    seller_id,
    seller_city,
    category_count,
    order_count
FROM
    SellerCategoryOrderCounts
ORDER BY
    category_count DESC, order_count DESC
limit 10 



--Case 4 : Payment Analizi
--Question 1 : 
--Ödeme yaparken taksit sayısı fazla olan kullanıcılar en çok hangi bölgede yaşamaktadır? Bu çıktıyı yorumlayınız.

SQL Query:

-->1 ŞEKLİNDE TAKSİT SAYILARINA BAKTIĞIMDA MÜŞTERİ SAYISI BİRBİRLERİNEYAKIN DEĞELER ALDIĞI İÇİN
--GENEL OLARAK >1 OLARAK YORUMLAMAK İSTEDİM DATAYI. 

WITH TaksitSayilari AS 
(
    SELECT
        c.customer_id,
        c.customer_city,
	    c.customer_state,
        op.order_id,
       op.payment_installments
    FROM
        customers c
	JOIN
		orders o ON o.customer_id=c.customer_id
    JOIN
        order_payments op ON o.order_id = op.order_id
)

SELECT
    customer_city,
	customer_state,
	payment_installments,
    COUNT(*) AS taksitli_odeme_yapan_musteri_sayisi
FROM
    TaksitSayilari t
WHERE
    t.payment_installments > 1 -- Taksit sayısı 1'den fazla olan ödemeleri filtrele
GROUP BY
    customer_city,
	customer_state,
	payment_installments
ORDER BY
    taksitli_odeme_yapan_musteri_sayisi DESC 
LIMIT 10

--Bu sorguyu incelediğimde, 1'den fazla taksitli ödeme yapan müşterileri odak noktasına alarak sonuçları 
--incelemeye karar verdim. Sonuçlara göre, toplamda 24 taksit yapıldığını gördüm, ancak bu ödemelerin 
--sipariş sayısı oldukça sınırlıydı.

--Ayrıca, çıktılarda São Paulo bölgesindeki müşterilerin en yüksek taksitli siparişleri verdiğini gözlemledim. 
--São Paulo şehrine ait müşterilerin taksitli ödeme yapanların sayısının en fazla olduğunu ve 
--genellikle 2 taksit tercih ettiğini söyleyebilirim.

--İlk 10 veriyi incelediğimde, yine São Paulo şehrinin en fazla sipariş veren bölge olduğunu ve genel olarak 
--2, 3 ve 4 taksit tercih edildiğini gördüm.



--Question 2 : 
--Ödeme tipine göre başarılı order sayısı ve toplam başarılı ödeme tutarını hesaplayınız. 
--En çok kullanılan ödeme tipinden en az olana göre sıralayınız.

--SQL Query:

SELECT
    op.payment_type,
    COUNT( distinct o.order_id) AS basarili_order_sayisi,
    SUM(op.payment_value) AS toplam_basarili_odeme_tutari
FROM
    order_payments op
JOIN
    orders o ON op.order_id = o.order_id
WHERE
    o.order_status =  'invoiced'  --Başarılı ödemeleri filtrele 
GROUP BY
    op.payment_type
ORDER BY
    basarili_order_sayisi DESC



--Question 3 : 
--Tek çekimde ve taksitle ödenen siparişlerin kategori bazlı analizini yapınız. 
--En çok hangi kategorilerde taksitle ödeme kullanılmaktadır?

--SQL Query:

--En çok hangi kategorilerde taksitle ödeme kullanılmaktadır? dendiği için order by olarak 
--‘taksitli_siparis_sayisi’nı desc olarak saydırdım.

--Elde edilen çıktıyı incelediğimizde top5 için yorum yapacak olursak en çok ev eşyaları, 
--güzellik ve bakım, saat, spor-eğlence ürünleri ve mobilya dekor kategorilerinde taksitle ödeme seçeneği
--tercih edilmektedir.


SELECT
    p.product_category_name AS category,
    COUNT(DISTINCT CASE WHEN op.payment_installments = 1 THEN o.order_id END) AS tek_cekim_siparis_sayisi,
    COUNT(DISTINCT CASE WHEN op.payment_installments <> 1 THEN o.order_id  END) AS taksitli_siparis_sayisi
FROM
    order_payments op
JOIN
    order_items oi ON op.order_id = oi.order_id
JOIN
    orders o ON o.order_id = oi.order_id
JOIN
    products p ON p.product_id = oi.product_id
GROUP BY
    p.product_category_name
--ORDER BY
    --p.product_category_name
ORDER BY
    taksitli_siparis_sayisi DESC



--Case 5 : RFM Analizi

--Aşağıdaki e_commerce_data_.csv doyasındaki veri setini kullanarak RFM analizi yapınız. 
--Recency hesaplarken bugünün tarihi değil en son sipariş tarihini baz alınız. 

--SQL Query:

--Recency hesaplanırken en son tarih baz alınarak işlem yapılmıştır.
--Yani tablodaki en yüksek tarih sanki bugünün tarihiymiş gibi düşünülerek işlem yapılmıştır.
--genel tabloda kullanılan query’ler;


select max (invoice_date2) from data_table2
;
--RECENCY
WITH max_invoice as
(
select
	customer_id,
	max(invoice_date2) ::date as max_invoice_date
from
	data_table2
where
	customer_id is not null
group by
	customer_id
)
select 
	customer_id,
	(select max (invoice_date2) from data_table2) ::date - max_invoice_date recency
from max_invoice
;
--FREQUENCY
select
	customer_id,
	count(distinct invoice_no) as frequency
from
	data_table2
where
	invoice_no not like 'C%' and customer_id is not null
group by
	customer_id
;
--MONETARY
select
	customer_id,
	sum(quantity*unit_price) as monetary
from
	data_table2
where
	unit_price>0 and quantity>0 and customer_id is not null --and invoive_no not like 'C%'
group by
	customer_id

;

--GENEL TABLO

with recency as
(
WITH max_invoice as
(
select
	customer_id,
	max(invoice_date2) ::date as max_invoice_date
from
	data_table2
where
	customer_id is not null
group by
	customer_id
)
select 
	customer_id,
	(select max (invoice_date2) from data_table2) ::date - max_invoice_date recency
from max_invoice
)
,
frequency as
(
select
	customer_id,
	count(distinct invoice_no) as frequency
from
	data_table2
where
	invoice_no not like 'C%' and customer_id is not null
group by
	customer_id
)
,
monetary as
(
select
	customer_id,
	sum(quantity*unit_price) as monetary
from
	data_table2
where
	unit_price>0 and quantity>0 and customer_id is not null --and invoive_no not like 'C%'
group by
	customer_id
)
select 
	r.customer_id,recency,frequency,monetary,
	  -- Recency Skoru Hesaplama
        CASE
            WHEN Recency <= 10 THEN 'VIP'
            WHEN Recency <= 40 THEN 'Gold'
            WHEN Recency <= 90 THEN 'Silver'
            ELSE 'Bronze'
        END AS recency_musteri_segmenti,
        -- Frequency Skoru Hesaplama
        CASE
            WHEN Frequency <= 5 THEN 'VIP'
            WHEN Frequency <= 14 THEN 'Gold'
            WHEN Frequency <= 30 THEN 'Silver'
            ELSE 'Bronze'
        END AS frequency_musteri_segmenti,
        -- Monetary Skoru Hesaplama
        CASE
            WHEN Monetary <= 300 THEN 'Bronze'
            WHEN Monetary <= 1000 THEN 'Silver'
            WHEN Monetary <= 5000 THEN 'Gold'
            ELSE 'VIP'
        END AS monetary_musteri_segmenti
from 
	recency r
join
	frequency f on r.customer_id=f.customer_id
join
	monetary m on f.customer_id=m.customer_id


--RFM analizi, müşteri segmentasyonu ve pazarlama stratejileri oluşturmak için yaygın olarak kullanılan 
--güçlü bir araçtır. Bu analiz, müşterilerin satın alma alışkanlıklarına göre gruplara ayrılmasına yardımcı olur.
--RFM analizi sonuçları, şirketlere her bir müşteri segmentinin alışveriş alışkanlıklarını anlamak 
--için önemli bir yol sunar. Bu da pazarlama stratejilerini buna göre uyarlamayı mümkün kılar.

--Günümüzde artık işletmeler, her müşteriye özel kampanyalar ve reklamlar sunmayı hedefliyor. 
--Bu yaklaşımın geri dönüşü daha olumlu ve etkili oluyor. İşte bu nedenle RFM analizi büyük bir öneme sahiptir.

--Ben de müşterilerimi VIP, Gold, Silver ve Bronz gibi kategorilere ayırdım. Bu segmentasyon sonuçlarına dayalı 
--olarak her bir kategori için farklı pazarlama stratejileri belirlenebilecektir. 

--Örneğin, VIP müşteriler; son alışverişlerini son zamanlarda yapmış, sık sık alışveriş yapmış ve 
--yüksek tutarlı alışverişler yapmışlardır. Bu müşterilere özel teklifler, özel hizmetler ve ödüller sunarak 
--onların sadakatini pekiştirmek hedeflenebilir.

--Gold müşteriler; VIP müşterilere benzer şekilde yakın zamanda alışveriş yapmış ve ortalama sıklıkta 
--alışveriş yapmışlardır. Onlara da özel fırsatlar sunarak sadakatlerini artırmkı amaçlanabilir.

--Silver müşteriler; biraz daha önce alışveriş yapmış, ortalama sıklıkta alışveriş yapmış ve 
--ortalama tutarlı alışverişler yapmışlardır. Bu segmentteki müşterilere daha fazla teşvik ve 
--özel teklifler sunmak istenebilir.

--Son olarak, Bronze  müşteriler; son alışverişlerini biraz önce yapmış, düşük sıklıkta alışveriş yapmış 
--ve ortalama veya daha düşük tutarlı alışverişler yapmışlardır. Bu müşterileri daha fazla ilgi ve 
--teşvikle aktifleştirmek, ona göre uygun kampanyalar çıkmak  hedeflenebilir.

--Her bir müşteri segmentinin özel ihtiyaçları ve davranışları bulunmaktadır. 
--Bu nedenle her segment için özelleştirilmiş pazarlama stratejileri geliştirmek, müşteri memnuniyetini artırmak 
--ve başarıyı garantilemek için çok önemlidir.