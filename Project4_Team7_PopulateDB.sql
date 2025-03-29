use project4_team7;
INSERT INTO Users (Username, Pass) VALUES
('Doe','password123'), 
('Smith','password456'), 
('Billy','password789'); 
INSERT INTO Classes (ClassName, ClassNumber) VALUES
('Basic PHP', 1),
('Database Design', 2),
('Web Design', 3);
INSERT INTO Login (UserID, ClassID, Last_Login) VALUES
(1, 1, NULL), 
(2, 2, NULL), 
(3, 3, NULL); 
INSERT INTO Student (UserID, ClassID, Enrolled) VALUES
(1, 1, TRUE),
(2, 2, TRUE),
(3, 3, TRUE),
(1, 2, TRUE);