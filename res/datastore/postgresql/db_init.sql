-- Full text indexing and search extensions
CREATE EXTENSION pg_trgm;


-- PostGIS extensions
CREATE EXTENSION postgis;
CREATE EXTENSION postgis_topology;


-- Python language extension
CREATE EXTENSION plpythonu;

-- Functions to query JSON columns
-- See here for originals:
-- https://gist.github.com/tobyhede/2715918/raw/370a4defac00d085a5351e084cb42b9d8ccb1092/postsql.sql

CREATE OR REPLACE FUNCTION json_string(data json, key text) RETURNS TEXT AS
$$
import json
res = json.loads(data)
keys = key.split('.')

for k in keys:
  if res: res = res.get(k, None)

return str(res) if res else None
$$
LANGUAGE plpythonu IMMUTABLE STRICT;


CREATE OR REPLACE FUNCTION json_int(data json, key text) RETURNS INT AS
$$
import json
res = json.loads(data)
keys = key.split('.')

for k in keys:
  if res: res = res.get(k, None)

try:
  if res is not None: res=int(res)
except Exception:
  res = None

return res
$$
LANGUAGE plpythonu IMMUTABLE STRICT;


CREATE OR REPLACE FUNCTION json_int_array(data json, key text) RETURNS INT[] AS
$$
import json
res = json.loads(data)
keys = key.split('.')

for k in keys:
  if res: res = res.get(k, None)

if res is not None and not isinstance(res, list):
  res = [res]

if isinstance(res, list):
  try:
    res = [int(l) for l in res]
  except Exception:
    res = None

  return res
$$
LANGUAGE plpythonu IMMUTABLE STRICT;


CREATE OR REPLACE FUNCTION json_float(data json, key text) RETURNS DOUBLE PRECISION AS
$$
import json
res = json.loads(data)
keys = key.split('.')

for k in keys:
  if res: res = res.get(k, None)

try:
  if res is not None: res=float(res)
except Exception:
  res = None

return res
$$
LANGUAGE plpythonu IMMUTABLE STRICT;


CREATE OR REPLACE FUNCTION json_bool(data json, key text) RETURNS BOOLEAN AS
$$
import json
res = json.loads(data)
keys = key.split('.')

for k in keys:
  if res: res = res.get(k, None)

if res is not None: res=bool(res)
return res
$$
LANGUAGE plpythonu IMMUTABLE STRICT;


-- Special access functions
-- Results in a list of attributes
CREATE OR REPLACE FUNCTION json_attrs(data json) RETURNS TEXT[] AS
$$
import json
res = json.loads(data)

return res.keys()
$$
LANGUAGE plpythonu IMMUTABLE STRICT;


-- Results in a list of nested object types
CREATE OR REPLACE FUNCTION json_nested(data json) RETURNS TEXT[] AS
$$
import json
res = json.loads(data)
nested = set([res[k]['type_'] for k,v in res.iteritems() if isinstance(v, dict) and v.get('type_', None)])

return list(nested)
$$
LANGUAGE plpythonu IMMUTABLE STRICT;


-- Results in a list of keywords
CREATE OR REPLACE FUNCTION json_keywords(data json) RETURNS TEXT[] AS
$$
import json
res = json.loads(data)
keywords = []
kw_list = res.get('keywords', None)
if kw_list and isinstance(kw_list, list):
  for kw in kw_list:
    keywords.append(kw)

return keywords
$$
LANGUAGE plpythonu IMMUTABLE STRICT;


-- Results in a special attribute
CREATE OR REPLACE FUNCTION json_specialattr(data json) RETURNS TEXT AS
$$
import json
res = json.loads(data)
special = None
doc_type = res.get('type_', None)
if doc_type == "UserInfo" and isinstance(res.get('contact', None), dict):
  email = res['contact'].get('email', None)
  if email:
    special = "contact.email=%s" % email
elif doc_type == "DataProduct" and res.get('ooi_product_name', None):
  special = "ooi_product_name=%s" % res['ooi_product_name']
elif doc_type == "Org" and res.get('org_governance_name', None):
  special = "org_governance_name=%s" % res['org_governance_name']
elif doc_type == "NotificationRequest" and res.get('origin', None):
  special = "origin=%s" % res['origin']
elif doc_type == "UserRole" and res.get('governance_name', None):
  special = "governance_name=%s" % res['governance_name']

return special
$$
LANGUAGE plpythonu IMMUTABLE STRICT;


-- Results in a list of alternative id namespaces
CREATE OR REPLACE FUNCTION json_altids_ns(data json) RETURNS TEXT[] AS
$$
import json
res = json.loads(data)
alts = set()
kw_list = res.get('alt_ids', None)
if kw_list and isinstance(kw_list, list):
  for kw in kw_list:
    parts = kw.split(':',1)
    alts.add(parts[0] if len(parts) > 1 else '_')

return sorted(alts)
$$
LANGUAGE plpythonu IMMUTABLE STRICT;


-- Results in a list of alternative ids
CREATE OR REPLACE FUNCTION json_altids_id(data json) RETURNS TEXT[] AS
$$
import json
res = json.loads(data)
alts = set()
kw_list = res.get('alt_ids', None)
if kw_list and isinstance(kw_list, list):
  for kw in kw_list:
    parts = kw.split(':',1)
    alts.add(parts[-1])

return sorted(alts)
$$
LANGUAGE plpythonu IMMUTABLE STRICT;


-- Results in all attributes in one big string
CREATE OR REPLACE FUNCTION json_allattr(data json) RETURNS TEXT AS
$$
import json
res = json.loads(data)
no_attrs = set(["_id","_rev","type_","ts_created","ts_updated","lcstate","availability"])
ok_types = set([unicode,str,int,long,float])
parts = []
for k,v in res.iteritems():
  if k not in no_attrs and type(v) in ok_types:
    if type(v) is unicode:
      v = v.encode("utf8")
    parts.append(str(v)[:500])

return " ".join(parts)
$$
LANGUAGE plpythonu IMMUTABLE STRICT;
