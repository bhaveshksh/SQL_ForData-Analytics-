SELECT table_schema,
table_name
FROM
information_schema.tables
WHERE
table_type = 'BASE TABLE'
AND table_schema NOT IN  ('pg_catalog','information_schema')
ORDER BY table_schema,table_name;

SELECT table_schema, table_name
FROM information_schema.tables
WHERE table_type = 'sales'
  AND table_schema NOT IN ('pg_catalog', 'information_schema')
ORDER BY table_schema, table_name;

SELECT 
    c.column_name,
    c.data_type,
    c.is_nullable,
    c.column_default,
    CASE 
        WHEN kcu.column_name IS NOT NULL THEN 'YES' 
        ELSE 'NO' 
    END AS is_primary_key,
    ccu.table_name AS referenced_table,
    ccu.column_name AS referenced_column
FROM information_schema.columns c
LEFT JOIN information_schema.key_column_usage kcu
       ON c.table_name = kcu.table_name
      AND c.column_name = kcu.column_name
      AND kcu.constraint_name IN (
            SELECT constraint_name 
            FROM information_schema.table_constraints
            WHERE table_name = c.table_name
              AND constraint_type = 'PRIMARY KEY'
      )
LEFT JOIN information_schema.constraint_column_usage ccu
       ON kcu.constraint_name = ccu.constraint_name
WHERE c.table_name = 'sales'
  AND c.table_schema = 'public'
ORDER BY c.ordinal_position;

-- 1) Column details (name, type, nullable, default, description)
SELECT
    a.attnum AS ordinal_position,
    a.attname AS column_name,
    pg_catalog.format_type(a.atttypid, a.atttypmod) AS data_type,
    NOT a.attnotnull AS is_nullable,
    pg_get_expr(ad.adbin, ad.adrelid) AS column_default,
    col_description(a.attrelid, a.attnum) AS description
FROM pg_attribute a
LEFT JOIN pg_attrdef ad ON a.attrelid = ad.adrelid AND a.attnum = ad.adnum
WHERE a.attrelid = 'public.sales'::regclass
    AND a.attnum > 0
    AND NOT a.attisdropped
ORDER BY a.attnum;

-- 2) Primary key columns (in order)
SELECT
    kcu.constraint_name,
    kcu.column_name,
    kcu.ordinal_position
FROM information_schema.table_constraints tc
JOIN information_schema.key_column_usage kcu
    ON tc.constraint_name = kcu.constraint_name
    AND tc.table_schema = kcu.table_schema
WHERE tc.table_schema = 'public'
    AND tc.table_name = 'sales'
    AND tc.constraint_type = 'PRIMARY KEY'
ORDER BY kcu.ordinal_position;

-- 3) Foreign keys (definition and referenced object)
SELECT
    con.conname AS constraint_name,
    pg_get_constraintdef(con.oid) AS definition,
    nsp2.nspname AS referenced_schema,
    cl2.relname  AS referenced_table
FROM pg_constraint con
JOIN pg_class cl ON con.conrelid = cl.oid
JOIN pg_namespace nsp ON cl.relnamespace = nsp.oid
LEFT JOIN pg_class cl2 ON con.confrelid = cl2.oid
LEFT JOIN pg_namespace nsp2 ON cl2.relnamespace = nsp2.oid
WHERE nsp.nspname = 'public'
    AND cl.relname = 'sales'
    AND con.contype = 'f';

-- 4) Unique and check constraints
SELECT
    con.conname AS constraint_name,
    CASE con.contype WHEN 'u' THEN 'UNIQUE' WHEN 'c' THEN 'CHECK' ELSE con.contype END AS constraint_type,
    pg_get_constraintdef(con.oid) AS definition
FROM pg_constraint con
JOIN pg_class cl ON con.conrelid = cl.oid
JOIN pg_namespace nsp ON cl.relnamespace = nsp.oid
WHERE nsp.nspname = 'public'
    AND cl.relname = 'sales'
    AND con.contype IN ('u','c');

-- 5) Indexes on the table
SELECT
    i.relname AS index_name,
    ix.indisunique AS is_unique,
    ix.indisprimary AS is_primary,
    pg_get_indexdef(ix.indexrelid) AS definition
FROM pg_index ix
JOIN pg_class i ON i.oid = ix.indexrelid
JOIN pg_class tbl ON tbl.oid = ix.indrelid
JOIN pg_namespace nsp ON tbl.relnamespace = nsp.oid
WHERE nsp.nspname = 'public'
    AND tbl.relname = 'sales';

-- 6) Triggers defined on the table
SELECT
    tg.tgname AS trigger_name,
    pg_get_triggerdef(tg.oid) AS definition
FROM pg_trigger tg
JOIN pg_class cl ON tg.tgrelid = cl.oid
JOIN pg_namespace nsp ON cl.relnamespace = nsp.oid
WHERE nsp.nspname = 'public'
    AND cl.relname = 'sales'
    AND NOT tg.tgisinternal;

-- 7) Row count (live COUNT) and size info
SELECT
    (SELECT count(*) FROM public.sales) AS row_count,
    pg_size_pretty(pg_table_size('public.sales')) AS table_size,
    pg_size_pretty(pg_total_relation_size('public.sales')) AS total_size;

-- 8) Grants / privileges on the table
SELECT grantee, privilege_type
FROM information_schema.role_table_grants
WHERE table_schema = 'public'
    AND table_name = 'sales'
ORDER BY grantee, privilege_type;

-- 9) Sample rows (first 10)
SELECT * FROM public.sales LIMIT 10;

-- 1) Row counts for product, sales and customers tables
SELECT 'product'   AS table_name, COUNT(*) AS row_count FROM public.product
UNION ALL
SELECT 'sales'     AS table_name, COUNT(*) AS row_count FROM public.sales
UNION ALL
SELECT 'customers' AS table_name, COUNT(*) AS row_count FROM public.customers;

-- 2) Customers count by state
SELECT
    c.state,
    COUNT(*) AS customers_count
FROM public.customers c
GROUP BY c.state
ORDER BY customers_count DESC;

-- 3) Aggregations by product subcategory:
--    qty, discount, profit, sales -> min/max/avg/sum
SELECT
    p.sub_category AS sub_category,
    COUNT(DISTINCT p.product_id) AS products_count,
    -- quantity aggregates
    COALESCE(SUM(s.qty),0) AS sum_qty,
    AVG(s.qty)            AS avg_qty,
    MAX(s.qty)            AS max_qty,
    MIN(s.qty)            AS min_qty,
    -- discount aggregates
    COALESCE(SUM(s.discount),0) AS sum_discount,
    AVG(s.discount)             AS avg_discount,
    MAX(s.discount)             AS max_discount,
    MIN(s.discount)             AS min_discount,
    -- profit aggregates
    COALESCE(SUM(s.profit),0) AS sum_profit,
    AVG(s.profit)            AS avg_profit,
    MAX(s.profit)            AS max_profit,
    MIN(s.profit)            AS min_profit,
    -- sales amount aggregates (rename column if different in your schema)
    COALESCE(SUM(s.sales),0) AS sum_sales,
    AVG(s.sales)            AS avg_sales,
    MAX(s.sales)            AS max_sales,
    MIN(s.sales)            AS min_sales,
    COUNT(s.*) AS sales_rows
FROM public.product p
LEFT JOIN public.sales s ON s.product_id = p.product_id
GROUP BY p.sub_category
HAVING COALESCE(SUM(s.qty),0) > 0
ORDER BY sum_sales DESC NULLS LAST;

