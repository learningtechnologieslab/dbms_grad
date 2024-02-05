USE dmb72;
# books
# genres
# inventory
# author

CREATE TABLE IF NOT EXISTS books (
	book_id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
	title VARCHAR(200) NOT NULL,
    date_published DATE NOT NULL,
    book_format VARCHAR(20) NOT NULL,
    descr VARCHAR(4000) NOT NULL
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS inventory(
	inv_id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    fk_book_id INT NOT NULL,
    location VARCHAR(10) NOT NULL,
    cnt INT NOT NULL DEFAULT 0
) ENGINE=InnoDB;
