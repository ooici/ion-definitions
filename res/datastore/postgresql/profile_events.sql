CREATE TABLE "%(ds)s" (id varchar(300) PRIMARY KEY, rev int, doc json, type_ varchar(80),
    origin varchar(300), origin_type varchar(80), sub_type varchar(120), ts_created varchar(14));

GRANT SELECT, INSERT, UPDATE, DELETE on "%(ds)s" TO ion;

-- Events table indexes
CREATE INDEX "%(ds)s_type_idx" ON "%(ds)s" (type_, ts_created);

CREATE INDEX "%(ds)s_origin_idx" ON "%(ds)s" (origin, ts_created);

CREATE INDEX "%(ds)s_origin_type_idx" ON "%(ds)s" (origin_type);

CREATE INDEX "%(ds)s_sub_type_idx" ON "%(ds)s" (sub_type);

CREATE INDEX "%(ds)s_ts_created_idx" ON "%(ds)s" (ts_created);
