-- This Source Code Form is subject to the terms of the Mozilla Public
-- License, v. 2.0. If a copy of the MPL was not distributed with this
-- file, You can obtain one at http://mozilla.org/MPL/2.0/.

CREATE TABLE total_calls_per_region_per_day AS (

    SELECT
        call_date,
        region,
        total_calls
    FROM (
        SELECT calls.call_date AS call_date,
            cells.region AS region,
            count(DISTINCT msisdn) AS subscriber_count,
            count(*) AS total_calls
        FROM calls
        INNER JOIN cells
            ON calls.location_id = cells.cell_id
        WHERE calls.call_date >= '2020-02-01'
            AND calls.call_date <= CURRENT_DATE
        GROUP BY 1, 2
    ) AS grouped
    WHERE grouped.subscriber_count >= 15

);