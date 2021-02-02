-- MIT License
--
-- (C) Copyright [2019-2021] Hewlett Packard Enterprise Development LP
--
-- Permission is hereby granted, free of charge, to any person obtaining a
-- copy of this software and associated documentation files (the "Software"),
-- to deal in the Software without restriction, including without limitation
-- the rights to use, copy, modify, merge, publish, distribute, sublicense,
-- and/or sell copies of the Software, and to permit persons to whom the
-- Software is furnished to do so, subject to the following conditions:
--
-- The above copyright notice and this permission notice shall be included
-- in all copies or substantial portions of the Software.
--
-- THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
-- IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
-- FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
-- THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR
-- OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
-- ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
-- OTHER DEALINGS IN THE SOFTWARE.

-- Install hmsds schema version 4

BEGIN;

create table if not exists job_sync (
    "id"           UUID PRIMARY KEY,
    "type"         VARCHAR(128),
    "status"       VARCHAR(128),
    "last_update"  TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "lifetime"     INT NOT NULL
);

create table if not exists job_state_rf_poll (
    "comp_id"      VARCHAR(63) PRIMARY KEY,
    "job_id"       UUID NOT NULL,
    FOREIGN KEY ("job_id") REFERENCES job_sync ("id") ON DELETE CASCADE
);

-- Bump the schema version
insert into system values(0, 4, '{}'::JSON)
    on conflict(id) do update set schema_version=4;

COMMIT;
