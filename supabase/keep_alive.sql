-- A low-impact RPC used by the scheduled GitHub Actions keep-alive.
-- It returns a constant and does not read or modify application data.
create or replace function public.keep_alive()
returns text
language sql
security invoker
as $$
    select 'ok'::text;
$$;

revoke all on function public.keep_alive() from public;
grant execute on function public.keep_alive() to anon;
