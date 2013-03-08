# to run this file use rails runner
# Also load a lot of data for id 3221

require "benchmark"

N = 100_000

Benchmark.bm do |test|

  conn = ActiveRecord::Base.connection

  conn.execute("drop index if exists join_proposals_and_events")
  test.report("no index") do
    N.times do
      conn.execute <<-SQL
      SELECT SUM(v.direction) as acceptance_points, proposals.* FROM "proposals" LEFT JOIN votes v ON v.proposal_id = proposals.id WHERE (proposals.event_id = 3221) GROUP BY proposals.id ORDER BY acceptance_points DESC;
      SQL
    end
  end

  conn.execute("create index  join_proposals_and_events ON proposals(event_id)")
  test.report("with index") do
    N.times do
      conn.execute <<-SQL
      SELECT SUM(v.direction) as acceptance_points, proposals.* FROM "proposals" LEFT JOIN votes v ON v.proposal_id = proposals.id WHERE (proposals.event_id = 3221) GROUP BY proposals.id ORDER BY acceptance_points DESC;
      SQL
    end
  end
end
