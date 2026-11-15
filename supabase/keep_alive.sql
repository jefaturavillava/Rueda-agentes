-- Required schema for preserving a turn while an agent is temporarily absent.
-- Safe to run more than once.
alter table public.agents
    add column if not exists preserve_turn boolean not null default false,
    add column if not exists turn_pending boolean not null default false;

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
