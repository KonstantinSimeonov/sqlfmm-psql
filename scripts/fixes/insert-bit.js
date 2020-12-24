module.exports = (stmt) =>
  stmt.columns.includes(`won_game`)
    ? { ...stmt, rows: stmt.rows.map(r => r.replace(/\)$/, `::bit)`)) }
    : stmt;
