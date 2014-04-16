-- Resource tables
CREATE TABLE "%(ds)s" (id varchar(300) PRIMARY KEY, rev int, doc json,
    type_ varchar(80), lcstate varchar(10), availability varchar(14), visibility int,
    name varchar(300),
    ts_created varchar(14), ts_updated varchar(14),
    vertical_range numrange, temporal_range numrange,
    deleted boolean);

SELECT AddGeometryColumn('public', '%(ds)s', 'geom', 4326, 'POINT', 2);

SELECT AddGeometryColumn('public', '%(ds)s', 'geom_loc', 4326, 'POLYGON', 2);

GRANT SELECT, INSERT, UPDATE, DELETE on "%(ds)s" TO ion;

CREATE TABLE "%(ds)s_assoc" (id varchar(300) PRIMARY KEY, rev int, doc json,
    s varchar(300) REFERENCES %(ds)s (id) ON DELETE CASCADE, st varchar(80), p varchar(40),
    o varchar(300) REFERENCES %(ds)s (id) ON DELETE CASCADE, ot varchar(80), retired boolean);

GRANT SELECT, INSERT, UPDATE, DELETE on "%(ds)s_assoc" TO ion;

CREATE TABLE "%(ds)s_dir" (id varchar(300) PRIMARY KEY, rev int, doc json,
    org varchar(60), parent varchar(300), key varchar(300));

GRANT SELECT, INSERT, UPDATE, DELETE on "%(ds)s_dir" TO ion;

CREATE TABLE "%(ds)s_att" (id serial PRIMARY KEY,
    docid varchar(300) REFERENCES %(ds)s (id) ON DELETE CASCADE, rev int, doc bytea,
    name varchar(200), content_type varchar(200));

GRANT SELECT, INSERT, UPDATE, DELETE on "%(ds)s_att" TO ion;

GRANT USAGE, SELECT, UPDATE on "%(ds)s_att_id_seq" TO ion;


-- Resource table indexes
CREATE INDEX "%(ds)s_type_idx" ON "%(ds)s" (type_);

CREATE INDEX "%(ds)s_lcstate_idx" ON "%(ds)s" (lcstate);

CREATE INDEX "%(ds)s_availability_idx" ON "%(ds)s" (availability);

CREATE INDEX "%(ds)s_visibility_idx" ON "%(ds)s" (visibility);

CREATE INDEX "%(ds)s_name_idx" ON "%(ds)s" (name);

CREATE INDEX "%(ds)s_name_full_idx" ON "%(ds)s" USING GIST (name gist_trgm_ops);

CREATE INDEX "%(ds)s_keywords_idx" ON "%(ds)s" USING GIN (json_keywords(doc));

CREATE INDEX "%(ds)s_nested_idx" ON "%(ds)s" USING GIN (json_nested(doc));

CREATE INDEX "%(ds)s_specialattr_idx" ON "%(ds)s" (json_specialattr(doc));

CREATE INDEX "%(ds)s_altids_ns_idx" ON "%(ds)s" USING GIN (json_altids_ns(doc));

CREATE INDEX "%(ds)s_altids_id_idx" ON "%(ds)s" USING GIN (json_altids_id(doc));

CREATE INDEX "%(ds)s_geom_idx" ON "%(ds)s" USING GIST (geom);

CREATE INDEX "%(ds)s_geom_loc_idx" ON "%(ds)s" USING GIST (geom_loc);

CREATE INDEX "%(ds)s_geom_vert_idx" ON "%(ds)s" USING GIST (vertical_range);

CREATE INDEX "%(ds)s_geom_temp_idx" ON "%(ds)s" USING GIST (temporal_range);

CREATE INDEX "%(ds)s_all_full_idx" ON "%(ds)s" USING GIST (json_allattr(doc) gist_trgm_ops);


-- Resource association table indexes
CREATE INDEX "%(ds)s_assoc_s_idx" ON "%(ds)s_assoc" (s, p, o);

CREATE INDEX "%(ds)s_assoc_st_idx" ON "%(ds)s_assoc" (st, p);

CREATE INDEX "%(ds)s_assoc_p_idx" ON "%(ds)s_assoc" (p, s, o);

CREATE INDEX "%(ds)s_assoc_o_idx" ON "%(ds)s_assoc" (o, p, s);

CREATE INDEX "%(ds)s_assoc_ot_idx" ON "%(ds)s_assoc" (ot, p);


-- Resource directory table indexes
CREATE INDEX "%(ds)s_dir_org_idx" ON "%(ds)s_dir" (org);

CREATE INDEX "%(ds)s_dir_parent_idx" ON "%(ds)s_dir" (parent, key);

CREATE INDEX "%(ds)s_dir_key_idx" ON "%(ds)s_dir" (key);


-- Resource attachments table indexes
CREATE INDEX "%(ds)s_att_docid_idx" ON "%(ds)s_att" (docid);
