-- Create coverage model table
CREATE TABLE "%(ds)s" (id text PRIMARY KEY, auto_flush_values text, brick_domains text, coverage_type text, global_bricking_scheme text, inline_data_writes text, name text, param_groups text, sdom text, tdom text, value_caching text, version text, brick_tree text, rcov_locs text, complex_type text, param_dict text, tree_rank text, rcov_loc text, span_collection text, brick_list text, parameter_bounds text);

GRANT SELECT, INSERT, UPDATE, DELETE on "%(ds)s" TO ion;

CREATE TABLE "%(ds)s_spans" (span_address text PRIMARY KEY, coverage_id text, spatial_geography geography, vertical_range numrange, time_range tsrange);

CREATE INDEX spans_time_idx on "%(ds)s_spans" (time_range);

CREATE INDEX spans_spatial_idx on "%(ds)s_spans" (spatial_geography);

CREATE INDEX spans_vertical_idx on "%(ds)s_spans" (vertical_range);

CREATE INDEX spans_time_space_idx on "%(ds)s_spans" (time_range, spatial_geography);

GRANT SELECT, INSERT, UPDATE, DELETE on "%(ds)s_spans" TO ion;
