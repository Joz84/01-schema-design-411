require "sqlite3"

# Open a database
db = SQLite3::Database.new("chinook.sqlite")

# Find a few rows
request1 = db.execute( %(
  SELECT first_name, last_name, email FROM customers
  ORDER BY last_name ASC;
  ))

p request1.first
p request1.size

request2 = db.execute( %(
  SELECT tracks.name, tracks.composer FROM tracks
  JOIN playlist_tracks ON tracks.id = playlist_tracks.track_id
  JOIN playlists ON playlist_tracks.playlist_id = playlists.id
  WHERE playlists.name = "Classical"
  ))

p request2.first
p request2.size

request3 = db.execute( %(
  SELECT artists.name, COUNT(*) AS c FROM artists
  JOIN albums ON artists.id = albums.artist_id
  JOIN tracks ON albums.id = tracks.album_id
  JOIN playlist_tracks ON tracks.id = playlist_tracks.track_id
  GROUP BY artists.name
  ORDER BY c DESC
  LIMIT 10
  ))

p request3

request4 = db.execute( %(
  SELECT tracks.name, COUNT(*) as c FROM tracks
  JOIN invoice_lines ON tracks.id = invoice_lines.track_id
  GROUP BY tracks.id
  HAVING c >= 2
  ORDER BY c DESC
  ))

p request4
p request4.size









