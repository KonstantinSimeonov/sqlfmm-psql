const sql = require('fs').readFileSync(0).toString(`utf-8`)

const { inserts, other } = sql
  .split(/;\s+/g)
  .reduce(
    ({ inserts, other }, stmt, i) => {
      if (!stmt.startsWith(`INSERT INTO`)) return { inserts, other: [...other, { stmt, i }] }

      const [into, values] = stmt.split(`VALUES`)

      const [, , table_name] = into.split(` `).map(x => x.trim()).filter(Boolean)
      const columns = `(${into.split(`)`)[0].split(`(`)[1]})`
      const row = values.trim()

      if (inserts[table_name]) {
        inserts[table_name].rows.push(row)
      } else {
        inserts[table_name] = {
          columns: columns.trim(),
          i,
          rows: [row]
        }
      }

      return { inserts, other }
    },
    { inserts: {}, other: [] }
  )

const all = [
  ...other,
  ...Object.entries(inserts).map(([table_name, { columns, i, rows }]) => ({
    i,
    stmt: `INSERT INTO ${table_name}\n    ${columns}\nVALUES\n    ${rows.join(`,\n    `)}`
  }))
].sort((a, b) => a.i - b.i)
  .map(stmt_info => stmt_info.stmt)
  .join(`;\n\n`)
  .trim()

process.stdout.write(`${all}\n`)
