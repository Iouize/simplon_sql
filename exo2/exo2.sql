USE Chinook;

-- QUERY 1: Explore PlaylistTrack (line count : 8715)
SELECT * FROM playlist_track;

-- QUERY 2: How many track does each playlist have? Order from largest to smallest playlists. (line count : 14)
SELECT name, COUNT(*) Nb_tracks
  FROM playlists JOIN playlist_track ON playlists.PlaylistId=playlist_track.PlaylistId
 GROUP BY name
 ORDER BY Nb_tracks DESC;

-- QUERY 3: Is there a difference between the unit price contained in invoice_items and tacks ?
SELECT UnitPrice FROM invoice_items
EXCEPT
SELECT UnitPrice FROM tracks;

-- QUERY 4: Identify the rows where either TrackId or PlaylistId is NULL (PlaylistTrack table).
SELECT * FROM playlist_track
 WHERE PlaylistId IS NULL
    OR TrackId IS NULL;

-- QUERY 5: Group the songs according to the different types of media (use a count) (line count : 5)
SELECT media_types.name, COUNT(*)
  FROM tracks JOIN media_types ON tracks.MediaTypeId=media_types.MediaTypeId
 GROUP BY tracks.MediaTypeId;

-- QUERY 6: Show the number of tracks for each playlist that have more than 100 tracks. (line count : ())
SELECT name, COUNT(*) Nb_tracks
  FROM playlists JOIN playlist_track ON playlists.PlaylistId=playlist_track.PlaylistId
 GROUP BY playlist_track.PlaylistId
HAVING Nb_tracks > 100;

-- QUERY 7: Show the number of tracks for each playlist with an even PlaylistId that have more than 100 tracks. (line count : 2)
SELECT name, COUNT(*) Nb_tracks
  FROM playlists JOIN playlist_track ON playlists.PlaylistId=playlist_track.PlaylistId
 WHERE playlists.PlaylistId%2=0
 GROUP BY playlist_track.PlaylistId
HAVING Nb_tracks > 100;

-- QUERY 8: Join table PlaylistTrack with Playlist (line count : 8715)
SELECT * FROM playlist_track JOIN playlists ON playlists.PlaylistId=playlist_track.PlaylistId;

-- QUERY 9: Join table PlaylistTrack with Playlist without any column duplicate (line count : 8715)
SELECT DISTINCT * FROM playlist_track JOIN playlists ON playlists.PlaylistId=playlist_track.PlaylistId;

-- QUERY 10: Join table PlaylistTrack with Playlist without any column duplicate and using aliases in your code (AS) (line count : 8715)
SELECT DISTINCT * FROM playlist_track JOIN playlists ON playlists.PlaylistId=playlist_track.PlaylistId;

-- QUERY 11: How many track does each playlist have? Show the name of the playlist in your result. (line count : 14)
SELECT name, COUNT(*) Nb_tracks
  FROM playlists JOIN playlist_track ON playlists.PlaylistId=playlist_track.PlaylistId
 GROUP BY playlists.PlaylistId;

-- QUERY 12: Are they albums title whose names are similar to playlists name ?
SELECT title FROM albums
 WHERE title IN (SELECT name FROM playlists);

-- QUERY 13: Count the number of albums for each genre. Order the results by most to least popular genre. (line count : 25)
SELECT genres.name, COUNT(*) Nb_albums
  FROM genres JOIN tracks ON genres.GenreId=tracks.GenreId
 GROUP BY genres.GenreId
 ORDER BY Nb_albums DESC;

-- QUERY 14: Show the same result and add the name of the genre. (line count : 25)
SELECT genres.name, COUNT(*) Nb_albums
  FROM genres JOIN tracks ON genres.GenreId=tracks.GenreId
 GROUP BY genres.GenreId
 ORDER BY Nb_albums DESC;

-- QUERY 15: Count the number of playlists for each genre. Order the results by most to least popular genre. (line count : 25)
SELECT genres.name, COUNT(DISTINCT PlaylistId) Nb_playlists
  FROM genres JOIN (tracks JOIN playlist_track ON tracks.TrackId=playlist_track.TrackId) ON genres.GenreId=tracks.GenreId
 GROUP BY genres.GenreId
 ORDER BY Nb_playlists DESC;

-- QUERY 16: How many different media, genre, tracks, albums and artists are there in this DB (1 request) ?
SELECT 'media' AS 'Object', SUM(MediaTypeId) AS 'Number' FROM media_types
UNION
SELECT 'genres', SUM(GenreId) FROM genres
UNION
SELECT 'tracks', SUM(TrackId) FROM tracks
UNION
SELECT 'albums', SUM(AlbumId) FROM albums
UNION
SELECT 'artists', SUM(ArtistId) FROM artists;

-- QUERY 17: Which playlist or playlists have no tracks? (line count : 4)
SELECT name FROM playlists
 WHERE PlaylistId NOT IN (SELECT PlaylistId FROM playlist_track);