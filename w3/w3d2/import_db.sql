
DROP TABLE IF EXISTS users;

CREATE TABLE users (
  id    INTEGER PRIMARY KEY,
  fname VARCHAR(255),
  lname VARCHAR(255)
);

DROP TABLE IF EXISTS questions;

CREATE TABLE questions (
  id INTEGER PRIMARY KEY,
  title VARCHAR(255),
  body TEXT,
  author_id INTEGER,

  FOREIGN KEY (author_id) REFERENCES users(id)

);
DROP TABLE IF EXISTS question_follows;

CREATE TABLE question_follows (
  question_id INTEGER,
  user_id INTEGER,

  FOREIGN KEY (question_id) REFERENCES questions(id),
  FOREIGN KEY (user_id) REFERENCES users(id)
);

DROP TABLE IF EXISTS replies;

CREATE TABLE replies (
  id INTEGER PRIMARY KEY,
  question_id INTEGER NOT NULL,
  parent_id INTEGER,
  user_id INTEGER NOT NULL,
  body TEXT,

  FOREIGN KEY (question_id) REFERENCES questions(id),
  FOREIGN KEY (user_id) REFERENCES users(id)
  FOREIGN KEY (parent_id) REFERENCES replies(id)
);

DROP TABLE IF EXISTS question_likes;

CREATE TABLE question_likes (
  user_id INTEGER,
  question_id INTEGER,

  FOREIGN KEY (question_id) REFERENCES questions(id),
  FOREIGN KEY (user_id) REFERENCES users(id)
);


INSERT INTO
  users (fname, lname)
VALUES
  ("Jason", "Clan"),
  ("Tim", "Murdock"),
  ("Justin", "Timberlake");

INSERT INTO
  questions (title, body, author_id)
VALUES
  ("KEYS","ksgjldkf", 1),   ("KEYS 2","ksgjldkf 222 ", 2);

INSERT INTO
  question_follows(question_id, user_id)
VALUES
  (1, 2);

INSERT INTO
  replies(question_id, parent_id, user_id, body)
VALUES
  (1, NULL, 1, "body 1"), (1, 1, 2, "body 2"), (1, 1, 1, "body 3"), (2, NULL, 3, "body 4");


INSERT INTO
  question_likes(user_id, question_id)
VALUES
  (1,1), (1,2), (1,3), (2,1), (3,1);
