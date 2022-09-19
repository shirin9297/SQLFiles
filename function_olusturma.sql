--Function olusturma
--1. Ornek : Iki parametre ile calisip bu parametreleri toplayarak return yapan bir fonksiyon olusturun.


CREATE OR REPLACE FUNCTION toplamaF(x NUMERIC, y NUMERIC)
RETURNS NUMERIC
LANGUAGE plpgsql
AS
$$
 BEGIN
 RETURN x+y;
 END
$$

select * from toplamaF(15,25) AS toplam;