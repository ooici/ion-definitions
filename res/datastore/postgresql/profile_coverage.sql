-- Create coverage model table
CREATE TABLE "%(ds)s" (id text PRIMARY KEY, auto_flush_values text, brick_domains text, coverage_type text, global_bricking_scheme text, inline_data_writes text, name text, param_groups text, sdom text, tdom text, value_caching text, version text, brick_tree text, rcov_locs text, rcov_extents text, complex_type text, param_dict text, tree_rank text, rcov_loc text, span_collection text, brick_list text, parameter_bounds text);

GRANT SELECT, INSERT, UPDATE, DELETE on "%(ds)s" TO ion;

CREATE TABLE "%(ds)s_spans" (span_address text PRIMARY KEY, coverage_id text, spatial_geometry geometry, vertical_range numrange, time_range tsrange);

CREATE INDEX spans_time_idx on "%(ds)s_spans" (time_range);

CREATE INDEX spans_spatial_idx on "%(ds)s_spans" (spatial_geometry);

CREATE INDEX spans_vertical_idx on "%(ds)s_spans" (vertical_range);

CREATE INDEX spans_time_space_idx on "%(ds)s_spans" (time_range, spatial_geometry);

GRANT SELECT, INSERT, UPDATE, DELETE on "%(ds)s_spans" TO ion;

CREATE TABLE "%(ds)s_span_data" (id text PRIMARY KEY, coverage_id text, ingest_time double precision, data json);
GRANT SELECT, INSERT, UPDATE, DELETE on "%(ds)s_span_data" TO ion;

CREATE TABLE "%(ds)s_span_stats" (span_address text PRIMARY KEY, coverage_id text, hash text, spatial_geometry geometry, vertical_range numrange, time_range tsrange);
GRANT SELECT, INSERT, UPDATE, DELETE on "%(ds)s_span_stats" TO ion;

CREATE TABLE "%(ds)s_bin_stats" (bin_name text PRIMARY KEY, coverage_id text, span_ids text[], spatial_geometry geometry, vertical_range numrange, time_range tsrange);
GRANT SELECT, INSERT, UPDATE, DELETE on "%(ds)s_bin_stats" TO ion;

