from flask import Flask, render_template, request, Response
import boto3

app = Flask(__name__)

translate_client = boto3.client('translate')
polly_client = boto3.client('polly')

@app.route('/', methods=['GET', 'POST'])
def index():
    translation = None
    if request.method == 'POST':
        source_text = request.form.get('source_text')
        target_language = request.form.get('target_language')
        response = translate_client.translate_text(
            Text=source_text,
            SourceLanguageCode='en',
            TargetLanguageCode=target_language
        )
        translation = response['TranslatedText']
    
    return render_template('index.html', translation=translation)

@app.route('/speech.mp3', methods=['POST'])
def speech():
    source_text = request.form.get('source_text')
    target_language = request.form.get('target_language')
    
    # Translate the text
    translation_response = translate_client.translate_text(
        Text=source_text,
        SourceLanguageCode='en',
        TargetLanguageCode=target_language
    )
    translated_text = translation_response['TranslatedText']
    
    # Synthesize Speech using Amazon Polly
    polly_response = polly_client.synthesize_speech(
        OutputFormat='mp3',
        Text=translated_text,
        VoiceId='Joanna'  # Choose a suitable voice ID
    )
    audio_stream = polly_response['AudioStream']
    
    return Response(audio_stream, mimetype='audio/mpeg')

if __name__ == '__main__':
    app.run(debug=True)


