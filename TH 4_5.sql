--   __   __  _                    _        __               
--   \ \ / / (_)                  | |       \_\              
--    \ V /   _   _ __       ___  | |__     __ _    ___      
--     > <   | | | '_ \     / __| | '_ \   / _` |  / _ \     
--    / . \  | | | | | |   | (__  | | | | | (_| | | (_) |    
--   /_/_\_\ |_| |_| |_|    \___| |_| |_|  \__,_|  \___/ 
--
--    _____                    __      __              _
--   |_   _| ( )               \ \    / / (_)         | |    
--     | |   |/   _ __ ___      \ \  / /   _   _ __   | |__  
--     | |       | '_ ` _ \      \ \/ /   | | | '_ \  | '_ \ 
--    _| |_      | | | | | |      \  /    | | | | | | | | | |
--   |_____|     |_| |_| |_|       \/     |_| |_| |_| |_| |_|
--                                          
-- Contact: vn.ncvinh@gmail.com                                         
-- Facebook: facebook.com/vn.ncvinh
-- Github: github.com/vnncv





-- Bài 1. Cho biết thông tin về các chuyến bat đi Đà Lạt (DAD) 
	use Airplane_Manage
	select *
	from CHUYENBAY
	where GaDi='DAD'
	
-- Bài 2. Cho biết thông tin về các loại máy bay có tầm bay lớn hơn 10.000 km. 
	use Airplane_Manage
	select *
	From MAYBAY
	where TamBay > 10000

-- Bài 3. Cho biết thông tin về các nhân viên có lương nhỏ hơn 10000 
	use Airplane_Manage
	select *
	from NHANVIEN
	where Luong<10000

-- Bài 4. Cho biết thông tin về các chuyến bay có độ dài đường bay nhỏ hơn 10000km và lớn hơn 8000km 
	use Airplane_Manage
	select *
	from CHUYENBAY
	where DoDai between 8000 and 10000

-- Bài 5. Cho biết thông tin về các chuyến bay xuất phát từ Sài Gòn (SGN) đi Ban Mê Thuột (BMV) 
	use Airplane_Manage
	select *
	from CHUYENBAY
	where GaDi='SGN' and GaDen='BMV'

-- Bài 6. Có bao nhiêu chuyến bay xuất phát từ Sài Gòn (SGN) 
	use Airplane_Manage
	select count(MaCB) as N'Số chuyến bay từ Sài Gòn'
	from CHUYENBAY
	where GaDi='SGN'

-- Bài 7. Có bao nhiêu loại máy bay Boeing 
	use Airplane_Manage
	select count(MaMB) as N'Số Loại Máy Bay Boeing'
	From MAYBAY
	where Loai like 'Boeing %'

-- Bài 8. Cho biết tổng số lương phải trả cho các nhân viên 
	use Airplane_Manage
	select sum(Luong) as N'Tổng Lương'
	from NHANVIEN

-- Bài 9. Cho biết mã số và tên của các phi công lái máy bay Boeing 
	use Airplane_Manage
	select NHANVIEN.MaNV as 'Mã NV', NHANVIEN.Ten As 'Tên'
	From NHANVIEN, CHUNGNHAN, MAYBAY
	where NHANVIEN.MaNV=CHUNGNHAN.MaNV and CHUNGNHAN.MaMB=MAYBAY.MaMB and MAYBAY.Loai like 'Boeing %'
	group by NHANVIEN.MaNV, NHANVIEN.Ten

-- Bài 10. Cho biết mã số và tên của các phi công có thể lái được máy bay có mã số là 747 
	use Airplane_Manage
	select NHANVIEN.MaNV as 'Mã NV', NHANVIEN.Ten As 'Tên'
	From NHANVIEN, CHUNGNHAN
	where NHANVIEN.MaNV=CHUNGNHAN.MaNV and CHUNGNHAN.MaMB=747

-- Bài 11. Co biết mã số của các loại máy bay mà nhân viên có họ Nguyễn có thể lái 
	use Airplane_Manage
	select CHUNGNHAN.MaMB as N'Mã MB'
	from NHANVIEN, CHUNGNHAN
	where NHANVIEN.MaNV = CHUNGNHAN.MaNV and NHANVIEN.Ten like N'Nguyen %'

-- Bài 12. Cho biết mã số của các phi công vừa lái được Boeing vừa lại được Airbus A320 
	use Airplane_Manage
	select CHUNGNHAN.MaNV as N'Mã NV'
	From CHUNGNHAN, MAYBAY
	where CHUNGNHAN.MaMB=MAYBAY.MaMB and (MAYBAY.Loai like 'Boeing %' or MAYBAY.Loai = 'Airbus A320')
	group by CHUNGNHAN.MaNV

-- Bài 13. Cho biết các loại máy bay có thể thực hiện được chuyến bay VN280 
	use Airplane_Manage
	Select Loai
	From MAYBAY
	where TamBay>=(select DoDai from CHUYENBAY where MaCB='VN280')
	group by Loai

-- Bài 14. Cho biết các chuyến bay có thể thực hiện bởi máy bay Airbus A320 
	use Airplane_Manage
	Select MaCB
	from CHUYENBAY
	where DoDai <= (select TamBay from MAYBAY where Loai='Airbus A320')
	group by MaCB

-- Bài 15. Cho biết tên của các phi công lái máy bay Boeing 
	use Airplane_Manage
	select NHANVIEN.Ten as N'Nhân Viên Có thể lái Boeing'
	from NHANVIEN, CHUNGNHAN, MAYBAY
	where NHANVIEN.MaNV=CHUNGNHAN.MaNV and CHUNGNHAN.MaMB=MAYBAY.MaMB and MAYBAY.Loai like 'Boeing %'
	group by NHANVIEN.Ten

-- Bài 16. Với mỗi loại máy bay có phi công lái, cho biết mã số, loại máy bay và tổng số phi công có thể lái loại máy bay đó 
	use Airplane_Manage
	Select MAYBAY.MaMB As N'Mã Số', MAYBAY.Loai As N'Loại MB', count (NHANVIEN.MaNV) as N'Số Phi Công Có thể lái'
	from MAYBAY, NHANVIEN, CHUNGNHAN
	where MAYBAY.MaMB=CHUNGNHAN.MaMB and CHUNGNHAN.MaNV=NHANVIEN.MaNV
	group by MAYBAY.MaMB, MAYBAY.Loai

-- Bài 17. Giả sử một hành khách muốn đi thẳng từ ga A đến ga B rồi quay trở về ga A. Cho biết các đường bay nào có thể đáp ứng yêu cầu này. 
	

-- Bài 18. Với mỗi ga có chuyến bay xuất phát từ đó, cho biết có bao nhiêu chuyến bay khởi hành từ ga đó 
	use Airplane_Manage
	select gadi, count(gadi) as 'So chuyen bay'
	from chuyenbay
	group by GaDi

-- Bài 19. Với mỗi ga có chuyến bay xuất phát từ đó, cho biết tổng chi phí phải trả chi phi công lái các chuyến bay khởi hành từ ga đó. 
	use Airplane_Manage
	select GaDi, sum(ChiPhi) as 'Tong Chi Phi't
	from CHUYENBAY
	group by GaDi

-- Bài 20. Với mỗi ga xuất phát, cho biết có bao nhiêu chuyến bay có thể khởi hành trước 12:00  
	use Airplane_Manage
	select GaDi, count(MaCB) as 'Tong CB'
	from CHUYENBAY
	where GioDi < '12:00:00'
	group by GaDi

-- Bài 21. Cho biết mã số của phi công chỉ lái được 3 loại máy bay 
	use Airplane_Manage
	select NHANVIEN.MaNV
	from NHANVIEN, CHUNGNHAN
	where NHANVIEN.MaNV=CHUNGNHAN.MaNV
	group by NHANVIEN.MaNV
	HAVING count(CHUNGNHAN.MaMB) = 3

-- Bài 22. Với mỗi phi công có thể lái nhiều hơn 3 loại máy bay, cho biết mã số phi công và tầm bay lớn nhất của các loại máy bay mà phi công đó có thể lái 
	use Airplane_Manage
	select NHANVIEN.MaNV, NHANVIEN.Ten, MAX(MAYBAY.TamBay) as 'Tam Bay Lon Nhat'
	from NHANVIEN, CHUNGNHAN, MAYBAY
	where NHANVIEN.MaNV=CHUNGNHAN.MaNV and CHUNGNHAN.MaMB=MAYBAY.MaMB
	group by NHANVIEN.MaNV, NHANVIEN.Ten
	HAVING count(CHUNGNHAN.MaMB) > 3

-- Bài 23. Cho biết mã số của các phi công có thể lái được nhiều loại máy bay nhất 
	use Airplane_Manage
	select MaNV
	from CHUNGNHAN
	group by MaNV
	having count(MaMB) >= All(select count(MaNV) from CHUNGNHAN group by MaNV)

-- Bài 24. Cho biết mã số của các phi công có thể lái được ít loại máy bay nhất. 
	use Airplane_Manage
	select MaNV
	from CHUNGNHAN
	group by MaNV
	having count(MaMB) <= All(select count(MaNV) from CHUNGNHAN group by MaNV)

-- Bài 25. Tìm các nhân viên không phải là phi công 
	use Airplane_Manage
	select NHANVIEN.MaNV, NHANVIEN.Ten, NHANVIEN.Luong
	from CHUNGNHAN right join NHANVIEN
	on CHUNGNHAN.MaNV=NHANVIEN.MaNV
	group by NHANVIEN.MaNV, NHANVIEN.Ten, NHANVIEN.Luong
	having count(CHUNGNHAN.MaMB) = 0

-- Bài 26. Cho biết mã số của các nhân viên có lương cao nhất 
	use Airplane_Manage
	select MaNV, Luong
	from NHANVIEN
	group by MaNV, Luong
	having Luong = (select Max(Luong) from NHANVIEN)

-- Bài 27. Cho biết tổng số lương phải trả cho các phi công 
	use Airplane_Manage
	select sum(Luong) as 'Tong luong'
	from NHANVIEN

-- Bài 28. Tìm các chuyến bay có thể được thực hiện bởi tất cả các loại máy bay Boeing 
	use Airplane_Manage
	select MaCB
	from CHUYENBAY
	group by MaCB, DoDai
	having DoDai <= (select min(TamBay) from MAYBAY where Loai like 'Boeing %')

-- Bài 29. Cho biết mã số của các máy bay có thể được sử dụng để thực hiện chuyến bay từ Sài gòn (SGN) đến Huế (HUI) 
	use Airplane_Manage
	select MaMB, Loai
	from MAYBAY
	group by MaMB,Loai, TamBay
	having TamBay >= (select DoDai from CHUYENBAY where GaDi='SGN' and GaDen='HUI')

-- Bài 30. Tìm các chuyến bay có thể được lái bởi các phi công có lương lớn hơn 100.000 
	use Airplane_Manage
	select MaCB, GaDi, GaDen
	from CHUYENBAY
	group by MaCB, GaDi, GaDen, DoDai
	having DoDai<=All(select MAYBAY.TamBay from MAYBAY,NHANVIEN,CHUNGNHAN where NHANVIEN.MaNV=CHUNGNHAN.MaNV and CHUNGNHAN.MaMB=MAYBAY.MaMB and NHANVIEN.Luong>100000)
	
-- Bài 31. Cho biết tên các phi công có lương nhỏ hơn chi phí thấp nhất của đường bay từ Sài Gòn (SGN) đến Buôn mê Thuột (BMV) 
	use Airplane_Manage
	select NHANVIEN.Ten
	from NHANVIEN, CHUNGNHAN, MAYBAY
	where NHANVIEN.MaNV=CHUNGNHAN.MaNV and CHUNGNHAN.MaMB=MAYBAY.MaMB
	group by NHANVIEN.Ten, NHANVIEN.Luong, MAYBAY.TamBay
	having NHANVIEN.Luong < (select min(CHUYENBAY.ChiPhi) from CHUYENBAY where GaDi='SGN' and GaDen='BMV')

-- Bài 32. Cho biết mã số của các phi công có lương cao nhất 
	use Airplane_Manage
	select MaNV, Luong
	from NHANVIEN
	group by MaNV, Luong
	having Luong = (select Max(Luong) from NHANVIEN)

-- Bài 33. Cho biết mã số của các nhân viên có lương cao thứ nhì 
	use Airplane_Manage
	select MaNV, Luong
	from NHANVIEN
	group by MaNV, Luong
	having Luong = (select Max(Luong) from NHANVIEN where luong < (select Max(Luong) from NHANVIEN))


-- Bài 34. Cho biết mã số của các phi công có lương cao nhất hoặc thứ nhì 
	use Airplane_Manage
	select MaNV, Luong
	from NHANVIEN
	group by MaNV, Luong
	having Luong >= (select Max(Luong) from NHANVIEN where luong < (select Max(Luong) from NHANVIEN))


-- Bài 35. Cho biết tên và lương của các nhân viên không phải là phi công và có lương lớn hơn lương trung bình của tất cả các phi công. 
	use Airplane_Manage
	select NHANVIEN.Ten, NHANVIEN.Luong
	from CHUNGNHAN right join NHANVIEN
	on CHUNGNHAN.MaNV=NHANVIEN.MaNV
	group by NHANVIEN.Ten, NHANVIEN.Luong
	having count(CHUNGNHAN.MaMB) = 0 and NHANVIEN.Luong > (select avg(Luong) from NHANVIEN where MaNV in (select NHANVIEN.MaNV from NHANVIEN, CHUNGNHAN where NHANVIEN.MaNV=CHUNGNHAN.MaNV group by NHANVIEN.MaNV))

-- Bài 36. Cho biết tên các phi công có thể lái các máy bay có tầm bay lớn hơn 4.800km nhưng không có chứng nhận lái máy bay Boeing 
	use Airplane_Manage
	select NHANVIEN.Ten
	from NHANVIEN, CHUNGNHAN, MAYBAY
	where NHANVIEN.MaNV=CHUNGNHAN.MaNV and CHUNGNHAN.MaMB=MAYBAY.MaMB and MAYBAY.Loai not like 'Boeing%' and MAYBAY.TamBay>4800
	group by NHANVIEN.Ten

-- Bài 37. Cho biết tên các phi công lái ít nhất 3 loại máy bay có tầm xa hơn 3200km 
	use Airplane_Manage
	select NHANVIEN.Ten
	from NHANVIEN, CHUNGNHAN, MAYBAY
	where NHANVIEN.MaNV=CHUNGNHAN.MaNV and CHUNGNHAN.MaMB=MAYBAY.MaMB and MAYBAY.TamBay>3200
	group by NHANVIEN.Ten
	having count(MAYBAY.MaMB) >= 3

-- Bài 38. Với mỗi nhân viên cho biết mã số, tên nhân viên và tổng số loại máy bay mà nhân viên đó có thể lái 
	use Airplane_Manage
	select NHANVIEN.MaNV, NHANVIEN.Ten, count(CHUNGNHAN.MAMB) as 'Tong may bay co the lai'
	from NHANVIEN left join CHUNGNHAN
	on NHANVIEN.MaNV=CHUNGNHAN.MaNV
	group by NHANVIEN.MaNV, NHANVIEN.Ten

-- Bài 39. Với mỗi nhân viên, cho biết mã số, tên nhân viên và tổng số loại máy bay Boeing mà nhân viên đó có thể lái 
	use Airplane_Manage
	select NHANVIEN.MaNV, NHANVIEN.Ten, count(CHUNGNHAN.MAMB) as 'Tong may bay co the lai'
	from NHANVIEN left join CHUNGNHAN
	on NHANVIEN.MaNV=CHUNGNHAN.MaNV left join MAYBAY on CHUNGNHAN.MaMB=MAYBAY.MaMB and MAYBAY.Loai like 'Boeing%'
	group by NHANVIEN.MaNV, NHANVIEN.Ten

-- Bài 40. Với mỗi loại máy bay,  cho biết loại máy bay và tổng số phi công có thể lái loại máy bay đó. 
	use Airplane_Manage
	select MAYBAY.MaMB, MAYBAY.Loai, Count(CHUNGNHAN.MaNV) as 'So Phi Cong Co The Lai'
	from MAYBAY left join CHUNGNHAN
	on MAYBAY.MaMB=CHUNGNHAN.MaMB
	Group by MAYBAY.MaMB, MAYBAY.Loai

-- Bài 41. Với mỗi loại máy bay, cho biết loại máy bay và tổng số chuyến bay không thể thực hiện bởi loại máy bay đó. 
	use Airplane_Manage
	select MAYBAY.Loai, COUNT(CHUYENBAY.MaCB) as 'So Chuyen Khong The Thuc Hien'
	from MAYBAY left join CHUYENBAY
	on MAYBAY.TamBay<CHUYENBAY.DoDai
	group by MAYBAY.Loai

-- Bài 42. Với mỗi loại máy bay, hãy cho biết loại máy bay và tổng số phi công có lương lớn hơn 100.000 có thể lái loại máy bay đó. 
	use Airplane_Manage
	select MAYBAY.Loai,count(NHANVIEN.MaNV)
	from MAYBAY left join CHUNGNHAN on MAYBAY.MaMB=CHUNGNHAN.MaMB left join NHANVIEN on CHUNGNHAN.MaNV = NHANVIEN.MaNV and NHANVIEN.Luong>100000
	group by MAYBAY.Loai

-- Bài 43. Với mỗi loại máy bay có tầm bay trên 3200km, cho biết tên của loại máy bay và lương trung bình của các phi công có thể lái loại máy bay đó. 
	use Airplane_Manage
	select NHANVIEN.MaNV
	from MAYBAY, CHUNGNHAN, NHANVIEN
	where MAYBAY.MaMB=CHUNGNHAN.MaMB and CHUNGNHAN.MaNV=NHANVIEN.MaNV and MAYBAY.TamBay>3200
	group by MAYBAY.Loai

-- Bài 44. Với mỗi loại máy bay  hãy cho biết loại máy bay và tổng số nhân viên không thể lái loại máy bay đó 
	use Airplane_Manage
	select MAYBAY.MaMB, (select count(MaNV) from NHANVIEN)- count(CHUNGNHAN.MaNV) as 'So NV khong the lai'
	from CHUNGNHAN, MAYBAY
	where CHUNGNHAN.MaMB=MAYBAY.MaMB
	group by MAYBAY.MaMB

-- Bài 45. Với mỗi loại máy bay  hãy cho biết loại máy bay và tổng số phi công không thể lái loại máy bay đó. 
	use Airplane_Manage
	select MAYBAY.MaMB, (select count(manv) from NHANVIEN where MaNV in (select NHANVIEN.MaNV from NHANVIEN, CHUNGNHAN where NHANVIEN.MaNV=CHUNGNHAN.MaNV group by NHANVIEN.MaNV))- count(CHUNGNHAN.MaNV) as 'So NV khong the lai'
	from CHUNGNHAN, MAYBAY
	where CHUNGNHAN.MaMB=MAYBAY.MaMB
	group by MAYBAY.MaMB


-- Bài 46. Với mỗi nhân viên, cho biết mã số, tên nhân viên và tổng số chuyến bay xuất phát từ Sài Gòn mà nhân viên đó không thể lái
	

-- Bài 47. Với mỗi phi công, cho biết mã số, tên phi công và tổng số chuyến bay xuất phát từ Sài Gòn mà phi công đó có thể lái 

-- Bài 48. Với mỗi chuyến bay, hãy cho biết mã số chuyến bay và tổng số loại máy bay có thể thực hiện chuyến bay đó 
	use Airplane_Manage
	select CHUYENBAY.MaCB, count(MAYBAY.MaMB)
	from CHUYENBAY, MAYBAY
	where CHUYENBAY.DoDai < MAYBAY.TamBay
	group by CHUYENBAY.MaCB

-- Bài 49. Với mỗi chuyến bay, cho biết mã số chuyến bay và tổng số phi công không thể lái chuyến đó. 
	
-- Bài 50. Một hành khách muốn đi từ Hà Nội (HAN) đến nha trang (CXR) mà không phải đổi chuyến bay quá một lần. Cho biết mã chuyếnbay, thời gian khời hành từ Hà nội nếu hành khách muốn đến Nha Trang trước 16:00 
	
-- Bài 51. Cho biết thông tin của các đường bay mà tất cả các phi công có thể bay trên đường bay đó đều có lương lớn hơn 100000 
	use Airplane_Manage
	select CHUYENBAY.MaCB, CHUYENBAY.GaDi, CHUYENBAY.GaDen
	from CHUYENBAY, NHANVIEN, CHUNGNHAN, MAYBAY
	where NHANVIEN.MaNV=CHUNGNHAN.MaNV and CHUNGNHAN.MaMB=MAYBAY.MaMB and MAYBAY.TamBay>=CHUYENBAY.DoDai
	group by CHUYENBAY.MaCB, CHUYENBAY.GaDi, CHUYENBAY.GaDen
	having min(NHANVIEN.Luong)>100000

-- Bài 52. Cho biết tên các phi công chỉ lái các loại máy bay có tầm xa hơn 3200km và một trong số đó là Boeing 
	use Airplane_Manage
	select NHANVIEN.Ten
	from NHANVIEN, CHUNGNHAN, MAYBAY
	where NHANVIEN.MaNV=CHUNGNHAN.MaNV and CHUNGNHAN.MaMB=MAYBAY.MaMB and MAYBAY.TamBay > 3200 and MAYBAY.Loai like 'Boeing%'
	group by NHANVIEN.Ten

-- Bài 53. Tìm các phi công có thể lái tất cả các loại máy bay Boeing.
	use Airplane_Manage
	select NHANVIEN.MaNV, NHANVIEN.Ten
	from NHANVIEN, CHUNGNHAN, MAYBAY
	where NHANVIEN.MaNV=CHUNGNHAN.MaNV and CHUNGNHAN.MaMB=MAYBAY.MaMB and MAYBAY.Loai like 'Boeing%'
	group by NHANVIEN.MaNV, NHANVIEN.Ten
	having count(MAYBAY.MAMB)=(select count(MaMB) from MAYBAY where Loai like 'Boeing%')
