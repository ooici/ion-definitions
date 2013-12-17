CREATE TABLE "%(ds)s" (id varchar(300) PRIMARY KEY, rev int, doc json);

GRANT SELECT, INSERT, UPDATE, DELETE on "%(ds)s" TO ion;
