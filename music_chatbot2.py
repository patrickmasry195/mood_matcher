import spotipy
from spotipy.oauth2 import SpotifyClientCredentials
from flask import Flask, request, jsonify
from flask_cors import CORS

# Initialize Flask app
app = Flask(__name__)
CORS(app, resources={
    r"/*": {
        "origins": "*",
        "methods": ["GET", "POST"],
        "allow_headers": ["Content-Type"]
    }
})

# Spotify credentials 
client_id = 'bebce8cb880346e28738c00f14d933f6'
client_secret = '6618b1d293e24d439a70e4f875d23f4a'

print("\nCredentials Debug:")
print(f"Client ID: {'Found' if client_id else 'Missing'}")
print(f"Client Secret: {'Found' if client_secret else 'Missing'}")

if not client_id or not client_secret:
    raise ValueError("Missing Spotify credentials. Please set them manually in the script.")

# Initialize Spotify client
spotify = spotipy.Spotify(
    client_credentials_manager=SpotifyClientCredentials(
        client_id=client_id,
        client_secret=client_secret
    )
)

# Root route to provide API information
@app.route('/', methods=['GET'])
def index():
    return jsonify({
        'status': 'success',
        'message': 'Welcome to the Music Recommendation API',
        'endpoints': {
            '/recommendations': 'GET/POST - Get music recommendations (query parameter for GET, JSON body for POST)',
            '/test': 'GET - Test server and Spotify connection'
        }
    })

@app.errorhandler(404)
def not_found_error(error):
    return jsonify({
        'status': 'error',
        'error': 'Not Found',
        'message': 'The requested URL was not found. Available endpoints: /recommendations (POST), /test (GET)',
        'documentation': 'Visit the root path (/) for API documentation'
    }), 404

@app.errorhandler(405)
def method_not_allowed_error(error):
    return jsonify({
        'status': 'error',
        'error': 'Method Not Allowed',
        'message': f'The method {request.method} is not allowed for this endpoint',
        'allowed_methods': error.valid_methods
    }), 405

def get_recommendations(query):
    try:
        results = spotify.search(q=query, limit=1, type='track,artist')
        recommendations = []
        original_track_name = None
        original_artist_name = None
        if results['tracks']['items']:
            track = results['tracks']['items'][0]
            original_track_name = track['name'].strip().lower()
            original_artist_name = track['artists'][0]['name'].strip().lower()
            try:
                recs = spotify.recommendations(
                    seed_tracks=[track['id']], 
                    limit=5,
                    min_popularity=50
                )
                recommendations = [
                    {
                        'name': rec_track['name'],
                        'artist': rec_track['artists'][0]['name'],
                        'preview_url': rec_track['preview_url'],
                        'spotify_url': rec_track['external_urls']['spotify']
                    }
                    for rec_track in recs['tracks']
                    if not (original_track_name and original_artist_name and rec_track['name'].strip().lower() == original_track_name and rec_track['artists'][0]['name'].strip().lower() == original_artist_name)
                ]
            except Exception as e:
                print(f"Failed to get track recommendations, falling back to artist: {str(e)}")
                artist_id = track['artists'][0]['id']
                top_tracks = spotify.artist_top_tracks(artist_id)
                recommendations = [
                    {
                        'name': top_track['name'],
                        'artist': top_track['artists'][0]['name'],
                        'preview_url': top_track['preview_url'],
                        'spotify_url': top_track['external_urls']['spotify']
                    }
                    for top_track in top_tracks['tracks'][:5]
                    if not (original_track_name and original_artist_name and top_track['name'].strip().lower() == original_track_name and top_track['artists'][0]['name'].strip().lower() == original_artist_name)
                ]
        if not recommendations and results['artists']['items']:
            artist = results['artists']['items'][0]
            top_tracks = spotify.artist_top_tracks(artist['id'])
            recommendations = [
                {
                    'name': track['name'],
                    'artist': track['artists'][0]['name'],
                    'preview_url': track['preview_url'],
                    'spotify_url': track['external_urls']['spotify']
                }
                for track in top_tracks['tracks'][:5]
            ]
        return recommendations
    except Exception as e:
        print(f"Error in get_recommendations: {str(e)}")
        return []

@app.route('/recommendations', methods=['GET', 'POST'])
def recommend():
    if request.method == 'GET':
        query = request.args.get('query', '').strip()
        if not query:
            return jsonify({'error': 'No query provided'}), 400
        processed_query = process_chat_message(query)
        if processed_query['type'] in ['greeting', 'farewell', 'help']:
            return jsonify({
                'recommendations': [],
                'message': processed_query.get('message', '')
            })
        recommendations = get_recommendations(processed_query['query'])
        return jsonify({
            'recommendations': recommendations
        })

    try:
        print("Received recommendation request")

        if not request.is_json:
            return jsonify({'error': 'Content-Type must be application/json'}), 415

        try:
            data = request.get_json(force=True)
        except Exception:
            return jsonify({'error': 'Invalid JSON data'}), 400

        if not isinstance(data, dict):
            return jsonify({'error': 'Invalid request format'}), 400

        query = data.get('query', '').strip()
        if not query:
            return jsonify({'error': 'No query provided'}), 400

        processed_query = process_chat_message(query)

        if processed_query['type'] in ['greeting', 'farewell', 'help']:
            return jsonify({
                'recommendations': [],
                'message': processed_query.get('message', '')
            })

        recommendations = get_recommendations(processed_query['query'])
        return jsonify({
            'recommendations': recommendations
        })
    except Exception as e:
        import traceback
        error_trace = traceback.format_exc()
        print(f"Error: {str(e)}\nTraceback: {error_trace}")
        return jsonify({
            'error': 'Internal server error',
            'message': str(e)
        }), 500

@app.route('/test', methods=['GET'])
def test():
    try:
        spotify.search(q='test', limit=1)
        return jsonify({"status": "Server is running", "spotify": "connected"})
    except Exception as e:
        return jsonify({"status": "error", "details": str(e)}), 500

def process_chat_message(message):
    message = message.lower().strip()

    if any(greeting in message for greeting in ['hello', 'hi', 'hey', 'howdy', 'hola']):
        return {
            'type': 'greeting',
            'message': 'Hello! 🎵 I\'m your music discovery assistant! I can help you find new songs, explore artists, or discover music based on your mood. What would you like to hear today?'
        }

    if any(farewell in message for farewell in ['bye', 'goodbye', 'see you', 'later', 'farewell', 'ciao', 'adios', 'see ya', 'take care']):
        return {
            'type': 'farewell',
            'message': 'Goodbye! 👋 Hope you discover great music. Come back anytime for more recommendations!'
        }

    if 'help' in message:
        return {
            'type': 'help',
            'message': 'I can help you with:\n'
                      '🎵 Music recommendations (e.g. "Find songs like Bohemian Rhapsody")\n'
                      '🎸 Artist discoveries (e.g. "Show me rock bands similar to Queen")\n'
                      '🎧 Mood-based suggestions (e.g. "I need some upbeat music for working out")\n'
                      '🌟 Top tracks (e.g. "What are Taylor Swift\'s most popular songs?")\n'
                      'Just tell me what you\'re looking for!'
        }

    mood_keywords = {
        'happy': ['happy', 'cheerful', 'upbeat', 'joyful', 'energetic'],
        'sad': ['sad', 'melancholy', 'emotional', 'heartbreak'],
        'relaxed': ['relaxing', 'calm', 'peaceful', 'chill', 'meditation'],
        'party': ['party', 'dance', 'club', 'celebration'],
        'workout': ['workout', 'exercise', 'gym', 'running', 'training']
    }

    for mood, keywords in mood_keywords.items():
        if any(keyword in message for keyword in keywords):
            mood_queries = {
                'happy': 'happy upbeat popular',
                'sad': 'emotional ballad',
                'relaxed': 'ambient chill relaxing',
                'party': 'dance party hits',
                'workout': 'workout motivation energy'
            }
            return {
                'type': 'recommendations',
                'query': mood_queries[mood],
                'message': f'Here are some {mood} songs that might match your mood:'
            }

    if any(word in message for word in ['by', 'from', 'artist', 'band']):
        return {
            'type': 'recommendations',
            'query': message,
            'message': 'Here are some recommendations based on that artist:'
        }

    similarity_patterns = [
        'like', 'similar to', 'same as', 'sounds like', 'reminds me of',
        'similar songs', 'songs like', 'music like', 'tracks like'
    ]

    if any(pattern in message for pattern in similarity_patterns):
        query_parts = message.split(' like ', 1)
        if len(query_parts) > 1:
            reference = query_parts[1].strip()
            return {
                'type': 'recommendations',
                'query': reference,
                'message': f'Here are some songs similar to "{reference.title()}":'
            }

        for pattern in ['similar to', 'same as', 'sounds like', 'reminds me of']:
            if pattern in message:
                parts = message.split(pattern, 1)
                if len(parts) > 1:
                    reference = parts[1].strip()
                    return {
                        'type': 'recommendations',
                        'query': reference,
                        'message': f'Here are some songs similar to "{reference.title()}":'
                    }

        return {
            'type': 'recommendations',
            'query': message,
            'message': 'Here are some similar songs you might enjoy:'
        }

    return {
        'type': 'recommendations',
        'query': message,
        'message': 'Here are some songs you might enjoy:'
    }

if __name__ == "__main__":
    try:
        test_search = spotify.search(q='test', limit=1)
        print("Successfully connected to Spotify API!")
        
        port = 8080
        host = '0.0.0.0'
        print(f"\nStarting server...")
        print(f"Server will be available at:")
        print(f"- Local: http://localhost:{port}")
        print(f"- Network: http://{host}:{port}")
        
        app.run(
            host=host,
            port=port,
            debug=True,
            threaded=True
        )
    except Exception as e:
        print(f"\nServer Error: {str(e)}")
