DROP DATABASE IF EXISTS MovieEngagement;

CREATE DATABASE MovieEngagement;
USE MovieEngagement;

CREATE TABLE IF NOT EXISTS Customer(
		customer_id int(11) unique auto_increment not null,
        name nvarchar(30) not null,
        customer_email nvarchar(50) not null,
        customer_phone nvarchar(15) not null,
        user_name nvarchar(50) not null,
        password varchar(50) not null,
        account_bank varchar(20) not null,
        birthday date not null,
        address nvarchar(200) not null,
        sex nvarchar(3) not null,
        register_date datetime not null default current_timestamp()
);

-- Select * from Customer where customer_id = 1;
-- Select count(*) as NumberOfCustomer From Customer  where customer_email = 'valentinolivgr@gmail.com' and password = '123456';   

CREATE TABLE IF NOT EXISTS Movies(
		movie_id int(11) unique auto_increment not null,
        movie_name nvarchar(50) unique not null,
        actor nvarchar(255) not null,
        producers nvarchar(160) not null,
        director nvarchar(80) not null,
        genre nvarchar(50) not null,
        duration int(5) not null,
        detail_movie nvarchar(5000) not null,
        release_date date not null
);


CREATE TABLE IF NOT EXISTS Rooms(
		room_id int(11) unique auto_increment not null,
        name varchar(50) not null unique,
        number_of_seats int(100) not null
);


CREATE TABLE IF NOT EXISTS Schedules(
		schedule_id int(11) unique auto_increment not null,
        movie_id int(11) not null,
        room_id int(11) not null,
        show_date date not null,
        start_time time not null,
        end_time time not null,
        price decimal(10,2) not null,
        
        FOREIGN KEY (movie_id) REFERENCES Movies(movie_id) ON DELETE CASCADE,
        FOREIGN KEY (room_id) REFERENCES Rooms(room_id) ON DELETE CASCADE
);

CREATE UNIQUE INDEX IDX_SCHEDULE ON Schedules(room_id,show_date,start_time,end_time);

CREATE TABLE IF NOT EXISTS PriceSeat(
		price_id int(11) unique auto_increment not null,
        price_name nvarchar(10) not null,
        price decimal(10,2) not null 
);

CREATE TABLE IF NOT EXISTS SeatReserved(
		seat_reserved_id int(11) unique auto_increment not null,
        room_id int(11) not null,
        schedule_id int(11) not null,
        seatreserved varchar(3) not null,
        FOREIGN KEY (room_id) REFERENCES Rooms(room_id) ON DELETE CASCADE,
        FOREIGN KEY (schedule_id) REFERENCES Schedules(schedule_id) ON DELETE CASCADE
);


CREATE TABLE IF NOT EXISTS Reservation(
		reservation_id int(11) unique auto_increment not null,
        customer_Id int(11) not null,
        schedule_id int(11) not null,
        no_of_seat varchar(5) not null,
        price_id int(11) not null,
        price decimal(10,2) not null,
        create_on datetime not null default current_timestamp(),
        FOREIGN KEY (customer_Id) REFERENCES Customer(customer_id) ON DELETE CASCADE,
        FOREIGN KEY (schedule_id) REFERENCES Schedules(schedule_id) ON DELETE CASCADE,
        FOREIGN KEY (price_id) REFERENCES PriceSeat(price_id) ON DELETE CASCADE
);

INSERT INTO PriceSeat(price_name,price) VALUE 
('Ghế thường','45000.00'),
('Ghế Vip','60000.00');

-- Insert data for the table Customer

INSERT INTO Customer (name,customer_email,customer_phone,user_name,password,birthday,address,sex,account_bank) VALUE 
('Trần Mạnh Đạt', 'valentinolivgr@gmail.com','0988968289','Đạt Liv','123456','1997-11-20','Hưng Yên, Việt Nam','Nam','09898928181822');

-- Insert data for the table Movies

INSERT INTO Movies(movie_name,actor,producers,director,genre,duration,detail_movie,release_date) VALUE 
('HARRY POTTER','Harry Potter - Hermione Granger - Ron Weasley ...','Warner Bros., Heyday Films, 1492 Pictures','Chris Columbus',N'Phim viễn tưởng,Phim phiêu lưu','118',
N'Những cuộc phiêu lưu tập trung vào cuộc chiến của Harry Potter trong việc chống lại tên Chúa tể hắc ám Voldemort - người có tham vọng muốn trở nên bất tử, thống trị thế giới phù thủy,  nô dịch hóa những người phi pháp thuật và tiêu diệt những ai cản đường hắn đặc biệt là Harry Potter.','2018-07-20');

INSERT INTO Movies(movie_name,actor,producers,director,genre,duration,detail_movie,release_date) VALUE 
(N'GIA ĐÌNH SIÊU NHÂN','Samuel L. Jackson, Sophia Bush, Holly Hunter','Pixar Animation Studios, Walt Disney Pictures','Brad Bird',N'Phim hoạt hình','132',
N'Gia Đình Siêu Nhân đánh dấu những chuyến phiêu lưu anh hùng    đầy hấp dẫn với sự đổi vai đầy táo bạo. Lần này,mẹ dẻo Helen (Elastigirl) sẽ đi thực chiến giải cứu thế giới trong khi bố khỏe Bob (Mr. Incredible) lùi về hậu phương trông nom những  đứa con siêu nhân láu lỉnh. ','2018-07-15');

INSERT INTO Movies(movie_name,actor,producers,director,genre,duration,detail_movie,release_date) VALUE 
('THẾ GIỚI KHỦNG LONG','Bryce Dallas Howard, Chris Pratt, Jeff Goldblum,..','Amblin Entertainment, Apaches Entertainment','J.A. Bayona','Phim hành động, phiêu lưu, giả tưởng','128',
'Bốn năm sau thảm họa Công Viên kỷ Jura bị hủy diệt. Một vài    con khủng  long vẫn còn sống sót trong khi hòn đảo Isla      Nublar bị con người bỏ hoang.Owen và Claire quyết định tiến  hành chiến dịch giải cứu những con khủng long còn sống sót   khỏi sự tuyệt chủng khi ngọn núi lửa tại khu vực này bắt đầu hoạt động trở lại. Họ vô tình khám phá ra một âm mưu có thể  khiến toàn bộ hành tinh đối mặt với một hiểm họa to lớn chưa từng thấy kể từ thời tiền sử.','2018-07-20');

INSERT INTO Movies(movie_name,actor,producers,director,genre,duration,detail_movie,release_date) VALUE 
('BIỆT ĐỘI CÚN CƯNG','Alan Cumming, Natasha Lyonne, Will Arnett','Alan Cumming, Natasha Lyonne, Will Arnett','Raja Gosnell','Hài Hước, Phiêu Lưu, Gia Đình','92',
'Đặc vụ FBI Frank bất đắc dĩ phải trở thành cộng sự với chú chó Max để cùng triệt phá đường dây buôn lậu động vật. Cùng với  sự giúp sức của biệt đội cún cưng, họ đã cùng nhau trải qua  những tình huống dở khóc dở cười.  Liệu bọn họ có hoàn thành nhiệm vụ một cách thành công? Hãy cùng theo dõi hành trình   phá án của Frank và các chú chó này nhé.','2018-07-20');

INSERT INTO Movies(movie_name,actor,producers,director,genre,duration,detail_movie,release_date) VALUE 
('EM GÁI MƯA','Mai Tài Phến, Lê Thùy Linh, Phương Anh Đào...','LOOTES','Kawaii Tuấn Anh','Học đường, tâm lý, lãng mạn','102',
'Em Gái Mưa lấy bối cảnh những năm đầu 2000 về Nguyễn Hà Vy     (Thùy Linh), cô nữ sinh và nhóm bạn thân lớp 12A1 trường     trung học Thanh Xuân gồm lớp trưởng đẹp trai Tuấn Nam, cặp   đôi oan gia Khánh Chi (Trang Hí), Mạnh Hiếu,anh chàng chuyên gia “đâm bể xuồng" Tuấn Nam... Hà Vy tưởng chừng như sẽ “kết thúc thời học sinh trong nhạt nhẽo”mà không có lấy cho riêng mình một kỷ niệm sâu sắc nào thì bỗng gặp được thầy giáo     Minh Vũ (Mai Tài Phến) điển trai có nụ cười tỏa nắng trong   đoàn giáo sinh thực tập.','2018-07-15');


INSERT INTO Movies(movie_name,actor,producers,director,genre,duration,detail_movie,release_date) VALUE 
('GIÀNH ANH TỪ BIỂN','Shailene Woodley, Sam Claflin, Jeffrey Thomas...','Elizabeth Hawthorne','Baltasar Kormákur','Tâm Lý, Tình cảm','120',
'Tới Tahiti để theo đuổi những chuyến phiêu lưu, Tami Oldham    nhanh chóng phải lòng chàng thủy thủ Richard Sharp và cả hai thực hiện chuyến du lịch mơ ước xuyên Thái Bình Dương. Nhưng cả hai không ngờ rằng họ sẽ đi thẳng vào một cơn bão thảm    khốc nhất trong lịch sử. Sau cơn bão, Richard bị thương nặng còncon thuyền đã bị phá tan. Không có cơ hội được cứu, Tami  phải tìm lấy sức mạnh và lòng quyết tâm để cứu lấy bản thân  và người đàn ông duy nhất cô từng yêu. ','2018-07-08');


INSERT INTO Movies(movie_name,actor,producers,director,genre,duration,detail_movie,release_date) VALUE 
('GIẢI CỨU CÔNG CHÚA','Nadiya Dorofeeva, Oleksiy Zavhorodn','Chernomor','Oleh Malamuzh','Hoạt hình','120',
'Cứ mỗi trăm năm, lão phù thủy độc ác Chernomor lại bắt cóc một nàng công chúa, nhưng lần này nàng công chúa Mila chẳng phải dạng vừa. Hơn nữa, nàng còn có người yêu là hiệp sĩ Ruslan   dũng cảm, mèo bự biến hình, chuột hamster thông minh, chim   hoàng yến gan dạ ... Nào cùng lên đường GIẢI CỨU CÔNG CHÚA.','2018-07-18');

INSERT INTO Movies(movie_name,actor,producers,director,genre,duration,detail_movie,release_date) VALUE 
('BẪY THỜI GIAN','Cassidy Erin Gifford, Reiley McClendon','ABCD','Mark Dennis','Khoa học viễn tưởng','83',
'Bẫy Thời Gian - Time Trap phim kể về một giáo sư khảo cổ gặp   nạn khi đang đi tìm tung tích bố mẹ và em gái. Một nhóm sinh viên quyết định đi tìm thầy và họ rơi vào hang động kỳ quái. Câu chuyện giờ đây mới bắt đầu với nhiều bí ẩn và kịch tính  đan xen.','2018-07-20');


-- Insert data for the table Rooms

INSERT INTO Rooms(name,number_of_seats) VALUE 
('A1','100'),('A2','80'),('A3','100'),('A4','100'),('A5','100'),('A6','100'),('A7','100'),('A8','100');

-- Insert data for the table Schedules date 20 - 21 - 22 day to room A1 A2 A3 A4 A5 A6 A7 A8
INSERT INTO Schedules(movie_id,room_id,show_date,start_time,end_time,price) VALUE
('1','1','2018-07-20','08:00:00','10:00:00','45000'),
('1','1','2018-07-20','10:00:00','12:00:00','45000'),
('1','1','2018-07-20','13:00:00','15:00:00','45000'),
('1','1','2018-07-20','15:00:00','17:00:00','45000'),
('1','1','2018-07-20','17:00:00','19:00:00','45000'),
('1','1','2018-07-20','19:00:00','21:00:00','45000'),
('1','1','2018-07-20','21:00:00','23:00:00','45000'),
('1','1','2018-07-21','08:00:00','10:00:00','45000'),
('1','1','2018-07-21','10:00:00','12:00:00','45000'),
('1','1','2018-07-21','13:00:00','15:00:00','45000'),
('1','1','2018-07-21','15:00:00','17:00:00','45000'),
('1','1','2018-07-21','17:00:00','19:00:00','45000'),
('1','1','2018-07-21','19:00:00','21:00:00','45000'),
('1','1','2018-07-21','21:00:00','23:00:00','45000'),
('1','1','2018-07-22','08:00:00','10:00:00','45000'),
('1','1','2018-07-22','10:00:00','12:00:00','45000'),
('1','1','2018-07-22','13:00:00','15:00:00','45000'),
('1','1','2018-07-22','15:00:00','17:00:00','45000'),
('1','1','2018-07-22','17:00:00','19:00:00','45000'),
('1','1','2018-07-22','19:00:00','21:00:00','45000'),
('1','1','2018-07-22','21:00:00','23:00:00','45000'),
('1','1','2018-07-23','08:00:00','10:00:00','45000'),
('1','1','2018-07-23','10:00:00','12:00:00','45000'),
('1','1','2018-07-23','13:00:00','15:00:00','45000'),
('1','1','2018-07-23','15:00:00','17:00:00','45000'),
('1','1','2018-07-23','17:00:00','19:00:00','45000'),
('1','1','2018-07-23','19:00:00','21:00:00','45000'),
('1','1','2018-07-23','21:00:00','23:00:00','45000'),
('1','1','2018-07-24','08:00:00','10:00:00','45000'),
('1','1','2018-07-24','10:00:00','12:00:00','45000'),
('1','1','2018-07-24','13:00:00','15:00:00','45000'),
('1','1','2018-07-24','15:00:00','17:00:00','45000'),
('1','1','2018-07-24','17:00:00','19:00:00','45000'),
('1','1','2018-07-24','19:00:00','21:00:00','45000'),
('1','1','2018-07-24','21:00:00','23:00:00','45000'),
('1','1','2018-07-25','08:00:00','10:00:00','45000'),
('1','1','2018-07-25','10:00:00','12:00:00','45000'),
('1','1','2018-07-25','13:00:00','15:00:00','45000'),
('1','1','2018-07-25','15:00:00','17:00:00','45000'),
('1','1','2018-07-25','17:00:00','19:00:00','45000'),
('1','1','2018-07-25','19:00:00','21:00:00','45000'),
('1','1','2018-07-25','21:00:00','23:00:00','45000'),
('1','1','2018-07-26','08:00:00','10:00:00','45000'),
('1','1','2018-07-26','10:00:00','12:00:00','45000'),
('1','1','2018-07-26','13:00:00','15:00:00','45000'),
('1','1','2018-07-26','15:00:00','17:00:00','45000'),
('1','1','2018-07-26','17:00:00','19:00:00','45000'),
('1','1','2018-07-26','19:00:00','21:00:00','45000'),
('1','1','2018-07-26','21:00:00','23:00:00','45000');

INSERT INTO Schedules(movie_id,room_id,show_date,start_time,end_time,price) VALUE
('2','2','2018-07-20','08:00:00','10:15:00','45000'),
('2','2','2018-07-20','10:40:00','12:45:00','45000'),
('2','2','2018-07-20','13:15:00','15:30:00','45000'),
('2','2','2018-07-20','15:50:00','18:05:00','45000'),
('2','2','2018-07-20','18:30:00','20:45:00','45000'),
('2','2','2018-07-20','21:00:00','23:15:00','45000'),
('2','2','2018-07-21','08:00:00','10:15:00','45000'),
('2','2','2018-07-21','10:40:00','12:45:00','45000'),
('2','2','2018-07-21','13:15:00','15:30:00','45000'),
('2','2','2018-07-21','15:50:00','18:05:00','45000'),
('2','2','2018-07-21','18:30:00','20:45:00','45000'),
('2','2','2018-07-21','21:00:00','23:15:00','45000'),
('2','2','2018-07-22','08:00:00','10:15:00','45000'),
('2','2','2018-07-22','10:40:00','12:45:00','45000'),
('2','2','2018-07-22','13:15:00','15:30:00','45000'),
('2','2','2018-07-22','15:50:00','18:05:00','45000'),
('2','2','2018-07-22','18:30:00','20:45:00','45000'),
('2','2','2018-07-22','21:00:00','23:15:00','45000'),
('2','2','2018-07-23','08:00:00','10:15:00','45000'),
('2','2','2018-07-23','10:40:00','12:45:00','45000'),
('2','2','2018-07-23','13:15:00','15:30:00','45000'),
('2','2','2018-07-23','15:50:00','18:05:00','45000'),
('2','2','2018-07-23','18:30:00','20:45:00','45000'),
('2','2','2018-07-23','21:00:00','23:15:00','45000'),
('2','2','2018-07-24','08:00:00','10:15:00','45000'),
('2','2','2018-07-24','10:40:00','12:45:00','45000'),
('2','2','2018-07-24','13:15:00','15:30:00','45000'),
('2','2','2018-07-24','15:50:00','18:05:00','45000'),
('2','2','2018-07-24','18:30:00','20:45:00','45000'),
('2','2','2018-07-24','21:00:00','23:15:00','45000'),
('2','2','2018-07-25','08:00:00','10:15:00','45000'),
('2','2','2018-07-25','10:40:00','12:45:00','45000'),
('2','2','2018-07-25','13:15:00','15:30:00','45000'),
('2','2','2018-07-25','15:50:00','18:05:00','45000'),
('2','2','2018-07-25','18:30:00','20:45:00','45000'),
('2','2','2018-07-25','21:00:00','23:15:00','45000'),
('2','2','2018-07-26','08:00:00','10:15:00','45000'),
('2','2','2018-07-26','10:40:00','12:45:00','45000'),
('2','2','2018-07-26','13:15:00','15:30:00','45000'),
('2','2','2018-07-26','15:50:00','18:05:00','45000'),
('2','2','2018-07-26','18:30:00','20:45:00','45000'),
('2','2','2018-07-26','21:00:00','23:15:00','45000');


INSERT INTO Schedules(movie_id,room_id,show_date,start_time,end_time,price) VALUE
('3','3','2018-07-20','08:00:00','10:10:00','45000'),
('3','3','2018-07-20','10:30:00','12:40:00','45000'),
('3','3','2018-07-20','13:00:00','15:10:00','45000'),
('3','3','2018-07-20','15:30:00','17:40:00','45000'),
('3','3','2018-07-20','18:00:00','19:10:00','45000'),
('3','3','2018-07-20','19:30:00','21:40:00','45000'),
('3','3','2018-07-20','22:00:00','24:00:00','45000'),
('3','3','2018-07-21','08:00:00','10:10:00','45000'),
('3','3','2018-07-21','10:30:00','12:40:00','45000'),
('3','3','2018-07-21','13:00:00','15:10:00','45000'),
('3','3','2018-07-21','15:30:00','17:40:00','45000'),
('3','3','2018-07-21','18:00:00','19:10:00','45000'),
('3','3','2018-07-21','19:30:00','21:40:00','45000'),
('3','3','2018-07-21','22:00:00','24:00:00','45000'),
('3','3','2018-07-22','08:00:00','10:10:00','45000'),
('3','3','2018-07-22','10:30:00','12:40:00','45000'),
('3','3','2018-07-22','13:00:00','15:10:00','45000'),
('3','3','2018-07-22','15:30:00','17:40:00','45000'),
('3','3','2018-07-22','18:00:00','19:10:00','45000'),
('3','3','2018-07-22','19:30:00','21:40:00','45000'),
('3','3','2018-07-22','22:00:00','24:00:00','45000'),
('3','3','2018-07-23','08:00:00','10:10:00','45000'),
('3','3','2018-07-23','10:30:00','12:40:00','45000'),
('3','3','2018-07-23','13:00:00','15:10:00','45000'),
('3','3','2018-07-23','15:30:00','17:40:00','45000'),
('3','3','2018-07-23','18:00:00','19:10:00','45000'),
('3','3','2018-07-23','19:30:00','21:40:00','45000'),
('3','3','2018-07-23','22:00:00','24:00:00','45000'),
('3','3','2018-07-24','08:00:00','10:10:00','45000'),
('3','3','2018-07-24','10:30:00','12:40:00','45000'),
('3','3','2018-07-24','13:00:00','15:10:00','45000'),
('3','3','2018-07-24','15:30:00','17:40:00','45000'),
('3','3','2018-07-24','18:00:00','19:10:00','45000'),
('3','3','2018-07-24','19:30:00','21:40:00','45000'),
('3','3','2018-07-24','22:00:00','24:00:00','45000'),
('3','3','2018-07-25','08:00:00','10:10:00','45000'),
('3','3','2018-07-25','10:30:00','12:40:00','45000'),
('3','3','2018-07-25','13:00:00','15:10:00','45000'),
('3','3','2018-07-25','15:30:00','17:40:00','45000'),
('3','3','2018-07-25','18:00:00','19:10:00','45000'),
('3','3','2018-07-25','19:30:00','21:40:00','45000'),
('3','3','2018-07-25','22:00:00','24:00:00','45000'),
('3','3','2018-07-26','08:00:00','10:10:00','45000'),
('3','3','2018-07-26','10:30:00','12:40:00','45000'),
('3','3','2018-07-26','13:00:00','15:10:00','45000'),
('3','3','2018-07-26','15:30:00','17:40:00','45000'),
('3','3','2018-07-26','18:00:00','19:10:00','45000'),
('3','3','2018-07-26','19:30:00','21:40:00','45000'),
('3','3','2018-07-26','22:00:00','24:00:00','45000');


INSERT INTO Schedules(movie_id,room_id,show_date,start_time,end_time,price) VALUE
('4','4','2018-07-20','08:00:00','10:00:00','45000'),
('4','4','2018-07-20','10:00:00','12:00:00','45000'),
('4','4','2018-07-20','13:00:00','15:00:00','45000'),
('4','4','2018-07-20','15:00:00','17:00:00','45000'),
('4','4','2018-07-20','17:00:00','19:00:00','45000'),
('4','4','2018-07-20','19:00:00','21:00:00','45000'),
('4','4','2018-07-20','21:00:00','23:00:00','45000'),
('4','4','2018-07-21','08:00:00','10:00:00','45000'),
('4','4','2018-07-21','10:00:00','12:00:00','45000'),
('4','4','2018-07-21','13:00:00','15:00:00','45000'),
('4','4','2018-07-21','15:00:00','17:00:00','45000'),
('4','4','2018-07-21','17:00:00','19:00:00','45000'),
('4','4','2018-07-21','19:00:00','21:00:00','45000'),
('4','4','2018-07-21','21:00:00','23:00:00','45000'),
('4','4','2018-07-22','08:00:00','10:00:00','45000'),
('4','4','2018-07-22','10:00:00','12:00:00','45000'),
('4','4','2018-07-22','13:00:00','15:00:00','45000'),
('4','4','2018-07-22','15:00:00','17:00:00','45000'),
('4','4','2018-07-22','17:00:00','19:00:00','45000'),
('4','4','2018-07-22','19:00:00','21:00:00','45000'),
('4','4','2018-07-22','21:00:00','23:00:00','45000'),
('4','4','2018-07-23','08:00:00','10:00:00','45000'),
('4','4','2018-07-23','10:00:00','12:00:00','45000'),
('4','4','2018-07-23','13:00:00','15:00:00','45000'),
('4','4','2018-07-23','15:00:00','17:00:00','45000'),
('4','4','2018-07-23','17:00:00','19:00:00','45000'),
('4','4','2018-07-23','19:00:00','21:00:00','45000'),
('4','4','2018-07-23','21:00:00','23:00:00','45000'),
('4','4','2018-07-24','08:00:00','10:00:00','45000'),
('4','4','2018-07-24','10:00:00','12:00:00','45000'),
('4','4','2018-07-24','13:00:00','15:00:00','45000'),
('4','4','2018-07-24','15:00:00','17:00:00','45000'),
('4','4','2018-07-24','17:00:00','19:00:00','45000'),
('4','4','2018-07-24','19:00:00','21:00:00','45000'),
('4','4','2018-07-24','21:00:00','23:00:00','45000'),
('4','4','2018-07-25','08:00:00','10:00:00','45000'),
('4','4','2018-07-25','10:00:00','12:00:00','45000'),
('4','4','2018-07-25','13:00:00','15:00:00','45000'),
('4','4','2018-07-25','15:00:00','17:00:00','45000'),
('4','4','2018-07-25','17:00:00','19:00:00','45000'),
('4','4','2018-07-25','19:00:00','21:00:00','45000'),
('4','4','2018-07-25','21:00:00','23:00:00','45000'),
('4','4','2018-07-26','08:00:00','10:00:00','45000'),
('4','4','2018-07-26','10:00:00','12:00:00','45000'),
('4','4','2018-07-26','13:00:00','15:00:00','45000'),
('4','4','2018-07-26','15:00:00','17:00:00','45000'),
('4','4','2018-07-26','17:00:00','19:00:00','45000'),
('4','4','2018-07-26','19:00:00','21:00:00','45000'),
('4','4','2018-07-26','21:00:00','23:00:00','45000');


INSERT INTO Schedules(movie_id,room_id,show_date,start_time,end_time,price) VALUE
('5','5','2018-07-20','08:00:00','10:00:00','45000'),
('5','5','2018-07-20','10:00:00','12:00:00','45000'),
('5','5','2018-07-20','13:00:00','15:00:00','45000'),
('5','5','2018-07-20','15:00:00','17:00:00','45000'),
('5','5','2018-07-20','17:00:00','19:00:00','45000'),
('5','5','2018-07-20','19:00:00','21:00:00','45000'),
('5','5','2018-07-20','21:00:00','23:00:00','45000'),
('5','5','2018-07-21','08:00:00','10:00:00','45000'),
('5','5','2018-07-21','10:00:00','12:00:00','45000'),
('5','5','2018-07-21','13:00:00','15:00:00','45000'),
('5','5','2018-07-21','15:00:00','17:00:00','45000'),
('5','5','2018-07-21','17:00:00','19:00:00','45000'),
('5','5','2018-07-21','19:00:00','21:00:00','45000'),
('5','5','2018-07-21','21:00:00','23:00:00','45000'),
('5','5','2018-07-22','08:00:00','10:00:00','45000'),
('5','5','2018-07-22','10:00:00','12:00:00','45000'),
('5','5','2018-07-22','13:00:00','15:00:00','45000'),
('5','5','2018-07-22','15:00:00','17:00:00','45000'),
('5','5','2018-07-22','17:00:00','19:00:00','45000'),
('5','5','2018-07-22','19:00:00','21:00:00','45000'),
('5','5','2018-07-22','21:00:00','23:00:00','45000'),
('5','5','2018-07-23','08:00:00','10:00:00','45000'),
('5','5','2018-07-23','10:00:00','12:00:00','45000'),
('5','5','2018-07-23','13:00:00','15:00:00','45000'),
('5','5','2018-07-23','15:00:00','17:00:00','45000'),
('5','5','2018-07-23','17:00:00','19:00:00','45000'),
('5','5','2018-07-23','19:00:00','21:00:00','45000'),
('5','5','2018-07-23','21:00:00','23:00:00','45000'),
('5','5','2018-07-24','08:00:00','10:00:00','45000'),
('5','5','2018-07-24','10:00:00','12:00:00','45000'),
('5','5','2018-07-24','13:00:00','15:00:00','45000'),
('5','5','2018-07-24','15:00:00','17:00:00','45000'),
('5','5','2018-07-24','17:00:00','19:00:00','45000'),
('5','5','2018-07-24','19:00:00','21:00:00','45000'),
('5','5','2018-07-24','21:00:00','23:00:00','45000'),
('5','5','2018-07-25','08:00:00','10:00:00','45000'),
('5','5','2018-07-25','10:00:00','12:00:00','45000'),
('5','5','2018-07-25','13:00:00','15:00:00','45000'),
('5','5','2018-07-25','15:00:00','17:00:00','45000'),
('5','5','2018-07-25','17:00:00','19:00:00','45000'),
('5','5','2018-07-25','19:00:00','21:00:00','45000'),
('5','5','2018-07-25','21:00:00','23:00:00','45000'),
('5','5','2018-07-26','08:00:00','10:00:00','45000'),
('5','5','2018-07-26','10:00:00','12:00:00','45000'),
('5','5','2018-07-26','13:00:00','15:00:00','45000'),
('5','5','2018-07-26','15:00:00','17:00:00','45000'),
('5','5','2018-07-26','17:00:00','19:00:00','45000'),
('5','5','2018-07-26','19:00:00','21:00:00','45000'),
('5','5','2018-07-26','21:00:00','23:00:00','45000');


INSERT INTO Schedules(movie_id,room_id,show_date,start_time,end_time,price) VALUE
('6','6','2018-07-20','08:00:00','10:00:00','45000'),
('6','6','2018-07-20','10:00:00','12:00:00','45000'),
('6','6','2018-07-20','13:00:00','15:00:00','45000'),
('6','6','2018-07-20','15:00:00','17:00:00','45000'),
('6','6','2018-07-20','17:00:00','19:00:00','45000'),
('6','6','2018-07-20','19:00:00','21:00:00','45000'),
('6','6','2018-07-20','21:00:00','23:00:00','45000'),
('6','6','2018-07-21','08:00:00','10:00:00','45000'),
('6','6','2018-07-21','10:00:00','12:00:00','45000'),
('6','6','2018-07-21','13:00:00','15:00:00','45000'),
('6','6','2018-07-21','15:00:00','17:00:00','45000'),
('6','6','2018-07-21','17:00:00','19:00:00','45000'),
('6','6','2018-07-21','19:00:00','21:00:00','45000'),
('6','6','2018-07-21','21:00:00','23:00:00','45000'),
('6','6','2018-07-22','08:00:00','10:00:00','45000'),
('6','6','2018-07-22','10:00:00','12:00:00','45000'),
('6','6','2018-07-22','13:00:00','15:00:00','45000'),
('6','6','2018-07-22','15:00:00','17:00:00','45000'),
('6','6','2018-07-22','17:00:00','19:00:00','45000'),
('6','6','2018-07-22','19:00:00','21:00:00','45000'),
('6','6','2018-07-22','21:00:00','23:00:00','45000'),
('6','6','2018-07-23','08:00:00','10:00:00','45000'),
('6','6','2018-07-23','10:00:00','12:00:00','45000'),
('6','6','2018-07-23','13:00:00','15:00:00','45000'),
('6','6','2018-07-23','15:00:00','17:00:00','45000'),
('6','6','2018-07-23','17:00:00','19:00:00','45000'),
('6','6','2018-07-23','19:00:00','21:00:00','45000'),
('6','6','2018-07-23','21:00:00','23:00:00','45000'),
('6','6','2018-07-24','08:00:00','10:00:00','45000'),
('6','6','2018-07-24','10:00:00','12:00:00','45000'),
('6','6','2018-07-24','13:00:00','15:00:00','45000'),
('6','6','2018-07-24','15:00:00','17:00:00','45000'),
('6','6','2018-07-24','17:00:00','19:00:00','45000'),
('6','6','2018-07-24','19:00:00','21:00:00','45000'),
('6','6','2018-07-24','21:00:00','23:00:00','45000'),
('6','6','2018-07-25','08:00:00','10:00:00','45000'),
('6','6','2018-07-25','10:00:00','12:00:00','45000'),
('6','6','2018-07-25','13:00:00','15:00:00','45000'),
('6','6','2018-07-25','15:00:00','17:00:00','45000'),
('6','6','2018-07-25','17:00:00','19:00:00','45000'),
('6','6','2018-07-25','19:00:00','21:00:00','45000'),
('6','6','2018-07-25','21:00:00','23:00:00','45000'),
('6','6','2018-07-26','08:00:00','10:00:00','45000'),
('6','6','2018-07-26','10:00:00','12:00:00','45000'),
('6','6','2018-07-26','13:00:00','15:00:00','45000'),
('6','6','2018-07-26','15:00:00','17:00:00','45000'),
('6','6','2018-07-26','17:00:00','19:00:00','45000'),
('6','6','2018-07-26','19:00:00','21:00:00','45000'),
('6','6','2018-07-26','21:00:00','23:00:00','45000');


INSERT INTO Schedules(movie_id,room_id,show_date,start_time,end_time,price) VALUE
('7','7','2018-07-20','08:00:00','10:00:00','45000'),
('7','7','2018-07-20','10:00:00','12:00:00','45000'),
('7','7','2018-07-20','13:00:00','15:00:00','45000'),
('7','7','2018-07-20','15:00:00','17:00:00','45000'),
('7','7','2018-07-20','17:00:00','19:00:00','45000'),
('7','7','2018-07-20','19:00:00','21:00:00','45000'),
('7','7','2018-07-20','21:00:00','23:00:00','45000'),
('7','7','2018-07-21','08:00:00','10:00:00','45000'),
('7','7','2018-07-21','10:00:00','12:00:00','45000'),
('7','7','2018-07-21','13:00:00','15:00:00','45000'),
('7','7','2018-07-21','15:00:00','17:00:00','45000'),
('7','7','2018-07-21','17:00:00','19:00:00','45000'),
('7','7','2018-07-21','19:00:00','21:00:00','45000'),
('7','7','2018-07-21','21:00:00','23:00:00','45000'),
('7','7','2018-07-22','08:00:00','10:00:00','45000'),
('7','7','2018-07-22','10:00:00','12:00:00','45000'),
('7','7','2018-07-22','13:00:00','15:00:00','45000'),
('7','7','2018-07-22','15:00:00','17:00:00','45000'),
('7','7','2018-07-22','17:00:00','19:00:00','45000'),
('7','7','2018-07-22','19:00:00','21:00:00','45000'),
('7','7','2018-07-22','21:00:00','23:00:00','45000'),
('7','7','2018-07-23','08:00:00','10:00:00','45000'),
('7','7','2018-07-23','10:00:00','12:00:00','45000'),
('7','7','2018-07-23','13:00:00','15:00:00','45000'),
('7','7','2018-07-23','15:00:00','17:00:00','45000'),
('7','7','2018-07-23','17:00:00','19:00:00','45000'),
('7','7','2018-07-23','19:00:00','21:00:00','45000'),
('7','7','2018-07-23','21:00:00','23:00:00','45000'),
('7','7','2018-07-24','08:00:00','10:00:00','45000'),
('7','7','2018-07-24','10:00:00','12:00:00','45000'),
('7','7','2018-07-24','13:00:00','15:00:00','45000'),
('7','7','2018-07-24','15:00:00','17:00:00','45000'),
('7','7','2018-07-24','17:00:00','19:00:00','45000'),
('7','7','2018-07-24','19:00:00','21:00:00','45000'),
('7','7','2018-07-24','21:00:00','23:00:00','45000'),
('7','7','2018-07-25','08:00:00','10:00:00','45000'),
('7','7','2018-07-25','10:00:00','12:00:00','45000'),
('7','7','2018-07-25','13:00:00','15:00:00','45000'),
('7','7','2018-07-25','15:00:00','17:00:00','45000'),
('7','7','2018-07-25','17:00:00','19:00:00','45000'),
('7','7','2018-07-25','19:00:00','21:00:00','45000'),
('7','7','2018-07-25','21:00:00','23:00:00','45000'),
('7','7','2018-07-26','08:00:00','10:00:00','45000'),
('7','7','2018-07-26','10:00:00','12:00:00','45000'),
('7','7','2018-07-26','13:00:00','15:00:00','45000'),
('7','7','2018-07-26','15:00:00','17:00:00','45000'),
('7','7','2018-07-26','17:00:00','19:00:00','45000'),
('7','7','2018-07-26','19:00:00','21:00:00','45000'),
('7','7','2018-07-26','21:00:00','23:00:00','45000');

INSERT INTO Schedules(movie_id,room_id,show_date,start_time,end_time,price) VALUE
('8','8','2018-07-20','08:00:00','10:00:00','45000'),
('8','8','2018-07-20','10:00:00','12:00:00','45000'),
('8','8','2018-07-20','13:00:00','15:00:00','45000'),
('8','8','2018-07-20','15:00:00','17:00:00','45000'),
('8','8','2018-07-20','17:00:00','19:00:00','45000'),
('8','8','2018-07-20','19:00:00','21:00:00','45000'),
('8','8','2018-07-20','21:00:00','23:00:00','45000'),
('8','8','2018-07-21','08:00:00','10:00:00','45000'),
('8','8','2018-07-21','10:00:00','12:00:00','45000'),
('8','8','2018-07-21','13:00:00','15:00:00','45000'),
('8','8','2018-07-21','15:00:00','17:00:00','45000'),
('8','8','2018-07-21','17:00:00','19:00:00','45000'),
('8','8','2018-07-21','19:00:00','21:00:00','45000'),
('8','8','2018-07-21','21:00:00','23:00:00','45000'),
('8','8','2018-07-22','08:00:00','10:00:00','45000'),
('8','8','2018-07-22','10:00:00','12:00:00','45000'),
('8','8','2018-07-22','13:00:00','15:00:00','45000'),
('8','8','2018-07-22','15:00:00','17:00:00','45000'),
('8','8','2018-07-22','17:00:00','19:00:00','45000'),
('8','8','2018-07-22','19:00:00','21:00:00','45000'),
('8','8','2018-07-22','21:00:00','23:00:00','45000'),
('8','8','2018-07-23','08:00:00','10:00:00','45000'),
('8','8','2018-07-23','10:00:00','12:00:00','45000'),
('8','8','2018-07-23','13:00:00','15:00:00','45000'),
('8','8','2018-07-23','15:00:00','17:00:00','45000'),
('8','8','2018-07-23','17:00:00','19:00:00','45000'),
('8','8','2018-07-23','19:00:00','21:00:00','45000'),
('8','8','2018-07-23','21:00:00','23:00:00','45000'),
('8','8','2018-07-24','08:00:00','10:00:00','45000'),
('8','8','2018-07-24','10:00:00','12:00:00','45000'),
('8','8','2018-07-24','13:00:00','15:00:00','45000'),
('8','8','2018-07-24','15:00:00','17:00:00','45000'),
('8','8','2018-07-24','17:00:00','19:00:00','45000'),
('8','8','2018-07-24','19:00:00','21:00:00','45000'),
('8','8','2018-07-24','21:00:00','23:00:00','45000'),
('8','8','2018-07-25','08:00:00','10:00:00','45000'),
('8','8','2018-07-25','10:00:00','12:00:00','45000'),
('8','8','2018-07-25','13:00:00','15:00:00','45000'),
('8','8','2018-07-25','15:00:00','17:00:00','45000'),
('8','8','2018-07-25','17:00:00','19:00:00','45000'),
('8','8','2018-07-25','19:00:00','21:00:00','45000'),
('8','8','2018-07-25','21:00:00','23:00:00','45000'),
('8','8','2018-07-26' ,'08:00:00','10:00:00','45000'),
('8','8','2018-07-26','10:00:00','12:00:00','45000'),
('8','8','2018-07-26','13:00:00','15:00:00','45000'),
('8','8','2018-07-26','15:00:00','17:00:00','45000'),
('8','8','2018-07-26','17:00:00','19:00:00','45000'),
('8','8','2018-07-26','19:00:00','21:00:00','45000'),
('8','8','2018-07-26','21:00:00','23:00:00','45000');





