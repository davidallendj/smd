-- MIT License
--
-- (C) Copyright [2020-2021] Hewlett Packard Enterprise Development LP
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

-- Install hmsds schema version 12

BEGIN;

CREATE TABLE IF NOT EXISTS hsn_interfaces (
    nic         VARCHAR(32) PRIMARY KEY,
    macaddr     VARCHAR(32) NOT NULL DEFAULT '',
    hsn         VARCHAR(32) NOT NULL DEFAULT '',
    node        VARCHAR(32) NOT NULL DEFAULT '',
    ipaddr      VARCHAR(64) NOT NULL DEFAULT '',
    last_update TIMESTAMPTZ
);

-- Bump the schema version
insert into system values(0, 12, '{}'::JSON)
    on conflict(id) do update set schema_version=12;

COMMIT;
