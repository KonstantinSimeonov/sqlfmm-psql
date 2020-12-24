const sql = require(`fs`)
    .readFileSync(0)
    .toString(`utf-8`)

process.stdout.write(
  sql
    .replace(
      /create database ([a-z]+);/ig,
      (create_cmd, db_name) => `DROP DATABASE IF EXISTS ${db_name};\n\n${create_cmd}`
    )
    // postgres uses '\c dbname;' to connect to a db
    .replace(
      /use ([a-z]+);/ig,
      (_, db_name) => `\\c ${db_name};`
    )
    // Tourney_ID -> Tourney_id
    // TourneyID -> Tourney_id
    .replace(
      /([a-z_0-9][A-Z]+)/g,
      match => `${match[0] === `_` ? `` : match[0]}_${match.slice(1).toLowerCase()}`
    )
    // Tourney_id -> tourney_id
    // (Tourney_id -> (tourney_id
    // WAZips -> wazips
    .replace(
      /[\s\(]([A-Z]+[a-z])/g,
      match => match.toLowerCase()
    )
    // AUTO_INCREMENT -> SERIAL
    .replace(
      /\sauto_increment\s/ig,
      ` SERIAL `
    )
    .replace(
      /int( not null)? SERIAL/ig,
      (_, not_null = ``) => `SERIAL ${`${not_null} `.trim()}`
    )
    .replace(/\r/g, ``) // get outta here u windows junk
    // cast default values for bits cause they're interpreted as ints
    .replace(
      / bit .* default \d/ig,
      column_typedef_with_default => `${column_typedef_with_default}::bit`
    )
    // postgres does not support nvarchar
    .replace(
      /nvarchar\s?/g,
      `varchar`
    )
    // i have OCD k??
    .replace(/\t/g, `    `)
    .replace(/ +([,\n;])/g, (_, punctuation) => punctuation)
    .replace(/([a-z])  +([a-z])/ig, (_, a, b) => `${a} ${b}`)
    .replace(/\n\n+/g, `\n\n`)
    .replace(/([a-z\(\),])\n\n+/ig, (_, char) => `${char}\n`)
    .trim()
)
