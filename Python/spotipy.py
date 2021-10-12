# codigo para uma interface spotify python
# autor: gustavoovital/spotipy
# data: 12/10/2021

# modulos
import os
import spotipy
from spotipy.oauth2 import SpotifyClientCredentials

# OS definitions
os.environ['SPOTIPY_CLIENT_ID'] = "bd8d58774702476ab5bd6ad6fa53e394"
os.environ['SPOTIPY_CLIENT_SECRET'] = "7bf56064c04f43a78533973cdce7cd02"

kayne_uri = "spotify:artist:5K4W6rqBFWDnAN6FQUkS6x"

spotify = spotipy.Spotify(client_credentials_manager=SpotifyClientCredentials())
results = spotify.artist_top_tracks(kayne_uri)


for track in results['tracks'][:10]:
    print('track    : ' + track['name'])
    print('audio    : ' + track['preview_url'])
    print('cover art: ' + track['album']['images'][0]['url'])
    print("")


